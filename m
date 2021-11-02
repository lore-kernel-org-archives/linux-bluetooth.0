Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149A160D42
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 08:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBIqT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:46:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35665 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBIqT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 04:46:19 -0400
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 556B6CECEA;
        Tue,  2 Nov 2021 09:43:43 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: Is there a way to force legacy LE pairing for a device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
Date:   Tue, 2 Nov 2021 09:43:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0CC57655-ABBE-49A9-88F2-92AE313B7968@holtmann.org>
References: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
To:     Jacek Konieczny <jajcus@jajcus.net>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jacek,

> I have a problem connecting to a BT device from a Linux desktop –
> pairing fails, while an Android phone pairs properly.
> 
> The obvious difference in the btsnoop logs is in the pairing request.
> 
> Android:
> < ACL Data TX: Handle 65 flags 0x00 dlen 11
> 
> 
> #995 150.491086
>      SMP: Pairing Request (0x01) len 6
>        IO capability: KeyboardDisplay (0x04)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, MITM, Legacy, No Keypresses
> (0x05)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey IdKey Sign (0x07)
>        Responder key distribution: EncKey IdKey Sign (0x07)
> [...]
>> ACL Data RX: Handle 65 flags 0x02 dlen 11
> 
> 
> #1006 150.571137
>      SMP: Pairing Response (0x02) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, Legacy, No
> Keypresses (0x01)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey (0x01)
>        Responder key distribution: EncKey (0x01)
> 
> 
> And on Linux:
> < ACL Data TX: Handle 16 flags 0x00 dlen 11               #53 [hci0]
> 132.273100
>      SMP: Pairing Request (0x01) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses,
> CT2 (0x29)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey Sign LinkKey (0x0d)
>        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
> [...]
>> ACL Data RX: Handle 16 flags 0x02 dlen 6                #57 [hci0]
> 132.362160
>      SMP: Pairing Failed (0x05) len 1
>        Reason: Invalid parameters (0x0a)
> 
> 
> 
> So it looks like 'Bonding, MITM, Legacy, No Keypresses' used by Android
> works and 'Bonding, No MITM, SC, No Keypresses, CT2' used by the desktop
> Linux (bluez 5.62, kernel '5.6.2-050602-lowlatency' from Ubuntu) does
> not (note: I am still quite ignorant about Bluetooth stuff).
> 
> So my question is: is there any way to force using legacy pairing? Even
> if that requires bluez or kernel patching (though, I would rather avoid
> that).
> 

you can use btmgmt tool from bluez.git to force Secure Connections off. I am not sure if that sticks when starting bluetoothd, but then you need to hack it out there.

I am really not sure how your device can be a qualified Bluetooth device and fail here. The handling of the flags has actually proper test cases to ensure that this does’t happen. And I remember that even Android switched to Secure Connections support at some point.

Regards

Marcel

