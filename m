Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE1C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 09:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBIJTI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBIJSn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Feb 2023 04:18:43 -0500
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FBB5EF98
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Feb 2023 01:18:23 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4PCB9j0cfgz9tKX;
        Thu,  9 Feb 2023 10:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
        t=1675934297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3kNtBr2+7P3W6f3QhKbTd11dg1g/UYenh/8en8Ee4g=;
        b=aiPG6PLnTAiAscwAEgVCxLzNBnoaU00RtXnr/6LRazGahajF6E1SK21u2YeqK+6Mha82EN
        tEIBsuswI/qYppsFSR83ItFNYEfvTq4hELNG//sVEjXZJdA6n/kSP5CyJBmgyothztGYgv
        HSv3KkQSjAvq9CF7TmNJ8Z1fm2ap1UKJoDzEoy/y0+AkSWhqJNHXDiNGUXxbTGJvVrdhJZ
        G7GRqy8aAb8u0aB+7naykwA+/LxoJRvux8PryG9c2vtSsiKiQhsMt5iyg6jxAYYUd+lcsS
        R5P+GS+nSFM125VWDqBxNtNsBQsJVcR53Yl9Tgxcay3bh2SFNRX+uv56CPAAuA==
Message-ID: <56921851-be55-1380-2185-111335edaeb0@tavla.de>
Date:   Thu, 9 Feb 2023 10:18:15 +0100
MIME-Version: 1.0
Subject: Re: How to Automatically Re-Connect Bluetooth HID over GATT (HOG)
 Device when BlueZ Plugin "hog" is Disabled
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <6950dd49-7436-ebef-eb88-940597472ce1@tavla.de>
 <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
From:   Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <CABBYNZJMcEX6-9nQgoYccc7W=yEetNjjCMXSzP=Aa-4r4X_puw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Am 01.02.23 um 22:37 schrieb Luiz Augusto von Dentz:
> Hi Martin,
>
> On Wed, Feb 1, 2023 at 1:25 PM Martin Petzold <martin.petzold@tavla.de> wrote:
>> Hi,
>>
>> Linux 5.10, BlueZ 5.55
>>
>> I have a remote control which implements Bluetooth LE. If I use the
>> default Bluetooth daemon, I am able to pair and trust using
>> bluetoothctl. If the connection is lost after a while (or days) and a
>> button on the remote control is pressed, the daemon re-connects
>> automatically (because the device is paired). This is basically what I need.
>>
>> But, I would also like to manually set notifying for characteristics
>> (Report) on the HID service within my application (Java via d-bus). This
>> is not possible anymore (also not via bluetoothctl) because the "hog"
>> (or "input") plugin manages the input device and the related HID
>> services are now hidden.
>>
>> I then added "--noplugin=input,hog" to my Bluetooth daemon. Which is
>> okay, because I don't need this support for Kernel HID. Great, now the
>> HID services are available (also using bluetoothctl), but the peripheral
>> does not re-connect automatically any more. I always have to connect
>> manually first. I also have no signal on the d-bus when I press the
>> button of the remote control, when it is disconnected.
>>
>> How can I enable automatic re-connect for devices, when these plugins
>> are disabled?
>>
>> The only other way I was thinking of is to leave the "hog" plugin
>> enabled and use the operating system HID interface. However, my
>> application runs as non-root which makes it complicated and also I would
>> like to have direct connection and control to my device.
> https://github.com/bluez/bluez/blob/master/doc/gatt-api.txt#L390
>
Thanks, I have implemented and registered the HID profile using 
org.bluez.GattProfile1 and now the device (remote control) re-connects 
automatically.

However, when I enable notifying on the Report characteristics of the 
HID service after I received the first device properties update (with 
services resolved), I miss the first Report event. If I press a button, 
the remote re-connects and dbus events for device properties updated are 
fine, but I don't have a Report event. If I then press again, I do get a 
Report event, because I set notifying on the Report characteristics. 
Setting notify seems to be too late.

What is the trick to get also the first button pressed as a Report 
characteristic event?

At the moment I only have the HID service 
(00001812-0000-1000-8000-00805f9b34fb) in the properties map of the 
org.bluez.GattProfile1.

Thanks,

Martin

-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

