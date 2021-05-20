Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCAC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEFB600D1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhETPOH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 11:14:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45252 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhETPOF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 11:14:05 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 79EE7CECEA;
        Thu, 20 May 2021 17:20:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: Add a new QCA_ROME device (0cf3:e500)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518172546.304882-1-dlenski@gmail.com>
Date:   Thu, 20 May 2021 17:12:41 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2F990AA6-1E20-4A18-8692-21BC8F051BFB@holtmann.org>
References: <20210518172546.304882-1-dlenski@gmail.com>
To:     Daniel Lenski <dlenski@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> This patch adds the 0cf3:e500 Bluetooth device (from a QCA9377 board) as a
> QCA_ROME device.  It appears to be functionally identical to another device
> ID, also from a QCA9377 board, which was previously marked as QCA_ROME in
> 0a03f98b98c201191e3ba15a0e33f46d8660e1fd
> ("Bluetooth: Add a new 04ca:3015 QCA_ROME device").
> 
> Without this patch, the WiFi side of the QCA9377 board is slow or unusable
> when the Bluetooth side is in use.
> 
> See https://askubuntu.com/a/1137852 for another report of QCA_ROME fixing
> this issue for this device ID.
> 
> /sys/kernel/debug/usb/devices:
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e500 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Daniel Lenski <dlenski@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

