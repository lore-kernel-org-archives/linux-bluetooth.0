Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC36C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D3F2074D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML1859Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHNKtf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgHNKt2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 06:49:28 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0FC061384
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:49:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v13so7746825oiv.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1a9PUcYGX9ux4Mfdps7vP428ddbJQAbnf/pLAoi3NE=;
        b=ML1859OaZObRxKMk/2VNFzxEVwB2nJYUW59jyN7MUugdjW/tQLlKaL2VNn6cDUaYTb
         p7iVLIVe19Ph3bWbpBplhfZZi2H8OWHh3rHyOnykbNoSnbRxcT8fXdVmNUQlsGCrcxRy
         ZM+BABJtrx/EHKIqIRkguzj8t+26wsWSQjSB6qf7kJgRg9Wxi9I8OBvCwiIIw/tBxZih
         XFwxU+Eoqjq7WDNxq47lJNQclz90LAmUBEhX9L5F7viWrQsgZsgJlKmRGEVwxlPA5avw
         ky804lWqTFS1qUOPL4VKWWjYorStIS7PyfqJIr+e6PrmsD6uv4UoutfJS/KxvGxDzqPp
         trFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1a9PUcYGX9ux4Mfdps7vP428ddbJQAbnf/pLAoi3NE=;
        b=S5rRaot9Hz0h/bo83/fulCPrbcjA3FyI3aIes9EVj6uai5RglT2ZecT6iogTaRujiy
         swHJM2hiwPlZLQm9mE2tN4w39Cc6LTda+PCpMNhiUEtt1l33umhqDR9RTwwMSGK6RTFf
         zrp4cMgWs13hgYPfXkYSrx0cSSvu7FijXmimRCnHgGbuirFixo6JEf+qFWpZ56g+jT15
         Vg0WaM8uox2cFLzHsk3LLRewzEAZVP0Vaqr11S5Sx2we6bly0yI0b3zHmdUH34d/tUwk
         ojsE1Z1Yy8qLolj0ysgngk5pd2eKquQYox9c7s4Mnrenc3j9QYRBsE6RxPwn48/DmKLN
         ufWA==
X-Gm-Message-State: AOAM531dwWkKfYu70ZkXJEVNiwnA1rjckSD9t0Jf+ljLMOu8uArqOVbk
        OINDZCsZfLCeD5unQ8nNS8pQrGzpKemCZr2D755JSMe0xCwsag==
X-Google-Smtp-Source: ABdhPJxYZONl/LYYpixLR3pAvv24CKhn7JLDHImieUooe5qgUUa+13VbXPz/RQ3UZYPk20QeAC38ZULW1qBU+QV8/lE=
X-Received: by 2002:aca:c38c:: with SMTP id t134mr1110680oif.15.1597402162069;
 Fri, 14 Aug 2020 03:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <edd02903-6460-76c0-7b96-169c15d42699@student.tugraz.at>
In-Reply-To: <edd02903-6460-76c0-7b96-169c15d42699@student.tugraz.at>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 14 Aug 2020 12:49:10 +0200
Message-ID: <CAO1O6sf5WKvFZxzRnRo2UweFSJ-0Z7OkQXyfcu6nc_BTjOGq7w@mail.gmail.com>
Subject: Re: [BlueZ] BLE Security Mode 2 Support
To:     Christian Seifert <christian.seifert@student.tugraz.at>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

Den fre 14 aug. 2020 kl 11:21 skrev Christian Seifert
<christian.seifert@student.tugraz.at>:
>
> Hello,
>
> i am trying to implement a communication channel that uses BLE Security
> Mode 2 Lvl 1 or 2. Both participants that need to communicate are
> Raspberry Pi's running Raspberry Pi OS and BlueZ as Bluetooth Stack. The
> data i want to send is already encrypted which makes Data Signing
> interesting for me.
>
> Does BlueZ Support BLE Security Mode 2 Lvl 1/2 and if yes how can i
> access the functionality?
>
> Furthermore in my research to find the answer for this question i always
> seemed to come across Security Mode 3 mentioned in combination with
> BlueZ. Does this simply refer to Security Mode 1 Lvl 3?
>
> In order to find an answer for this question: I searched the web
> rigorously / Tried to find an answer in forums / Read the Documentation
> / Tried to read the source code / Checked the archives
>
> As i found nearly nothing regarding this topic my last resort is to ask
> this E-Mail Chain and i would be extremely gratefull if someone would be
> able to answer my question or tip me off into the right direction.
>
> Thank you very much for your time and help in advance!
>
> Best regards,
> Christian Seifert
>
> PS: Please excuse my poor Translation attempts as English is not my
> first language. I will gladly try to rewrite any confusing or misleading
> parts in my message if pointed out!

I have worked with BLE for around six years and I've never heard of
anyone using security mode 2. It seems like it's one of those
"wouldn't-it-be-nice-to-have" when they designed this many years ago,
without understanding the idea is quite bad when security mode 1
exists which is superior. There are not many benefits of using this
over security mode 1. There are more cons:
- Data is not being encrypted, only signed.
- There's only one single kind of ATT packet that can be signed, the
"Signed Write Command", which is then used by GATT "Signed Write
Without Response". This means that no read/write requests,
notifications/indications or service discovery can be signed. It's
therefore not possible to sign anything in the direction from a GATT
server to a GATT client.
- The signature consists of a 8 bytes CMAC signature followed by a
32-bit message counter. You can therefore only send up to 12 bytes
shorter packets for a given MTU.
- The signature counter must be updated and stored on flash after
every message, and must be preserved across reconnections and reboots.
For embedded devices with a limit of write-erase cycles this could
potentially be a huge issue. With security mode 1 this doesn't happen
as the link layer packet counter is per connection and direction, and
can therefore be stored in RAM.
- A "MITM hacker" could potentially receive a signed message,
disconnect from the sender, and a few days later connect to the
intended receiver and deliver the message, without the receiver
noticing it has been delayed such a long time (assuming it didn't get
any packet with higher counter in the meantime).
- Packets can intentionally or unintentionally be dropped, without the
receiver noticing that there are missing packets (assuming the
Bluetooth stack doesn't expose the counter to the "application").
- It requires a specific API for the application to use (signed
writes). With security mode 1 it's the lower layer that encrypts and
signes everything and your GATT application can be the same regardless
if you're unencrypted or encrypted.
- If you implement this in a GATT server and the GATT client doesn't
support signed writes, you can't really know or ask the GATT client if
it supports signed writes. Even though the CSRK might be transferred
during bonding, you can't know if signed writes are actually supported
(yes many bluetooth stacks are stupidly made like this).

The only benefit as I see it is that it requires 2.5 less round trips
than setting up AES-CCM as in security mode 1.

Generally the support in different Bluetooth stacks doesn't seem to be
that good. For example Nordic Semiconductor's soft device doesn't
support security mode 2.

It seems the dbus gatt api supports signed writes, by reading the
documentation and code. Simply set "type" to "command" when executing
a WriteValue. Signed authenticated writes will be used if the
characteristic supports it and the link is unencrypted, otherwise
normal Write Without Responses will be used.
For the GATT server, set the characteristic flags to include
"authenticated-signed-writes".
I'm not sure how to make the bonding and connection setup to actually
use security mode 2 instead of mode 1 though.

Security mode 3 doesn't exist for BLE. It exists for Bluetooth classic
though, so maybe that's what they're referring to.

/Emil
