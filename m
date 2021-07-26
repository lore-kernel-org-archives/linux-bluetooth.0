Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35109C4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB3D60F6E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhGZThG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhGZThE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 15:37:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64457C061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 13:17:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o185so12310601oih.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qpXW/t7/LAN2V8q8ydEap7i6JhSb1/NqGECjNdox3Ms=;
        b=jgklD0xD/6dAXnJr+VD/hAW4aKAs12pi9T0yX9UWaCsKPChS2nLxnF1p8NAVQ2YH3f
         YpZ5nKxxYLw8draAG4/bsW47w2sReNFZUsK2k/+GLk/Oa8W2jwEGaBmuIlNJlbFKy/BJ
         PaZTX2OILtmZVSg6yDyguLNGPzKZuFoE1+M0V/pH84oYqcKwU2TDmh4VfZfjfTPXtHFI
         Db0eQEsnjpM8iV5ys58q39UVhqy0PI1bZDpgK5LQBYtbXqsnDP7pfAGLycUnG6R1HVSb
         hz3lvJZsNxbiK6vgTXMB+sgbr8rNtZsIqWtOpfsyvShcvbg6QpGcbtcSS/qhu6TL/pz3
         qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qpXW/t7/LAN2V8q8ydEap7i6JhSb1/NqGECjNdox3Ms=;
        b=dLTzDrCBpzggmuqPWK8btv5UxB2HX40b//GmYe1OGDqAiqFpGHPO/ntL5wrVwu1Fyq
         etgdcONk+vsjWWeJj8Q4Cy49kjg6trnCwIq+sCYsIgwszYI2Bg1SQP5giJLvycy7As97
         DSwRHlWHKwHxKRjlRBPvwGAQT8jmNg6qB0+ABHFLLsJOmFANMQfA15N/OjMFF1H9EQeO
         O3lsWCMi0v7eXvIiYSY9Qz4jey6Yk52CvZVp68wdR/w7pJXdJRPL+NWMJI/VnC9Gg02g
         21rgtSWef84armroEdLd/C4azmDh3icDGLu+9yVAQw6VBgm670O91/EJoNKCh0n5jf6h
         TDPw==
X-Gm-Message-State: AOAM532YvqGedJeSWpzo4neBUVY0IfPJ9ZzyJCzjTYYaDkdKzEDYDGI4
        yzw2KaabBGpMX8lU6al9KRc0DIzgwdMDWyV5Gqk=
X-Google-Smtp-Source: ABdhPJy/58uFVmrVbUdIO9l4WcsGsc39gJd6mDaJUS7ygUmX1G/9JyT7Wd+raucsDPnq6745xziy6MDE7zU46lZa6FY=
X-Received: by 2002:a54:4494:: with SMTP id v20mr570776oiv.70.1627330651725;
 Mon, 26 Jul 2021 13:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
 <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
 <CAO1O6sfBB53qMnB-K+ZLaGrrD3ZFy00Zn+u1GqTavNX7fZCzBw@mail.gmail.com>
 <CAJgPF1LG32ShzPsaPWC64VGRC+odvHYrUYXBiDkTdcZHH78sbQ@mail.gmail.com> <CAJgPF1+BJFyryVWzVYGp=qDHjruJWYq-eAHzm+QeR=BGNct+iw@mail.gmail.com>
In-Reply-To: <CAJgPF1+BJFyryVWzVYGp=qDHjruJWYq-eAHzm+QeR=BGNct+iw@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 26 Jul 2021 22:17:27 +0200
Message-ID: <CAO1O6seL0QJwHB6CRq56UitWUxQk4PaMC1a-22ggk6KjoD1F1Q@mail.gmail.com>
Subject: Re: Instable BLE connection - MTU Request, Attribute not found -
 wireshark findings
To:     =?UTF-8?Q?Peter_H=C3=B6ller?= <drmedvet.hoeller@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Den m=C3=A5n 26 juli 2021 kl 22:00 skrev Peter H=C3=B6ller <drmedvet.hoelle=
r@gmail.com>:
>
> However, I installed wireshark ( I used the wireshark version instead
> of tshark, because I am not familiar with the shell commands in
> tshark. However, unfortunately I cannot copy any sniffed protocols for
> now)
>
> my connection status out of bluetoothctl is:
> paired, trusted and connected
>
>
> 1.) paired and connected I go to
> >menu gatt
> >select attribute b5f90074-aa8d-11e3-9046-0002a5d5c51b  (as I always do)
> this leads me to:
> GoPro8639:/service002d/char0033]#
> no I:
> write "0x03 0x01 0x01 0x01"  (which always started the shutter on
> peripheral, when we used btusb 0.6 (now we are using btusb 0.7!)
>
> but nothing happens at peripheral.
> on wireshark there is no error but I get on Write response packet:
> Bluetooth Attribute Protocol
> -->Opcode: Write Response (0x13)
> -->0... .... =3D Authentication Signature: False
> .0.. .... =3D Command: False
> ..01 0011 =3D Method: Write Respone (0x13)
>
> Can you debug this? Was there any change in syntax due to write <data
> =3D xx xx xx xx xx> [offset] [type] ?
>
> Hoever,
> sudo gatttool -t random -b xx:xx:xx:xx:xx:xx -I
> connect
> char-write-req 2f 03010101
>
> still works (!) and goes through to the peripheral !, unless there
> occurs no is no file descriptor Error
>
>
> 2.) due to the disconnect problem after longer connection ~15 min:
> there where no further findings:
> wireshark delivers an HCI event  - Disconnect Complete with
> Reason: Connection Timeout (0x08)
>
> 3.) due to the immediate disconnect problem (~1 - 10 sec after
> connection): there seems to be an encryption problem and /or
> Encryption change takes too long?:
> (I type for you...)
>
> from host to controller:          HCI_CMD           length: 29
> SENT           LE Create Connection
>
> from controller to host:          HCI_EVT            length: 7
>  Rcvd            Command Status (LE Create Connection)
>
> from controller to host:          HCI_EVT            lenght: 22
> Rcvd              LE Meta (LE Connection Complete)
>
> from host to controller:          HCI_CMD           length: 32
> Sent             LE Start Encryption
>
> from controller to host:          HCI_EVT            lenght: 7
> Rcvd             Command Status (LE Start Encryption)
>
> from controller to host:          HCI_EVT            lenght: 7
> Rcvd             Encryption Change
> ----->containg under BluetoothHCI Event:  Status: Connection timeout (0x0=
8) and
>
> Encrytion Enable: Link Level Encryption is OFF (0x00)
>
> from host to controller:          HCI_CMD           length: 7
> Sent              Disconnect
> ----->containg under BluetoothHCI Command:   Reason: Authentication
> Failure (0x05)
>
> from controller to host:          HCI_EVT            lenght: 7
> Sent             Disconnect Complete
> ----->containg under BluetoothHCI Event:   Reason Connection Timeout(0x08=
)

If you have one method that works and one that fails, you should use
btmon to compare the exact write payloads. I don't know about GoPro so
can't help what kind of messages it expects.

You can see that it's the controller that first notifies of the
disconnection with the reason "Connection Timeout" (in a start
encryption result, as indicated by the result code). So likely it's
due to one of the reasons I wrote about earlier. Another reason for
connection timeout is if the firmware is buggy or just drops the
connection for example when you suddenly power off the device. What
also could happen is, during encryption setup, is if both devices
believe they share the same encryption key, but in fact they for some
reason have two different keys stored, then the peripheral will drop
the connection with the reason "Connection terminated due to MIC
failure" while the central will eventually get a "Connection Timeout".

/Emil
