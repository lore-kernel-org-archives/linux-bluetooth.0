Return-Path: <SRS0=Lh13=V5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4AC19759
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8E620679
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmP9VKy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfHAOKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:10:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45557 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbfHAOKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Aug 2019 10:10:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so65400475qtp.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2019 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iNu9HWXt2MFmvfy0bjRx7AEKi/fagkyH11OBfo5fNS4=;
        b=OmP9VKy/V6puYbzj/tTeJWOWWpecQ4hEvvgEfy9leSBHTop1AJ/Yi8G2Z2bYUKZPp5
         lfSlZcTtkY2/ge63tzvRRsrLZAuyifF0twQBLYtjnTqwG18ydFU4l72aCRyqUlBdSXDc
         MldRG3pP9vFylGXmOH80BlP5yfILyMGwSQVmBSVjBpAb7pVsJB42xnm5vw2UKmDSpN0b
         ICFN+ddvk/t1nmfKW7EeikylVqe/95fDQcR4V6N2Y9CJF1qatZa/u/SJI7NSsATN9lca
         2AaJ/KE3vs8d0E7We3MVcy8XmlMvlq7FhG/LCQ3bnvmEfI9L/rL12vSYRbktd2FHlPzt
         ksjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iNu9HWXt2MFmvfy0bjRx7AEKi/fagkyH11OBfo5fNS4=;
        b=WAVd5bQBDKYdFCvd0enftn+mUcnhCWvQQVpqo4Y7krJwpMjQt+bWM6RtEsCZ9J5vOz
         x433I8i0LCjS4jyA6cphWwfmPSU4DLGQ9aVNZW40xd4bWSwRFJfRej/FZsYCxt31FhGt
         rQ+iDNMSIOcyAbiFcePGzMo22oOpf4KoDpPM0ighwXWmLOXh+M8FMKKUMRS4itTq7UJq
         sD94KfsCpMy7sMKWPtVSZLQMRB+ITDcY8GO1cieCW/vrBeBT9RjfJ7MNQzvUQC5TRNUw
         b6FOL3b8T6G6o/ehwGW6BXitTTx0wnC5lky1uRJnucpgFzABm8Jy2Paj5mAHvhMGnBCX
         ScdA==
X-Gm-Message-State: APjAAAXMNq5rWfWItfjwTY8PRxc9nDzlI/UeIacdMJBzaKasDdG12EgE
        xH6XO1L23tU+wsMjE0SlSOaK0dYnE1lRw2UiHBWNBlbIyJk=
X-Google-Smtp-Source: APXvYqy2A4SlzBMUbXF9GCEij+O3JMv6Srrzhl4ARuSZi/r5h4v/dgdJMoMsTnfj50R1Cv1W6AqekxjihkcnTa/5qw0=
X-Received: by 2002:a0c:9e27:: with SMTP id p39mr92256844qve.151.1564668616110;
 Thu, 01 Aug 2019 07:10:16 -0700 (PDT)
MIME-Version: 1.0
From:   Axelle <aafortinet@gmail.com>
Date:   Thu, 1 Aug 2019 16:10:05 +0200
Message-ID: <CANKzOHAsWzZR3aXWnh9-bYJoO=d124KD+C5gPmot5fMfEH_G9Q@mail.gmail.com>
Subject: Pairing request ends in timeout
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello list,

I (again) face problems pairing with a BLE device.

Using bluetoothctl (v5.50), I connected to the device (connect).  Then
I try to pair but it fails (org.bluez.Error.AuthenticationCanceled).
The hcidump show a connection timeout.

NB:
- I have a registered agent (although I do not think it is useful in my case)
- I am using Linux Mint 19.1. The same error occurs on a Raspberry Pi
3 with Raspbian.
- I have some bluez distrib packages v5.48 installed. Can this be an issue?
- I got this to work a while ago with the help of someone of bluez on
IRC, doing power off/power on, but this is not working this time...

Thanks

-- Axelle

What bluetoothctl says:

[D2A74C76F3E0]# pair D2:A7:4C:76:F3:E0
Attempting to pair with D2:A7:4C:76:F3:E0
[CHG] Device D2:A7:4C:76:F3:E0 ServicesResolved: no
[CHG] Device D2:A7:4C:76:F3:E0 Connected: no
Failed to pair: org.bluez.Error.AuthenticationCanceled

The corresponding hcidump shows that the connection times out:

< ACL data: handle 71 flags 0x00 dlen 11
    SMP: Pairing Request (0x01)
      capability 0x04 oob 0x00 auth req 0x2d
      max key size 0x10 init key dist 0x0d resp key dist 0x0f
      Capability: KeyboardDisplay (OOB data not present)
      Authentication: Bonding (MITM Protection)
      Initiator Key Distribution:  LTK  CSRK
      Responder Key Distribution:  LTK IRK CSRK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 71 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 71 reason 0x08
    Reason: Connection Timeout
