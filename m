Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A17C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 00:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357817AbiATA3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 19:29:52 -0500
Received: from omta001.cacentral1.a.cloudfilter.net ([3.97.99.32]:40762 "EHLO
        omta001.cacentral1.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237314AbiATA3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 19:29:51 -0500
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id A9g5ncsUz5Rf1ALKonZivr; Thu, 20 Jan 2022 00:29:50 +0000
Received: from cartman.1045.ca ([24.79.8.194])
        by cmsmtp with ESMTPA
        id ALKmnJ5Zna4s1ALKnn46lm; Thu, 20 Jan 2022 00:29:50 +0000
Authentication-Results: ; auth=pass (LOGIN) smtp.auth=link_outgoing@shaw.ca
X-Authority-Analysis: v=2.4 cv=S9vKfagP c=1 sm=1 tr=0 ts=61e8acfe
 a=R6DsPnAC7HDsLjZ8I5uN0A==:117 a=R6DsPnAC7HDsLjZ8I5uN0A==:17
 a=IkcTkHD0fZMA:10 a=DghFqjY3_ZEA:10 a=yNFEYGdLAAAA:8 a=xxwifyztyXyHRhQYO1EA:9
 a=QEXdDO2ut3YA:10 a=Zh8OHTSCxmIxSlm4XFhg:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=1045.ca; s=mail;
        t=1642638588; bh=4xDf0H0witiD23Jf2zu0FeNyFKnxJMvFfCJINuTCDSo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F/nibA2UgO/ECy3vdeLrSn8Y+EzYrDHObym6NYztu1OUKPVgmRdfdMuM/4eBiWeDA
         H1Sa3JrimPk2tLrVl3KUwxa/4V2l0FgschYgBztBWpT6+BO6KYMgmhr40/TOdhzpTz
         Cs6qn0RrhYissKVA4Uth9h8s60GWcUgDYua+Sxb+udDluQpZhIQNPvP9QBr6P2Pq5j
         q+2eYasaghVxDvHU7923Nh9YPI4pKcixsh8aX47cUip8HV38pyRatXJk2VS76pZekI
         bHXg/w1AqDqwWFgVlrsjydprE9i+UJsm1tPoeO7t8RJdxStdfAnQeZ8xE0o9/HP5JW
         xIkr9Vjd0Vqpw==
Received: from [192.168.1.155] (bruce486DX.1045.ca [192.168.1.155])
        by cartman.1045.ca (Postfix) with ESMTPSA id EB9E9139BB4;
        Wed, 19 Jan 2022 18:29:47 -0600 (CST)
Message-ID: <8584a65b-8baa-c576-7a7d-e48785f7441a@1045.ca>
Date:   Wed, 19 Jan 2022 18:29:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Bluetooth: Add support for Realtek 8761BU Bluetooth
 receivers of ID 2550:8761
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <c821e1bd-dcee-fa4b-93c3-29279756315d@1045.ca>
 <5C1D232A-F174-44F3-897D-5F8A3A50CF8F@holtmann.org>
From:   Bruce Link <bruce@1045.ca>
In-Reply-To: <5C1D232A-F174-44F3-897D-5F8A3A50CF8F@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFZd7SEBOainvVwsNIYttzBuWWsISakvsy3Wbw5bjNYTKccyg+d6b5zFJ2lDVg6qxgJ5V+TIbC43bjXw3JkZszJUyxQYFl/P8XeZnia7asqnMhnDQ062
 kmrpkzaC72+f7NMVYOQzPcA9bWqh3FovDF93PP+rqh8VSX4d5pY3ztFHqUjpH3qILMxbaSmmT7wPq7KUcis2dE+puQo5ioDEno7x6h1oohB84R4yYwkf/X6E
 MzcSx3c8Ha6CbC7urBJ4bpZJr2VHJC5JG20X/uiVZFPBr3p7fJN1o7KaLt7Po8hc2b1z9DGMojIVSR+n4jKKLV8TaWJYxUTUsvzWezOdBEU=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Marcel,

 > Hi Bruce,
 >
 >> Add support for Realtek 8761BU Bluetooth receivers of ID 2550:8761 by
 >> adding the appropriate ID to btusb.c to cause firmware to load.
 >> e.g.: EDUP EP-B2536, MPOW BH519A, MPOW BH456A

The portion of /sys/kernel/debug/usb/devices pertaining to this device is:

T:  Bus=02 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  7 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2550 ProdID=8761 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C239987
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

 >>
 >> Signed-off-by: Bruce Link <bruce@1045.ca>
 >> ---
 >> N.B. I am able to successfully test this patch on my own system, but
 >> cannot meet the requirement of 4 other systems due to lack of
 >> availability. I hope this is acceptable given the small scope of the
 >> patch.

Also, it appears I may have duplicated the effort of Jack Murray at
msg96364

drivers/bluetooth/btusb.c | 3 +++
1 file changed, 3 insertions(+)
 >>
 >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
 >> index c30d131da784..16254681e162 100644
 >> --- a/drivers/bluetooth/btusb.c
 >> +++ b/drivers/bluetooth/btusb.c
 >> @@ -482,6 +482,9 @@ static const struct usb_device_id 
blacklist_table[] = {
 >>         /* Additional Realtek 8761BU Bluetooth devices */
 >>         { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
 >> BTUSB_WIDEBAND_SPEECH },
 >> +       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 >> + BTUSB_WIDEBAND_SPEECH },
 >> +
 >>
 >>         /* Additional Realtek 8821AE Bluetooth devices */
 >>         { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 >
 > please provide a patch that is garbled and include usb/devices info.
 >
 > Regards
 >
 > Marcel
 >
Apologies for the omissions. This is my first rodeo.

Bruce

