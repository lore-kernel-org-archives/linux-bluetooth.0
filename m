Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327FC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C49C2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC3PhFnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfARNwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:52:05 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42982 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfARNwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 08:52:05 -0500
Received: by mail-pg1-f176.google.com with SMTP id d72so6087438pga.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aErJFSXgX5/ISerHxNZlQP570UcVdtJg+gAsEZ2XPms=;
        b=XC3PhFnWjTFiq8X9rarmTkMx2ttmHUjKElIY1yc3YI/svLr2iH56Y4tenpGXBNomLu
         grfWz2uInuucwUmka+7lY1rLbEPP0kLZg9BPYfnaCUxcBzYz512b3123EPTWaD3kWDoT
         bOj/FUCgWCjWeegwbvJggCqbeMwJwnf6Ix4EylcyZ4zVRCikcaFUXgGXLSb06h03xd1f
         4S/95qWYIzoeRJa9s9kLlvowe6+pyEkrj1CIz9SYTPQxJLTECDgTnWLUdjly25SPpxq3
         5wkrP71Kfids64uSx8V2iPZLShJsXgqw0Ade2SJy+HuaJmVzix0I8WlZL6eUq0kKhNvq
         HaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aErJFSXgX5/ISerHxNZlQP570UcVdtJg+gAsEZ2XPms=;
        b=H2QHRDi/ukusA6wslRa8hComYcOxmm/hPuDbOKr9YeW+pOGNypIh9SKyXZB6s3NG8Q
         ytZqxcb9YEp5+yMnOJNUFTM0Z5pLvByCrIZLJU4I29M3DEuuZvl6A+T96XCkNikSmTo+
         Yz7sNq8QxemhGxoDNnv/XxCW1kjCPifVqzgUeMKvNKmH0+RDywzCqgCg48gDvIJxPfwK
         kje9OS1RQkg0kWZGBO6nV9U5SXF4XaVYlClpM5i1m29ycHrNeN+iNjBn7W4FtGKKHdLH
         BGeXAH+iQi02Oi94vqquByITcqlckUi5YuTyevmfNQBeMI1Nhr2+e7rfn/xh6DoI/d8z
         A+cg==
X-Gm-Message-State: AJcUuke7XWy5m3AKOjg17WXdh0OpCIETW2CKOmBz4EnuARX9Q4Ac6YiQ
        4UGOz2B6IK3TdH+YpPXjSd7d30RmHgWw0aly8WI=
X-Google-Smtp-Source: ALg8bN5PQIySSX5sOscyiv7TVhJsoVFBiIMDU7aOG7giJRbnC3kN17ZH/2KXwfasmfEJySZI0lSWdlWh2MpJfZxKNvQ=
X-Received: by 2002:a65:55ca:: with SMTP id k10mr17574086pgs.448.1547819523513;
 Fri, 18 Jan 2019 05:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
 <49999069-238D-4FBE-8F38-3762788A67C1@holtmann.org> <CAEQQxWxAvZBX8simb7gNu6ob_0gGXzTEQuOybiP5MTV8dq5sEg@mail.gmail.com>
 <CAEQQxWxpi7FR=RDT1cLMDBUUGzHSfSrgngHL7dCK5V1eJOOu3Q@mail.gmail.com> <82ABD3A9-290C-4291-A84D-C4C2DE62CD17@holtmann.org>
In-Reply-To: <82ABD3A9-290C-4291-A84D-C4C2DE62CD17@holtmann.org>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 18 Jan 2019 08:51:10 -0500
Message-ID: <CAO1O6sfFqcQvn2Sy_HOLAzuc9o-Wu0g_9oLH-OFOkCxfuA=Jtg@mail.gmail.com>
Subject: Re: Bluetooth ECDH selftest failed (endianness issue?)
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Andrey Batyiev <batyiev@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Den fre 18 jan. 2019 kl 04:44 skrev Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Andrey,
>
> >> On Sat, Dec 29, 2018 at 9:35 AM Marcel Holtmann <marcel@holtmann.org> =
wrote:
> >> I think that our ECDH code was endian safe, but then it got changed at=
 some point to use standard crypto and maybe something went wrong there. Ca=
n just provide the btmon -w trace.log for the SMP pairing so that I can hav=
e a look at the binary trace.
> >
> > I found out that if I change "swap_digits" method in
> > "net/bluetooth/ecdh_helper.c" to
> >
> > static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
> > {
> > int i;
> >
> > for (i =3D 0; i < ndigits; i++)
> >        out[i] =3D in[ndigits - 1 - i];
> > }
> >
> > then BLE pairing on big-endian become operational. I'm not sure what
> > proper fix should be: is it a problem with crypto API usage or a
> > problem with crypto itself?
>
> if the kernel ECC and ECDH crypto already swaps for us, then we don=E2=80=
=99t need to do it again. So all the swap_digits most likely can be removed=
 from net/bluetooth/.
>
> Regards
>
> Marcel
>

The Bluetooth standard is a bit strange. It assumes the AES standard
is big endian (although it is really just defined on a byte level),
but since Bluetooth is little-endian everywhere, all AES 128-bit
values must be reversed when a standard AES library is used. In
particular, SMP reverses the AES values. So the swap_digits should be
kept.

/Emil
