Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F36C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 20:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4631664DF5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhA1UCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA1UA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 15:00:26 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D58C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 11:48:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t14so4991661qto.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyPV6qmsEV7zokJMKlpqVlxlCOQuEEUI/JHLoDpAHWU=;
        b=idygh/OuscUlWpsthpxGeqz5JuUykyutFUxv8Xd2MvZyhzLzgqAz3raurh4SHW9J60
         5LgKrgewzCf8jBgOuwsUFNkOGNVfk03wmg08bKhF9Se2UDdMMn95hBtEsU87naIaJVNh
         ad6JXRhXId1mtyKHWkvyk1P9cfg3TYswFMHSbUUK9K7HP9lYjva8eatkuRQ1tGYrHOYN
         +7WqRgN6ONFR6zvyILmWqdjviV+Xl6npIpWwz5ZvInRIeDkbgUxi1oOWzngqRMPJhuHB
         D1Yij4X6VCuyByQreFfmOLUON9UQaF+7Ip1U6a7S/qYTaXnBQ/U2bmo1/23gvIDDYlZl
         6Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyPV6qmsEV7zokJMKlpqVlxlCOQuEEUI/JHLoDpAHWU=;
        b=ERraTbtm/OgBZ/txUYWipdPTvoCgg9gfVpJF1nUaXvejOMq6F3grfnn8nmxlNg3kUq
         vfhAPak18MNxsFeJdN13qeyZrlXfh9AHHK+IU7YMEjnCiXnIQFRwTeffZVDnMke0BenS
         aWiUlDQoTWGk2VIQBIVq7n/iCdxwXHRGFG91ksR306kV8oVqY9vTZQ9RvQhDMqHa+ff2
         b0XpxS/CrGh6gToxweQ9PD3lpgVnK4g+bdXsKF3fJN/e+TOzrxxd6aXeYTn44HtKSnQI
         ZOL+3p1CZJaZH3tgPRN22H1jUp8/W0rg+K9EGMofXpUw+jCHZ+soWuuR0jHyTJAkD+PP
         Lw/A==
X-Gm-Message-State: AOAM533ZY4SWd/yBSu0PxCd2a5w7QKHuhG/xeviakP5bo5Xddbf5miH9
        OCw5WJV6r3J7L9hj7Zw5rWaFAgljeOMa8ioN/WX77bpk1520
X-Google-Smtp-Source: ABdhPJxUpnqFAgrzteAYxbihnq1D110dJ2uA77A9yOrhQwRLJycphJ6mrrJTXAKTa+rCEAvWhvkcc3jVAT3fvxw8upE=
X-Received: by 2002:ac8:6b90:: with SMTP id z16mr1104476qts.245.1611863331400;
 Thu, 28 Jan 2021 11:48:51 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
 <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
 <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
 <CABBYNZKeLsp+QhUOZQBhFuq6ZgHpZ+VPX=LYevad1UmZb5qq5g@mail.gmail.com>
 <CAC9s0Nbeo5-i9b_8Q2nJJfXQs=shCTFEkQ5ZVeevghp-PEQfKw@mail.gmail.com>
 <CAC9s0NZyTd-2Sk+p6ZmxpTuPzL5WJpF8fauQY-9Ek2HSKE58Ew@mail.gmail.com> <CAC9s0NawyWK=nvjt1O4mN_DAJd_-YVF+1eJ1QWXCudjYXeuXpA@mail.gmail.com>
In-Reply-To: <CAC9s0NawyWK=nvjt1O4mN_DAJd_-YVF+1eJ1QWXCudjYXeuXpA@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Thu, 28 Jan 2021 11:48:40 -0800
Message-ID: <CAC9s0NZ2cZJkmeevxrz4T+r9Byxd3oCUkprsTM0iseiOBBbsFg@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004c9c4805b9fb2d84"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--0000000000004c9c4805b9fb2d84
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

I read the btmon log after changing some services. But I don't see
there is any info about "Service Changed Indication". I attach this
log to this email. Could you please take a look at the log?

Some questions I have are:
1. To enable the "Service Changed Indication", do I need to change the
configuration of the bluetooth GATT server?
2. To enable the "Service Changed Indication", do I need to write some
code in Python to have it?
3. If I just need to call RegisterApplication() to register the
service and "Service Changed Indication" is supposed to be enabled,
then we should be fine on the GATT server side, correct? Then it'll be
up to the app developer to check on the mobile side. Do you know what
the app developer should check on their side?
4. I ran "bluetoothctl" and found these info:
[NEW] Characteristic
        /org/bluez/hci0/dev_6C_96_CF_98_99_12/service0006/char0007
        00002a05-0000-1000-8000-00805f9b34fb
        Service Changed
