Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC39C761A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjC3SZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjC3SZh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:25:37 -0400
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 11:25:35 PDT
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [IPv6:2001:67c:2050:102:465::105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC798D517
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:25:35 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4PnWnZ5KVjz9tkR;
        Thu, 30 Mar 2023 20:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
        t=1680200162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpjQgMlCxvz1aRknvywc/KB47S0KCt76gMfJAksNes4=;
        b=vvhkOKmKKZIxsCw6x7pCPSdTBXhpHYmRy1X96FQ2FpNfAMa/rVPjGeGimzbgPGSu3L45af
        e5aGHjw/5dCQNJmy955790R7hY+TTwh1/4quXY2PS1KZH4Sb2j1EkEC/BH9317tVOLbyVP
        ppCvmAuupDDJAWCNBU3iH+dqoUa9pgZlq2rrBtyOcg1ZdJbu0QX8tNLBmui8qbQhmM9eGW
        Mw99eQejOSfKv7zAipaVdJHkNMZEZUkx2mWLyDdk1GxzEuxGfBhgaZkmVU0MWl3Ll0mIN9
        /VvXWZePxKLrHqJ7Q25QlhphZucpUvCl0BI7lPqB8FnvjtTtvWD2OusUKY4OKw==
Message-ID: <96ab0304-09e0-7bd9-944c-09ab03a21b67@tavla.de>
Date:   Thu, 30 Mar 2023 20:16:01 +0200
MIME-Version: 1.0
Subject: Re: How to Automatically Re-Connect Bluetooth HID over GATT (HOG)
 Device when BlueZ Plugin "hog" is Disabled
Content-Language: en-GB
From:   Martin Petzold <martin.petzold@tavla.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
 <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
 <56921851-be55-1380-2185-111335edaeb0@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <56921851-be55-1380-2185-111335edaeb0@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,

I now have another issue with remote control HID integration 
(non-system; direct implementation).

I am using Java with d-bus BlueZ 5.55 on Debian Linux. I have "hid" and 
"input" plugin disabled on bluetooth startup.

I have one remote integrated and working. With this one after boot and 
while application startup I iterate over all paired devices with 
existing HID service (check for existing service UUID) and then iterate 
all Report characteristics and enabling notifying for all of them (if 
supported). Everything is running well with this (legacy) remote. After 
pairing it also auto-connects using my own registered object manager, as 
suggested by you.

Now we received our final custom remote control from our manufacturer 
(other chip) and this approach does not work any more. I have tried a 
lot of things now. Once the remote control is paired (which is also 
somehow still buggy) and I rebooted the system with our application, the 
device is found in the list as paired, BUT I cannot access the HID 
service any more. Therefore, I cannot enable notifying for this remote.

What I realized is, that this remote control seems to have something 
like MAC address randomization enabled (probably for security reasons). 
It also does not propagate device information unless I start pairing 
mode. Because of MAC address randomization it also seems that pairing is 
buggy - only works sometimes with some special procedure.

I know this remote works, because if I connected in manually via 
bluetoothctl sometimes I works with enabling of notifying. Also directly 
after pairing it seemed to work.

Have you seen something like this before? What should I do?

Thanks,

Martin

Am 09.02.23 um 10:18 schrieb Martin Petzold:
> Hi Luiz,
>
> Am 01.02.23 um 22:37 schrieb Luiz Augusto von Dentz:
>> Hi Martin,
>>
>> On Wed, Feb 1, 2023 at 1:25 PM Martin Petzold 
>> <martin.petzold@tavla.de> wrote:
>>> Hi,
>>>
>>> Linux 5.10, BlueZ 5.55
>>>
>>> I have a remote control which implements Bluetooth LE. If I use the
>>> default Bluetooth daemon, I am able to pair and trust using
>>> bluetoothctl. If the connection is lost after a while (or days) and a
>>> button on the remote control is pressed, the daemon re-connects
>>> automatically (because the device is paired). This is basically what 
>>> I need.
>>>
>>> But, I would also like to manually set notifying for characteristics
>>> (Report) on the HID service within my application (Java via d-bus). 
>>> This
>>> is not possible anymore (also not via bluetoothctl) because the "hog"
>>> (or "input") plugin manages the input device and the related HID
>>> services are now hidden.
>>>
>>> I then added "--noplugin=input,hog" to my Bluetooth daemon. Which is
>>> okay, because I don't need this support for Kernel HID. Great, now the
>>> HID services are available (also using bluetoothctl), but the 
>>> peripheral
>>> does not re-connect automatically any more. I always have to connect
>>> manually first. I also have no signal on the d-bus when I press the
>>> button of the remote control, when it is disconnected.
>>>
>>> How can I enable automatic re-connect for devices, when these plugins
>>> are disabled?
>>>
>>> The only other way I was thinking of is to leave the "hog" plugin
>>> enabled and use the operating system HID interface. However, my
>>> application runs as non-root which makes it complicated and also I 
>>> would
>>> like to have direct connection and control to my device.
>> https://github.com/bluez/bluez/blob/master/doc/gatt-api.txt#L390
>>
> Thanks, I have implemented and registered the HID profile using 
> org.bluez.GattProfile1 and now the device (remote control) re-connects 
> automatically.
>
> However, when I enable notifying on the Report characteristics of the 
> HID service after I received the first device properties update (with 
> services resolved), I miss the first Report event. If I press a 
> button, the remote re-connects and dbus events for device properties 
> updated are fine, but I don't have a Report event. If I then press 
> again, I do get a Report event, because I set notifying on the Report 
> characteristics. Setting notify seems to be too late.
>
> What is the trick to get also the first button pressed as a Report 
> characteristic event?
>
> At the moment I only have the HID service 
> (00001812-0000-1000-8000-00805f9b34fb) in the properties map of the 
> org.bluez.GattProfile1.
>
> Thanks,
>
> Martin
>
