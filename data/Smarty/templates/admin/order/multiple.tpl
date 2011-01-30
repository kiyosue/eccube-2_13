<!--{*
/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2010 LOCKON CO.,LTD. All Rights Reserved.
 *
 * http://www.lockon.co.jp/
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */
*}-->
<!--{include file="`$smarty.const.TEMPLATE_ADMIN_REALDIR`admin_popup_header.tpl"}-->

<script type="text/javascript">
<!--
self.moveTo(20,20);self.focus();
$(function() {

    var product_class_id = window.opener.jQuery('input[id^=product_class_id_]');
    var product_code = window.opener.jQuery('input[id^=product_code_]');
    var product_name = window.opener.jQuery('input[id^=product_name_]');
    var classcategory_name1 = window.opener.jQuery('input[id^=classcategory_name1_]');
    var classcategory_name2 = window.opener.jQuery('input[id^=classcategory_name2_]');
    var price = window.opener.jQuery('input[id^=price_]');
    var quantity = window.opener.jQuery('input[id^=quantity_]');
    var shipping_id = window.opener.jQuery('input[id^=shipping_id_]');
    var shipping_name01 = window.opener.jQuery('input[name^=shipping_name01_]');
    var shipping_name02 = window.opener.jQuery('input[name^=shipping_name02_]');
    var shipping_pref = window.opener.jQuery('select[name^=shipping_pref_] option:selected');
    var shipping_addr01 = window.opener.jQuery('input[name^=shipping_addr01_]');
    var shipping_addr02 = window.opener.jQuery('input[name^=shipping_addr02_]');

    var index = 0;
    for (var i = 0; i < product_class_id.length; i++) {

        for (var j = 0; j < $(quantity[i]).val(); j++) {

            // 商品規格ID
            var idfield = $('<input type="hidden" />')
                .attr({'name': 'multiple_product_class_id' + index})
                .val($(product_class_id[i]).val());

            // 商品コード
            var codefield = $('<input type="hidden" />')
                .attr({'name': 'multiple_product_code' + index})
                .val($(product_code[i]).val());

            // 商品名
            var namefield = $('<input type="hidden" />')
                .attr({'name': 'multiple_product_name' + index})
                .val($(product_name[i]).val());

            // 規格1
            var class1field = $('<input type="hidden" />')
                .attr({'name': 'multiple_classcategory_name1' + index})
                .val($(classcategory_name1[i]).val());

            // 規格2
            var class2field = $('<input type="hidden" />')
                .attr({'name': 'multiple_classcategory_name2' + index})
                .val($(classcategory_name2[i]).val());

            // 単価
            var pricefield = $('<input type="hidden" />')
                .attr({'name': 'multiple_price' + index})
                .val($(price[i]).val());


            // 数量
            var qfield = $('<input type="text" />')
                .attr({'name': 'multiple_quantity' + index,
                       'size': 4})
                .val(1);

            // 数量と hidden を設定
            var q = $('<td />').addClass('center')
                .append(idfield)
                .append(codefield)
                .append(namefield)
                .append(class1field)
                .append(class2field)
                .append(pricefield)
                .append(qfield);

            // お届け先
            var select = $('<select />').attr('name', 'multiple_shipping' + index);
            var s = $('<td />').append(select);

            // 行を生成
            var tr = $('<tr />')
                .append($('<td />').text($(product_code[i]).val()))
                .append($('<td />').text($(product_name[i]).val()))
                .append(q)
                .append(s);

            jQuery(tr).appendTo('tbody');
            index++;
        }
    }

    // プルダウンを生成
    for (var i = 0; i < shipping_id.length; i++) {
        var text = $(shipping_name01[i]).val() + $(shipping_name02[i]).val()
            + ' ' + $(shipping_pref[i]).text()
            + $(shipping_addr01[i]).val() + $(shipping_addr02[i]).val();
        var option = $('<option />')
            .val($(shipping_id[i]).val())
            .text(text);
        $('select').append(option);
    }
});

function func_submit() {
    var err_text = '';
    var fm = window.opener.document.form1;

    fm.mode.value = 'multiple_set_to';
    fm.anchor_key.value = 'shipping';

    var div = $('<div />');
    $('input[name^=multiple_], select[name^=multiple_]').each(function() {
        // TODO タグをベタ書きにしないと, innerHTML で value が空になってしまう
        $(div).append('<input type="text" name="'
                      + $(this).attr('name')
                      + '" value="' + $(this).val() + '" />');
    });
    $(div).append('<input type="hidden" name="multiple_size" value="' + $('input[name^=multiple_product_class_id]').length + '" />');

    // window.opener に対する append は IE で動作しない
    window.opener.jQuery('#multiple').html(div.html());
    fm.submit();
    window.close();
    return true;
}
//-->
</script>

<!--▼検索フォーム-->
<form name="form1" id="form1" method="post" action="<!--{$smarty.server.REQUEST_URI|h}-->">
<input name="mode" type="hidden" value="search" />
<input name="anchor_key" type="hidden" value="" />
<input name="search_pageno" type="hidden" value="" />
<input name="no" type="hidden" value="<!--{$tpl_no}-->" />
<table summary="配送情報" class="list">
  <thead>
    <tr>
      <th>商品コード</th>
      <th>商品名/規格1/規格2</th>
      <th>数量</th>
      <th>お届け先</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
<div class="btn-area">
  <ul>
    <li><a class="btn-action" href="javascript:;" onclick="func_submit(); return false;"><span class="btn-next">決定</span></a></li>
  </ul>
</div>
</form>
<!--{include file="`$smarty.const.TEMPLATE_ADMIN_REALDIR`admin_popup_footer.tpl"}-->