What is the meaning of this info? Can we tell from this info that
"Service Changed Indication" is working?

Thanks in advance!

On Wed, Jan 27, 2021 at 12:50 AM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> I'm not sure if I can attach files to this forum. I just try to attach
> the files about the "Service Changed Indication" issue.
>
> Here is the list of files:
> bt_read.py - the script that the "Heart Rate Measurement" and "Body
> Sensor Location" characteristics only have the Read attribute
> bt_notify.py - the script that the "Heart Rate Measurement" and "Body
> Sensor Location" characteristics only have both the Read and Notify
> attributes
> btmon_read.log - the btmon log when running bt_read.py
> btmon_notify.log - the btmon log when running bt_notify.py
>
> Thank you very much!
>
> On Wed, Jan 27, 2021 at 12:46 AM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Wed, Jan 27, 2021 at 12:42 AM Kenny Bian <kennybian@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thank you so much for your information.
> > >
> > > I created a test GATT server from the sample
> > > code(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > > I have 2 python scripts. In the "bt_read.py" I created, the Heart Rate
> > > Measurement(2A37) and Body Sensor Location(2A38) only have Read
> > > attribute. In the "bt_notify.py" I created, the Heart Rate
> > > Measurement(2A37) and Body Sensor Location(2A38) only have both the
> > > Read and Notify attribute.
> > >
> > > Here is what I did:
> > > I ran the "bt_read.py" and captured the btmon log. Then I ran
> > > "bt_notify.py" and captured the btmon log. I read both logs. But I
> > > don't see there is any info regarding the "Service Changed
> > > Indication".
> > >
> > > Here is the btmon log with both the Read and Notify attributes below.
> > > Thanks again for your help!
> > > =========================================================================
> > > Bluetooth monitor ver 5.48
> > > = Note: Linux version 4.19.35-g92e18fefc77 (armv7l)                    0.809169
> > > = Note: Bluetooth subsystem version 2.22                               0.809182
> > > = New Index: 00:16:A4:4A:2D:27 (Primary,UART,hci0)              [hci0] 0.809187
> > > = Open Index: 00:16:A4:4A:2D:27                                 [hci0] 0.809190
> > > = Index Info: 00:16:A4:4.. (Cypress Semiconductor Corporation)  [hci0] 0.809194
> > > @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0002} 0.809200
> > > @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.809203
> > > @ MGMT Open: btmon (privileged) version 1.14                  {0x0003} 0.809276
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 8                   #1 [hci0] 4.543721
> > >       ATT: Handle Value Notification (0x1b) len 3
> > >         Handle: 0x0016
> > >           Data: 64
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #2 [hci0] 6.883753
> > >       ATT: Read By Group Type Request (0x10) len 6
> > >         Handle range: 0x0001-0xffff
> > >         Attribute group type: Primary Service (0x2800)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 30                  #3 [hci0] 6.884412
> > >       ATT: Read By Group Type Response (0x11) len 25
> > >         Attribute data length: 6
> > >         Attribute group list: 4 entries
> > >         Handle range: 0x0001-0x0005
> > >         UUID: Generic Access Profile (0x1800)
> > >         Handle range: 0x0006-0x0009
> > >         UUID: Generic Attribute Profile (0x1801)
> > >         Handle range: 0x0234-0x023c
> > >         UUID: Heart Rate (0x180d)
> > >         Handle range: 0x023d-0x0240
> > >         UUID: Battery Service (0x180f)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #4 [hci0] 6.944638
> > >       ATT: Read By Group Type Request (0x10) len 6
> > >         Handle range: 0x0241-0xffff
> > >         Attribute group type: Primary Service (0x2800)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 26                  #5 [hci0] 6.945293
> > >       ATT: Read By Group Type Response (0x11) len 21
> > >         Attribute data length: 20
> > >         Attribute group list: 1 entry
> > >         Handle range: 0x0241-0x0250
> > >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #6 [hci0] 7.004723
> > >       ATT: Read By Group Type Request (0x10) len 6
> > >         Handle range: 0x0251-0xffff
> > >         Attribute group type: Primary Service (0x2800)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 9                   #7 [hci0] 7.005369
> > >       ATT: Error Response (0x01) len 4
> > >         Read By Group Type Request (0x10)
> > >         Handle: 0x0251
> > >         Error: Attribute Not Found (0x0a)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5       #8 [hci0] 7.005549
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                  #9 [hci0] 7.064450
> > >       ATT: Read By Type Request (0x08) len 6
> > >         Handle range: 0x0234-0x023c
> > >         Attribute type: Characteristic (0x2803)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 27                 #10 [hci0] 7.065112
> > >       ATT: Read By Type Response (0x09) len 22
> > >         Attribute data length: 7
> > >         Attribute data list: 3 entries
> > >         Handle: 0x0235
> > >         Value: 123602372a
> > >         Handle: 0x0238
> > >         Value: 123902382a
> > >         Handle: 0x023b
> > >         Value: 083c02392a
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #11 [hci0] 7.124428
> > >       ATT: Read By Type Request (0x08) len 6
> > >         Handle range: 0x023d-0x0240
> > >         Attribute type: Characteristic (0x2803)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 13                 #12 [hci0] 7.125226
> > >       ATT: Read By Type Response (0x09) len 8
> > >         Attribute data length: 7
> > >         Attribute data list: 1 entry
> > >         Handle: 0x023e
> > >         Value: 123f02192a
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #13 [hci0] 7.125376
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #14 [hci0] 7.184416
> > >       ATT: Read By Type Request (0x08) len 6
> > >         Handle range: 0x0241-0x0250
> > >         Attribute type: Characteristic (0x2803)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 69                 #15 [hci0] 7.185101
> > >       ATT: Read By Type Response (0x09) len 64
> > >         Attribute data length: 21
> > >         Attribute data list: 3 entries
> > >         Handle: 0x0242
> > >         Value: 8a4302f1debc9a785634127856341278563412
> > >         Handle: 0x0247
> > >         Value: 8a4802f3debc9a785634127856341278563412
> > >         Handle: 0x024c
> > >         Value: 8a4d02f5debc9a785634127856341278563412
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 11                 #16 [hci0] 7.244526
> > >       ATT: Read By Type Request (0x08) len 6
> > >         Handle range: 0x024e-0x0250
> > >         Attribute type: Characteristic (0x2803)
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 9                  #17 [hci0] 7.246144
> > >       ATT: Error Response (0x01) len 4
> > >         Read By Type Request (0x08)
> > >         Handle: 0x024e
> > >         Error: Attribute Not Found (0x0a)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #18 [hci0] 7.246564
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #19 [hci0] 7.304500
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0237-0x0237
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #20 [hci0] 7.305951
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0237
> > >         UUID: Client Characteristic Configuration (0x2902)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #21 [hci0] 7.364540
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x023a-0x023a
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #22 [hci0] 7.366242
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x023a
> > >         UUID: Client Characteristic Configuration (0x2902)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 7.366660
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #24 [hci0] 7.424617
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0240-0x0240
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #25 [hci0] 7.426085
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0240
> > >         UUID: Client Characteristic Configuration (0x2902)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #26 [hci0] 7.484523
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0244-0x0246
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #27 [hci0] 7.486104
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0244
> > >         UUID: Characteristic Extended Properties (0x2900)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #28 [hci0] 7.486520
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #29 [hci0] 7.544546
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0245-0x0246
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #30 [hci0] 7.546011
> > >       ATT: Find Information Response (0x05) len 19
> > >         Format: UUID-128 (0x02)
> > >         Handle: 0x0245
> > >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef2)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #31 [hci0] 7.604713
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0246-0x0246
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #32 [hci0] 7.606323
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0246
> > >         UUID: Characteristic User Description (0x2901)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #33 [hci0] 7.606747
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #34 [hci0] 7.664243
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0249-0x024b
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #35 [hci0] 7.665862
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0249
> > >         UUID: Characteristic Extended Properties (0x2900)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #36 [hci0] 7.724603
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x024a-0x024b
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #37 [hci0] 7.726315
> > >       ATT: Find Information Response (0x05) len 19
> > >         Format: UUID-128 (0x02)
> > >         Handle: 0x024a
> > >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef4)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #38 [hci0] 7.726625
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #39 [hci0] 7.784545
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x024b-0x024b
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #40 [hci0] 7.785996
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x024b
> > >         UUID: Characteristic User Description (0x2901)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #41 [hci0] 7.844187
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x024e-0x0250
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #42 [hci0] 7.845777
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x024e
> > >         UUID: Characteristic Extended Properties (0x2900)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #43 [hci0] 7.846215
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #44 [hci0] 7.904466
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x024f-0x0250
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 24                 #45 [hci0] 7.906160
> > >       ATT: Find Information Response (0x05) len 19
> > >         Format: UUID-128 (0x02)
> > >         Handle: 0x024f
> > >         UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef6)
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                  #46 [hci0] 7.964493
> > >       ATT: Find Information Request (0x04) len 4
> > >         Handle range: 0x0250-0x0250
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 10                 #47 [hci0] 7.966067
> > >       ATT: Find Information Response (0x05) len 5
> > >         Format: UUID-16 (0x01)
> > >         Handle: 0x0250
> > >         UUID: Characteristic User Description (0x2901)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #48 [hci0] 7.966489
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 2
> > > > HCI Event: Number of Completed Packets (0x13) plen 5      #49 [hci0] 8.203559
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 1
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 7                 #50 [hci0] 11.833674
> > >       ATT: Read Request (0x0a) len 2
> > >         Handle: 0x0236
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 7                 #51 [hci0] 11.840770
> > >       ATT: Read Response (0x0b) len 2
> > >         Value: 0663
> > > > HCI Event: Number of Completed Packets (0x13) plen 5     #52 [hci0] 12.078687
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 1
> > > > ACL Data RX: Handle 65 flags 0x02 dlen 9                 #53 [hci0] 14.055212
> > >       ATT: Write Request (0x12) len 4
> > >         Handle: 0x0237
> > >           Data: 0100
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 5                 #54 [hci0] 14.056230
> > >       ATT: Write Response (0x13) len 0
> > > > HCI Event: Number of Completed Packets (0x13) plen 5     #55 [hci0] 14.329045
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 1
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 11                #56 [hci0] 15.078671
> > >       ATT: Handle Value Notification (0x1b) len 6
> > >         Handle: 0x0236
> > >           Data: 0e750000
> > > > HCI Event: Number of Completed Packets (0x13) plen 5     #57 [hci0] 15.330353
> > >         Num handles: 1
> > >         Handle: 65
> > >         Count: 1
> > > < ACL Data TX: Handle 65 flags 0x00 dlen 9                 #58 [hci0] 16.071839
> > >       ATT: Handle Value Notification (0x1b) len 4
> > >         Handle: 0x0236
> > >           Data: 066e
> > > > ACL Data RX: H
> > >
> > > On Mon, Jan 25, 2021 at 9:59 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Kenny,
> > > >
> > > > On Sun, Jan 24, 2021 at 10:42 PM Kenny Bian <kennybian@gmail.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > Thank you so much for your reply. I appreciate it.
> > > > >
> > > > > By "registering the services", do you mean "RegisterApplication()" in
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n656?
> > > > > If that is the case, I believe I already registered the services.
> > > > > I checked the files in /var/lib/bluetooth. According to
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321,
> > > > > there should be a "[ServiceChanged]" section in the "info" file. But I
> > > > > don't see it in the "info" file. Is there a way to tell the "Service
> > > > > Changed Indication" is actually working?
> > > > > Let's suppose the "Service Changed Indication" is already enabled, is
> > > > > there a way for the mobile app to check on their side to tell which
> > > > > service(s) got changed?
> > > >
> > > > HCI traces (btmon) should be able to tell you if it has been
> > > > subscribed or not, if there is an Indication in it it probably means
> > > > the remote has subscribed.
> > > >
> > > > > Thanks again for your help.
> > > > >
> > > > > On Sun, Jan 24, 2021 at 7:35 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Kenny,
> > > > > >
> > > > > > On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > We implemented a GATT server on Linux in Python. The code is based on
> > > > > > > the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > > > > > > The BlueZ version is 5.48. But we found a problem. The cached data in
> > > > > > > /var/lib/bluetooth caused the mobile app to crash if some
> > > > > > > characteristics are changed. After some research, we found "Under BLE
> > > > > > > standard 'Generic Attribute'(0x1801), there is a Characteristic
> > > > > > > 'Service Changed' (0x2A05) with 'indicate' property", see
> > > > > > > https://github.com/espressif/esp-idf/issues/1777.
> > > > > > >
> > > > > > > The questions we have:
> > > > > > > How to enable the "Service Changed Indication"(0x2A05) in the
> > > > > > > bluetooth? Is there any code example in Python?
> > > > > >
> > > > > > If you are registering the services with Bluetoothd then it should
> > > > > > generate the service change automatically:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185
> > > > > >
> > > > > > When a new service is registered it is indicated here:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz

