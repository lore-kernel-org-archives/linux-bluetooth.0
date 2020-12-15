Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20096C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC042076D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 17:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgLORwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgLORwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 12:52:03 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A9C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 09:51:23 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id q6so4250505ooo.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sd6i2hpghMPaPoiH+bJrUwdmpJkGwlNVojk8vB0WCCw=;
        b=KU3pJikde51uJcIf4kEShFlKAHkm3S594GIRumJ8v8atnGUg+CLCNNBikrZcVFtxSC
         2z6bOlQRMJYIp6Hbsd4umBwyW+GaZsdxwUhFNzfZ3WznQp1xyUHd1ejCXoyFTN1FzKNz
         Xo+qnXTkTjOrZbh+wQlH9zg6cYrgabvBkSv8eGLorKGHYYEUSRAKB9P5YlrtljU3TSxb
         NGXm0r0wk+8sZ4XMTPKwKTcYGvfmawfJQqwFH4n4rFTG3AFSoV8JyKIXXVR6OcncxoeE
         18/eKBo+YLEbL/IMQRvSCSULfU1bYhuAy+DT+HIhCkbfPrr33Emh+ns9xH4VeLAJk/M0
         tpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sd6i2hpghMPaPoiH+bJrUwdmpJkGwlNVojk8vB0WCCw=;
        b=sCfd4K9kcqjfaFRP5yzOtSD0aoCyTyIcwDq1feO1LbQrI3ZREiZykBtuTapyjY28JV
         YHfwFm+ndQgBW1MKRSMugds9Ipz9Moo7syVPqzbn+M02UFnVXR/jQCndyOXo0rv3hlER
         ylFiCBxnxZ0tbvM6wJwhRPgiJetflk3RPXXNDgTcCrzxtJ8QMzHvwTJ0Dk0lbsIKub0c
         ZTIp9x7V3Da+63MTvOyVz6LQG8SrroUCY5mdGw5JWyCPJN16cScFzN7exi2Mj+94phQL
         qT28l9e5ZeVFaYsWKGMPbrHrm5vq6jOAAQzSZ7C1TAlmOakO5MU7cXUGJ8NNVbbBkKzD
         HQfw==
X-Gm-Message-State: AOAM5328l++KqC6OSGIorN1H81Vq7Y2NxKvf+3PErcYOq1/jrus6E11W
        hXVcXnYb/S37lfCGRpQec/b3Wql5RUGekXfzcYMuHJot
X-Google-Smtp-Source: ABdhPJw9hbHcfvDheMKGYIIVuSgkdSdYxsp8zLRbheCqE4XWB1tZp/tLplF+aX4ch2VhDjoqS+oQh1BU5pPSKCkDKJg=
X-Received: by 2002:a4a:bc8d:: with SMTP id m13mr23387286oop.63.1608054682333;
 Tue, 15 Dec 2020 09:51:22 -0800 (PST)
MIME-Version: 1.0
References: <22bd6446-d293-c5d7-14b7-9db9fa0727f6@gmail.com>
In-Reply-To: <22bd6446-d293-c5d7-14b7-9db9fa0727f6@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Dec 2020 09:51:11 -0800
Message-ID: <CABBYNZ+yi2kX0P8c8u4ZpZNcuy=vRMHqEfsirPd-+EVdbqxnuw@mail.gmail.com>
Subject: Re: BLE Midi problem with mixed 16/128Bit UUIDs in characteristics
To:     Johannes Deisenhofer <jo.deisenhofer@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johannes,

On Tue, Dec 15, 2020 at 6:43 AM Johannes Deisenhofer
<jo.deisenhofer@gmail.com> wrote:
>
> Hi,
>
> I could use some help understanding and hopefully fixing a BLE Midi problem.
>
> I have bought a new MIDI device (Roland GO:Keys). This device connects
> fine via BLE, but does not send any key events. I have another keyboard
> working fine via BLE. Both devices work with android.
>
> After digging into code and specs, I think that the chain of events is:
>   - The MIDI Service is found
>   - The characteristics are parsed
>   - The code thinks that all characteristics in the PDU have 16bit UUIDS
> (len 7), while 3 of them. are 128bit

