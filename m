Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A3C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6706217BA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="HmsAECuB";
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="HmsAECuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBGVyZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:54:25 -0500
Received: from fallback12.mail.ru ([94.100.179.29]:37922 "EHLO
        fallback12.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBGVyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 16:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Type:MIME-Version:Message-Id:Cc:To:Subject:From:Date; bh=TyjR/RGbFLKzbl4cjXM7D+zhgcAe8kQTWKH+I0BwKFs=;
        b=HmsAECuB9kbu5BkXeCnb2jdkj6/6zQI5QIjkxSV9FMXGDpCIMIWVNn5sWC7jnFyhiT5eA4cgBidTSRO0BEYMKu+/+lpqf80t8cUmPOZ84UypsGqeeOvx1RXi4sdLxLdurOczWPsBpQ5xQtFg3/nIr+2N2NZm6ERmdq/pRnKu0t0=;
Received: from [10.161.64.54] (port=44482 helo=smtp46.i.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <me@prok.pw>)
        id 1j0BZu-0007NA-6d
        for linux-bluetooth@vger.kernel.org; Sat, 08 Feb 2020 00:54:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Type:MIME-Version:Message-Id:Cc:To:Subject:From:Date; bh=TyjR/RGbFLKzbl4cjXM7D+zhgcAe8kQTWKH+I0BwKFs=;
        b=HmsAECuB9kbu5BkXeCnb2jdkj6/6zQI5QIjkxSV9FMXGDpCIMIWVNn5sWC7jnFyhiT5eA4cgBidTSRO0BEYMKu+/+lpqf80t8cUmPOZ84UypsGqeeOvx1RXi4sdLxLdurOczWPsBpQ5xQtFg3/nIr+2N2NZm6ERmdq/pRnKu0t0=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1j0BZp-0004Qg-6H; Sat, 08 Feb 2020 00:54:18 +0300
Date:   Sat, 08 Feb 2020 05:54:14 +0800
From:   Sergey Shatunov <me@prok.pw>
Subject: [PATCH] Bluetooth: btusb: Add support for 13d3:3548 Realtek 8822CE
 device
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Message-Id: <1581112454.2855.0@prok.pw>
X-Mailer: geary/3.34.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-7564579A: 78E4E2B564C1792B
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2772FB3A37D9F32984C71E1CC1B48DA16F688BCB05C26794D4E6B314396EDB1E3309A4477F54F7B8FAC0955AC946F9B5668939298A824F05D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE745C0EDBD94D46193EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E00859DD2B9ABE7B8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC02593C0E0E11E1E4305B80522D22868EEA02E2E0DA74F0F5389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0DEC8C2C8BCD2534D8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3E97D2AE7161E217F117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947CFBBF6D3A4198F0AF302FCEF25BFAB3454AD6D5ED66289B52E1A3F18E62937ED6302FCEF25BFAB345725E5C173C3A84C302C9A5A762CE99BDBA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3522CA9DD8327EE4933F735096452955E3D2457FAF19517CF2C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F9A3D58A9A349F5073B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 8FB30DBD5012A5E0F8DD91FE6246306CB3D3739E16D37B7742A1AE927C158FC3951A21FE2E6BE567DDD964020EFBB07D027D9DD7AE85109531CA6688BB30A5B47A93073D7E3D38797B58C9710036D86A67EA787935ED9F1B
X-Mras: OK
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDCC2EAB853CDEF5717533D8F7850B0E40DCF3878852476F7B0A2F4C925627A32F5
X-7FA49CB5: 0D63561A33F958A5FEC8C01B143F58E9D62D43B45547828525D46E602E69E6D78941B15DA834481FA18204E546F3947C989FD0BDF65E50FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B60CDF180582EB8FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22497F378122B062093B76E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8B42D492BDE3C795E73AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3D12A30AAA9C65F1C35872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C975FAC89DD1A0FDCBE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005C3FADA55C8765CC317F91E769ACB28CF533D8F7850B0E40DC9F871340C5A6C408BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: OK
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ASUS FX505DV laptop contains RTL8822CE device with an
associated BT chip using a USB ID of 13d3:3548.
This patch add fw download support for it.

T: Bus=03 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3548 Rev= 0.00
S: Manufacturer=Realtek
S: Product=Bluetooth Radio
S: SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms

Signed-off-by: Sergey Shatunov <me@prok.pw>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..fa207b715012 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -387,6 +387,7 @@ static const struct usb_device_id blacklist_table[] 
= {

  /* Additional Realtek 8822CE Bluetooth devices */
  { USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
+ { USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },

  /* Silicon Wave based devices */
  { USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.25.0