--0000000000004c9c4805b9fb2d84
Content-Type: application/octet-stream; name="btmon_notify.log"
Content-Disposition: attachment; filename="btmon_notify.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kkh9revi0>
X-Attachment-Id: f_kkh9revi0

Qmx1ZXRvb3RoIG1vbml0b3IgdmVyIDUuNDgKPSBOb3RlOiBMaW51eCB2ZXJzaW9uIDQuMTkuMzUt
ZzkyZTE4ZmVmYzc3IChhcm12N2wpICAgICAgICAgICAgICAgICAgICAwLjgwOTE2OQo9IE5vdGU6
IEJsdWV0b290aCBzdWJzeXN0ZW0gdmVyc2lvbiAyLjIyICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAuODA5MTgyCj0gTmV3IEluZGV4OiAwMDoxNjpBNDo0QToyRDoyNyAoUHJpbWFyeSxV
QVJULGhjaTApICAgICAgICAgICAgICBbaGNpMF0gMC44MDkxODcKPSBPcGVuIEluZGV4OiAwMDox
NjpBNDo0QToyRDoyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAwLjgw
OTE5MAo9IEluZGV4IEluZm86IDAwOjE2OkE0OjQuLiAoQ3lwcmVzcyBTZW1pY29uZHVjdG9yIENv
cnBvcmF0aW9uKSAgW2hjaTBdIDAuODA5MTk0CkAgTUdNVCBPcGVuOiBibHVldG9vdGhkIChwcml2
aWxlZ2VkKSB2ZXJzaW9uIDEuMTQgICAgICAgICAgICAgezB4MDAwMn0gMC44MDkyMDAKQCBNR01U
IE9wZW46IGJsdWV0b290aGQgKHByaXZpbGVnZWQpIHZlcnNpb24gMS4xNCAgICAgICAgICAgICB7
MHgwMDAxfSAwLjgwOTIwMwpAIE1HTVQgT3BlbjogYnRtb24gKHByaXZpbGVnZWQpIHZlcnNpb24g
MS4xNCAgICAgICAgICAgICAgICAgIHsweDAwMDN9IDAuODA5Mjc2Cj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gOCAgICAgICAgICAgICAgICAgICAjMSBbaGNpMF0gNC41
NDM3MjEKICAgICAgQVRUOiBIYW5kbGUgVmFsdWUgTm90aWZpY2F0aW9uICgweDFiKSBsZW4gMwog
ICAgICAgIEhhbmRsZTogMHgwMDE2CiAgICAgICAgICBEYXRhOiA2NAo+IEFDTCBEYXRhIFJYOiBI
YW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAgICAgICAgIzIgW2hjaTBdIDYu
ODgzNzUzCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApIGxlbiA2
CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIGdy
b3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUg
NjUgZmxhZ3MgMHgwMCBkbGVuIDMwICAgICAgICAgICAgICAgICAgIzMgW2hjaTBdIDYuODg0NDEy
CiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlc3BvbnNlICgweDExKSBsZW4gMjUKICAg
ICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDYKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgbGlz
dDogNCBlbnRyaWVzCiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHgwMDA1CiAgICAgICAg
VVVJRDogR2VuZXJpYyBBY2Nlc3MgUHJvZmlsZSAoMHgxODAwKQogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMDA2LTB4MDAwOQogICAgICAgIFVVSUQ6IEdlbmVyaWMgQXR0cmlidXRlIFByb2ZpbGUg
KDB4MTgwMSkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIzNC0weDAyM2MKICAgICAgICBVVUlE
OiBIZWFydCBSYXRlICgweDE4MGQpCiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyM2QtMHgwMjQw
CiAgICAgICAgVVVJRDogQmF0dGVyeSBTZXJ2aWNlICgweDE4MGYpCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAjNCBbaGNpMF0gNi45
NDQ2MzgKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVxdWVzdCAoMHgxMCkgbGVuIDYK
ICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0MS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgZ3Jv
dXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDApCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2
NSBmbGFncyAweDAwIGRsZW4gMjYgICAgICAgICAgICAgICAgICAjNSBbaGNpMF0gNi45NDUyOTMK
ICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVzcG9uc2UgKDB4MTEpIGxlbiAyMQogICAg
ICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogMjAKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgbGlz
dDogMSBlbnRyeQogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjQxLTB4MDI1MAogICAgICAgIFVV
SUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWYw
KQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAg
ICAgICAgIzYgW2hjaTBdIDcuMDA0NzIzCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJl
cXVlc3QgKDB4MTApIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAyNTEtMHhmZmZmCiAg
ICAgICAgQXR0cmlidXRlIGdyb3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAg
IzcgW2hjaTBdIDcuMDA1MzY5CiAgICAgIEFUVDogRXJyb3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0
CiAgICAgICAgUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApCiAgICAgICAgSGFuZGxl
OiAweDAyNTEKICAgICAgICBFcnJvcjogQXR0cmlidXRlIE5vdCBGb3VuZCAoMHgwYSkKPiBIQ0kg
RXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICM4
IFtoY2kwXSA3LjAwNTU0OQogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2
NQogICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRs
ZW4gMTEgICAgICAgICAgICAgICAgICAjOSBbaGNpMF0gNy4wNjQ0NTAKICAgICAgQVRUOiBSZWFk
IEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIz
NC0weDAyM2MKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAyNyAgICAgICAgICAgICAg
ICAgIzEwIFtoY2kwXSA3LjA2NTExMgogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAo
MHgwOSkgbGVuIDIyCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiA3CiAgICAgICAgQXR0
cmlidXRlIGRhdGEgbGlzdDogMyBlbnRyaWVzCiAgICAgICAgSGFuZGxlOiAweDAyMzUKICAgICAg
ICBWYWx1ZTogMTIzNjAyMzcyYQogICAgICAgIEhhbmRsZTogMHgwMjM4CiAgICAgICAgVmFsdWU6
IDEyMzkwMjM4MmEKICAgICAgICBIYW5kbGU6IDB4MDIzYgogICAgICAgIFZhbHVlOiAwODNjMDIz
OTJhCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAg
ICAgICAgICMxMSBbaGNpMF0gNy4xMjQ0MjgKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVz
dCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDIzZC0weDAyNDAKICAgICAg
ICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDog
SGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMyAgICAgICAgICAgICAgICAgIzEyIFtoY2kwXSA3
LjEyNTIyNgogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAoMHgwOSkgbGVuIDgKICAg
ICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0
OiAxIGVudHJ5CiAgICAgICAgSGFuZGxlOiAweDAyM2UKICAgICAgICBWYWx1ZTogMTIzZjAyMTky
YQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUg
ICAgICAjMTMgW2hjaTBdIDcuMTI1Mzc2CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBI
YW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdz
IDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgIzE0IFtoY2kwXSA3LjE4NDQxNgogICAgICBB
VFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMjQxLTB4MDI1MAogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAo
MHgyODAzKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDY5ICAgICAg
ICAgICAgICAgICAjMTUgW2hjaTBdIDcuMTg1MTAxCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJl
c3BvbnNlICgweDA5KSBsZW4gNjQKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDIxCiAg
ICAgICAgQXR0cmlidXRlIGRhdGEgbGlzdDogMyBlbnRyaWVzCiAgICAgICAgSGFuZGxlOiAweDAy
NDIKICAgICAgICBWYWx1ZTogOGE0MzAyZjFkZWJjOWE3ODU2MzQxMjc4NTYzNDEyNzg1NjM0MTIK
ICAgICAgICBIYW5kbGU6IDB4MDI0NwogICAgICAgIFZhbHVlOiA4YTQ4MDJmM2RlYmM5YTc4NTYz
NDEyNzg1NjM0MTI3ODU2MzQxMgogICAgICAgIEhhbmRsZTogMHgwMjRjCiAgICAgICAgVmFsdWU6
IDhhNGQwMmY1ZGViYzlhNzg1NjM0MTI3ODU2MzQxMjc4NTYzNDEyCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICMxNiBbaGNpMF0gNy4y
NDQ1MjYKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAg
ICBIYW5kbGUgcmFuZ2U6IDB4MDI0ZS0weDAyNTAKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hh
cmFjdGVyaXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAg
ZGxlbiA5ICAgICAgICAgICAgICAgICAgIzE3IFtoY2kwXSA3LjI0NjE0NAogICAgICBBVFQ6IEVy
cm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgw
eDA4KQogICAgICAgIEhhbmRsZTogMHgwMjRlCiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3Qg
Rm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4
MTMpIHBsZW4gNSAgICAgICMxOCBbaGNpMF0gNy4yNDY1NjQKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjMTkgW2hjaTBdIDcuMzA0
NTAwCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAg
ICAgIEhhbmRsZSByYW5nZTogMHgwMjM3LTB4MDIzNwo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUg
ZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAjMjAgW2hjaTBdIDcuMzA1OTUxCiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUKICAgICAgICBG
b3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAyMzcKICAgICAgICBVVUlE
OiBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbiAoMHgyOTAyKQo+IEFDTCBEYXRh
IFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjMjEgW2hj
aTBdIDcuMzY0NTQwCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBs
ZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjNhLTB4MDIzYQo8IEFDTCBEYXRhIFRYOiBI
YW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAjMjIgW2hjaTBdIDcu
MzY2MjQyCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUK
ICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAyM2EKICAg
ICAgICBVVUlEOiBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbiAoMHgyOTAyKQo+
IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAg
ICAjMjMgW2hjaTBdIDcuMzY2NjYwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5k
bGU6IDY1CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4
MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzI0IFtoY2kwXSA3LjQyNDYxNwogICAgICBBVFQ6
IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFu
Z2U6IDB4MDI0MC0weDAyNDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxl
biAxMCAgICAgICAgICAgICAgICAgIzI1IFtoY2kwXSA3LjQyNjA4NQogICAgICBBVFQ6IEZpbmQg
SW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2
ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQwCiAgICAgICAgVVVJRDogQ2xpZW50IENoYXJh
Y3RlcmlzdGljIENvbmZpZ3VyYXRpb24gKDB4MjkwMikKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1
IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzI2IFtoY2kwXSA3LjQ4NDUyMwog
ICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBI
YW5kbGUgcmFuZ2U6IDB4MDI0NC0weDAyNDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdz
IDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzI3IFtoY2kwXSA3LjQ4NjEwNAogICAgICBB
VFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0
OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQ0CiAgICAgICAgVVVJRDogQ2hh
cmFjdGVyaXN0aWMgRXh0ZW5kZWQgUHJvcGVydGllcyAoMHgyOTAwKQo+IEhDSSBFdmVudDogTnVt
YmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMjggW2hjaTBdIDcu
NDg2NTIwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAg
Q291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAg
ICAgICAgICAgICAgIzI5IFtoY2kwXSA3LjU0NDU0NgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRp
b24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0NS0weDAy
NDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAyNCAgICAgICAgICAg
ICAgICAgIzMwIFtoY2kwXSA3LjU0NjAxMQogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVz
cG9uc2UgKDB4MDUpIGxlbiAxOQogICAgICAgIEZvcm1hdDogVVVJRC0xMjggKDB4MDIpCiAgICAg
ICAgSGFuZGxlOiAweDAyNDUKICAgICAgICBVVUlEOiBWZW5kb3Igc3BlY2lmaWMgKDEyMzQ1Njc4
LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVmMikKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZs
YWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgIzMxIFtoY2kwXSA3LjYwNDcxMwogICAg
ICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5k
bGUgcmFuZ2U6IDB4MDI0Ni0weDAyNDYKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4
MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzMyIFtoY2kwXSA3LjYwNjMyMwogICAgICBBVFQ6
IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBV
VUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMjQ2CiAgICAgICAgVVVJRDogQ2hhcmFj
dGVyaXN0aWMgVXNlciBEZXNjcmlwdGlvbiAoMHgyOTAxKQo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMzMgW2hjaTBdIDcuNjA2NzQ3
CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6
IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAg
ICAgICAgIzM0IFtoY2kwXSA3LjY2NDI0MwogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVx
dWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0OS0weDAyNGIKPCBB
Q0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAg
IzM1IFtoY2kwXSA3LjY2NTg2MgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2Ug
KDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRs
ZTogMHgwMjQ5CiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMgRXh0ZW5kZWQgUHJvcGVydGll
cyAoMHgyOTAwKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAg
ICAgICAgICAgICAgICAjMzYgW2hjaTBdIDcuNzI0NjAzCiAgICAgIEFUVDogRmluZCBJbmZvcm1h
dGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjRhLTB4
MDI0Ygo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDI0ICAgICAgICAg
ICAgICAgICAjMzcgW2hjaTBdIDcuNzI2MzE1CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBS
ZXNwb25zZSAoMHgwNSkgbGVuIDE5CiAgICAgICAgRm9ybWF0OiBVVUlELTEyOCAoMHgwMikKICAg
ICAgICBIYW5kbGU6IDB4MDI0YQogICAgICAgIFVVSUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2
NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY0KQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjMzggW2hjaTBdIDcuNzI2NjI1CiAg
ICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDIK
PiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAg
ICAgIzM5IFtoY2kwXSA3Ljc4NDU0NQogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVz
dCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDI0Yi0weDAyNGIKPCBBQ0wg
RGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgIzQw
IFtoY2kwXSA3Ljc4NTk5NgogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4
MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTog
MHgwMjRiCiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMgVXNlciBEZXNjcmlwdGlvbiAoMHgy
OTAxKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAg
ICAgICAgICAjNDEgW2hjaTBdIDcuODQ0MTg3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBS
ZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjRlLTB4MDI1MAo8
IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAg
ICAjNDIgW2hjaTBdIDcuODQ1Nzc3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25z
ZSAoMHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFu
ZGxlOiAweDAyNGUKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3RpYyBFeHRlbmRlZCBQcm9wZXJ0
aWVzICgweDI5MDApCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4
MTMpIHBsZW4gNSAgICAgICM0MyBbaGNpMF0gNy44NDYyMTUKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAjNDQgW2hjaTBdIDcuOTA0
NDY2CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAg
ICAgIEhhbmRsZSByYW5nZTogMHgwMjRmLTB4MDI1MAo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUg
ZmxhZ3MgMHgwMCBkbGVuIDI0ICAgICAgICAgICAgICAgICAjNDUgW2hjaTBdIDcuOTA2MTYwCiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDE5CiAgICAgICAg
Rm9ybWF0OiBVVUlELTEyOCAoMHgwMikKICAgICAgICBIYW5kbGU6IDB4MDI0ZgogICAgICAgIFVV
SUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY2
KQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAg
ICAgICAjNDYgW2hjaTBdIDcuOTY0NDkzCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1
ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMjUwLTB4MDI1MAo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAj
NDcgW2hjaTBdIDcuOTY2MDY3CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAo
MHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxl
OiAweDAyNTAKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3RpYyBVc2VyIERlc2NyaXB0aW9uICgw
eDI5MDEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBs
ZW4gNSAgICAgICM0OCBbaGNpMF0gNy45NjY0ODkKICAgICAgICBOdW0gaGFuZGxlczogMQogICAg
ICAgIEhhbmRsZTogNjUKICAgICAgICBDb3VudDogMgo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAjNDkgW2hjaTBdIDguMjAzNTU5CiAg
ICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDEK
PiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAg
ICAjNTAgW2hjaTBdIDExLjgzMzY3NAogICAgICBBVFQ6IFJlYWQgUmVxdWVzdCAoMHgwYSkgbGVu
IDIKICAgICAgICBIYW5kbGU6IDB4MDIzNgo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3Mg
MHgwMCBkbGVuIDcgICAgICAgICAgICAgICAgICM1MSBbaGNpMF0gMTEuODQwNzcwCiAgICAgIEFU
VDogUmVhZCBSZXNwb25zZSAoMHgwYikgbGVuIDIKICAgICAgICBWYWx1ZTogMDY2Mwo+IEhDSSBF
dmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICM1MiBb
aGNpMF0gMTIuMDc4Njg3CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY1
CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY1IGZsYWdzIDB4MDIgZGxl
biA5ICAgICAgICAgICAgICAgICAjNTMgW2hjaTBdIDE0LjA1NTIxMgogICAgICBBVFQ6IFdyaXRl
IFJlcXVlc3QgKDB4MTIpIGxlbiA0CiAgICAgICAgSGFuZGxlOiAweDAyMzcKICAgICAgICAgIERh
dGE6IDAxMDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiA1ICAgICAg
ICAgICAgICAgICAjNTQgW2hjaTBdIDE0LjA1NjIzMAogICAgICBBVFQ6IFdyaXRlIFJlc3BvbnNl
ICgweDEzKSBsZW4gMAo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgw
eDEzKSBwbGVuIDUgICAgICM1NSBbaGNpMF0gMTQuMzI5MDQ1CiAgICAgICAgTnVtIGhhbmRsZXM6
IDEKICAgICAgICBIYW5kbGU6IDY1CiAgICAgICAgQ291bnQ6IDEKPCBBQ0wgRGF0YSBUWDogSGFu
ZGxlIDY1IGZsYWdzIDB4MDAgZGxlbiAxMSAgICAgICAgICAgICAgICAjNTYgW2hjaTBdIDE1LjA3
ODY3MQogICAgICBBVFQ6IEhhbmRsZSBWYWx1ZSBOb3RpZmljYXRpb24gKDB4MWIpIGxlbiA2CiAg
ICAgICAgSGFuZGxlOiAweDAyMzYKICAgICAgICAgIERhdGE6IDBlNzUwMDAwCj4gSENJIEV2ZW50
OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgIzU3IFtoY2kw
XSAxNS4zMzAzNTMKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjUKICAg
ICAgICBDb3VudDogMQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjUgZmxhZ3MgMHgwMCBkbGVuIDkg
ICAgICAgICAgICAgICAgICM1OCBbaGNpMF0gMTYuMDcxODM5CiAgICAgIEFUVDogSGFuZGxlIFZh
bHVlIE5vdGlmaWNhdGlvbiAoMHgxYikgbGVuIDQKICAgICAgICBIYW5kbGU6IDB4MDIzNgogICAg
ICAgICAgRGF0YTogMDY2ZQo+IEFDTCBEYXRhIFJYOiBI
--0000000000004c9c4805b9fb2d84--
