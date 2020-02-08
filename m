Return-Path: <SRS0=/q0O=34=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF6C35242
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Feb 2020 17:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4CD21741
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Feb 2020 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="lbQCQvnf";
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="lbQCQvnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBHRCV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Feb 2020 12:02:21 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:51008 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbgBHRCV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Feb 2020 12:02:21 -0500
X-Greylist: delayed 4134 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Feb 2020 12:02:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mQWhRt563OEzcJfFaXZLDYfPB7FBaztvhmvHPx6IxXk=;
        b=lbQCQvnfkFPVJg3RNdUQq5qSRFtHdbkLRt0bCSv8+rq7fd9wCs0ouJ1xMXYYW9TY33yy1O68Be1vB9FiYgH1M27qPgXGvE/Wgv5lNglAnQ76v7y27QnD+yB1GBCCM8orV2hprUnLVzQsjs7hAwvcl8J7tJITwaIeM6j7f3RwQBY=;
Received: from [10.161.25.39] (port=45204 helo=smtp62.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <me@prok.pw>)
        id 1j0SQ5-0004Ps-In
        for linux-bluetooth@vger.kernel.org; Sat, 08 Feb 2020 18:53:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mQWhRt563OEzcJfFaXZLDYfPB7FBaztvhmvHPx6IxXk=;
        b=lbQCQvnfkFPVJg3RNdUQq5qSRFtHdbkLRt0bCSv8+rq7fd9wCs0ouJ1xMXYYW9TY33yy1O68Be1vB9FiYgH1M27qPgXGvE/Wgv5lNglAnQ76v7y27QnD+yB1GBCCM8orV2hprUnLVzQsjs7hAwvcl8J7tJITwaIeM6j7f3RwQBY=;
Received: by smtp62.i.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1j0SQ2-0000yf-QE; Sat, 08 Feb 2020 18:53:19 +0300
Date:   Sat, 8 Feb 2020 23:53:15 +0800
From:   Sergey Shatunov <me@prok.pw>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 13d3:3548 Realtek
 8822CE device
Message-ID: <20200208155315.usezcn7qhdyepr66@stan>
References: <1581112454.2855.0@prok.pw>
 <54525F5A-A461-4E40-ACD5-BF2D2755E5C0@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54525F5A-A461-4E40-ACD5-BF2D2755E5C0@holtmann.org>
X-7564579A: B8F34718100C35BD
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2772FB3A37D9F3298222FAD4B3F6E813BF688BCB05C26794D2539A9335381B8936D3C4D3431AB3EDF5364E472313967D9DC3E09A20EA401F0
X-7FA49CB5: 0D63561A33F958A57054BF9DBA2B00F28B7FB42F24B72CA83932D19E17FBFE738941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22493D75B5030B49047576E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8BAE194BC7F2EFB3C23AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C31BC22E60DA9664CB089D37D7C0E48F6C5571747095F342E857739F23D657EF2B6825BDBE14D8E70237733D48D1BA725CBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 8FB30DBD5012A5E0C4BAA8BE6FC1ED4638A2D6919CE68A51ED4311AA1BDC11E052685D71546B8E9E8BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: OK
X-7564579A: EEAE043A70213CC8
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDC4C177971F65D09A0D4068263C9FB3A572CD8F9E67E5CABA75821FE617F967763
X-7FA49CB5: 0D63561A33F958A5FA1AE73217768DB3ACE6ED05D15EA8C303BB9417537B70CF8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22493D75B5030B49047576E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8BAE194BC7F2EFB3C23AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C31BC22E60DA9664CB089D37D7C0E48F6C5571747095F342E857739F23D657EF2B6825BDBE14D8E70237733D48D1BA725CBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005DCCD83CE6875A18ECD1C3900D887C3C7D4068263C9FB3A575F9045B74F665CC88BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: OK
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> this patch doesn’t apply. I think your mailer mangled the whitespaces / tabs.
Indeed, my mailer corrupt some spaces, resending patches (hopefully correctly)
---
The ASUS FX505DV laptop contains RTL8822CE device with an
associated BT chip using a USB ID of 13d3:3548.
This patch add fw download support for it.

T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3548 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Sergey Shatunov <me@prok.pw>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..fa207b715012 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -387,6 +387,7 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Additional Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.25.0