The spec doesn't allow mixing values of different sizes, or does it
first return the 16 bits one and then later 3 are return in a
different response?

>   - Thus it parses nonsense, and does not find the Midi I/O
> characteristic, no data transfer possible.
>
> src/device.c:gatt_debug() MTU exchange complete, with MTU: 96
> src/device.c:gatt_debug() Primary services found: 4
> src/device.c:gatt_debug() start: 0x0001, end: 0x0003, uuid:
> 00001800-0000-1000-8000-00805f9b34fb
> src/device.c:gatt_debug() start: 0x0007, end: 0x000f, uuid:
> 03b80e5a-ede8-4b33-a751-6ce34ec4c700
> src/device.c:gatt_debug() start: 0x0021, end: 0x0023, uuid:
> 00001801-0000-1000-8000-00805f9b34fb
> src/device.c:gatt_debug() start: 0x0031, end: 0x0041, uuid:
> 0000180a-0000-1000-8000-00805f9b34fb
> src/device.c:gatt_debug() Characteristics found: 19
> src/device.c:gatt_debug() start: 0x0002, end: 0x0007, value: 0x0003,
> props: 0x0a, uuid: 00002a00-0000-1
> src/device.c:gatt_debug() start: 0x0008, end: 0x28a5, value: 0x0009,
> props: 0x18, uuid: 00000318-0000-1
> src/device.c:gatt_debug() start: 0x28a6, end: 0xa347, value: 0xecd8,
> props: 0x5e, uuid: 00001c91-0000-1
> src/device.c:gatt_debug() start: 0xa348, end: 0x000a, value: 0x5343,
> props: 0xac, uuid: 00004953-0000-1
> src/device.c:gatt_debug() start: 0x000b, end: 0x9d0f, value: 0x000c,
> props: 0x1e, uuid: 00006bf3-0000-1
> src/device.c:gatt_debug() start: 0x9d10, end: 0x6840, value: 0xa9f2,
> props: 0x66, uuid: 000012a1-0000-1
> ...
>
>  From parsing handle 8, he parses 3 16 bit UUIDs instead of one 128bit.
>
> wireshark has the same problem and misparses the buffer.
>
> The buffer is the result of a
> ATT_OP_READ_BY_TYPE_RESP opcode, which contains a unit length for the
> whole buffer, which is correct for some, but no all characteristics in
> the PDU.
>
> Comparing the attributs from my working with my not working device, I find:
> - The not working ROLAND has a total of 3 characteristics with 128bit
> UUIDS for the MIDI Service, the one needed ist the second one.
> - The device also contains an audio sink, which I think does not matter
>
> Now for the things that I don't know and where I could use some help:
>   - Bug in the bluez stack or should I write to Roland?
>   - I have no idea why my other MIDI Device works, mixed 16bit and
> 128bit UUIDS is needed in both cases
>   - How can I make sure that an attribute response only contains UUIDs
> of one kind? That seems to be required, since there is only one 'len'
> element.
>   - Any tips on what needs to be changed?

Well if the device is returning mixed UUID sizes then there is nothing
we can do to figure out since as you said there is only one len so all
elements should be of the same length, perhaps Android doesn't use
Read By Type procedure and discover them, anyway it is perhaps worth
notifying them about this problem given that it doesn't seem to
conform to the spec.

> Also attached is a wireshark dissection and hexdump of the "Read by Type
> Response":
>
> I have a very ugly workaround, but having spent way to much time on
> debugging this, I could also invest the work for a proper patch.
>
> Thanks,
> Jo
> --
> Johannes Deisenhofer



-- 
Luiz Augusto von Dentz
