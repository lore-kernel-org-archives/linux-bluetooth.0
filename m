Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D28C2F441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0AD20663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFpIdiGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAUQ5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:57:03 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:40537 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfAUQ5D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 11:57:03 -0500
Received: by mail-pg1-f169.google.com with SMTP id z10so9730308pgp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MH7TS4Dns7pWVYugCpKCvB8OzGTr/dW5VCs5dFODjJ4=;
        b=pFpIdiGzhjYOKqFXVGhRQ8Oi0o8uXa6Ch/D8zHa3C+dZztuNjQQubJdQj3j+Uy0EVP
         c2HSBjY3TILIMuj09oeUg6I6Jg+iJYjO0Jqk7N1dI/DJ7dwae0AYhnXea0BOSYooWbQw
         f3N/as0EsXaOHFh9bqKimgpKAdmCjf7zyySV52zcPcYYTOphwyi16oqxbywmayKu+aXr
         Y+be80HO7JGnRY9b+WKMAQmcC441nGbx1EZQnzcsDwWaE4mlQwaKHeMVJsgbAS1gGwlT
         chUCasBJ8jZM7EEJW/9Jn+AT/60121D7sohegNR8qd8pie1UvoTpm3Y57IKibXAKliGI
         VLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MH7TS4Dns7pWVYugCpKCvB8OzGTr/dW5VCs5dFODjJ4=;
        b=qZIi+8SJVoJmIGUSd0BdYKsOtGFYWNgxfE/WsbeHGrGZtkrWkeEHOyRYA0Ko9oSR2T
         GRcLnbgRRKOGdUK0hz1184aGZT0oLcPVF1U1BJ2po+gtWSuyhSJnoDW4eDVIBKYkY2dk
         n2pSlaqnMwotekM0qqZAxrmC6VHWDY2Pp2/aUbPOf9sfrg/nzBYsShsU9ANn9FtaAfCq
         4Lxdid4AMW5oRotA3qzadZerwmYf7B6fCzoE8xpeDyl7HzCDUzLAXanzPE61zNEJlR5B
         rp4KHsMptxx4RPN+RAOYT4/4v4gCYLMF7w4A72wBw6F3VhYi66wJiNREYCHw9CnUSjNg
         oBBA==
X-Gm-Message-State: AJcUukddgiKJe4M7S24fEGNXA5/wyInBZFLcJM4HYRfEr8m6HorRSzmx
        Xrr6NhJ3D47ODC3eidpqT4Y5CvNyZbFS0hm1fSc=
X-Google-Smtp-Source: ALg8bN7A1ihWE1+/UnqnA4WSHqBjYruV+QYfwOl7ThuRdEtvwW1F0CQV1I6b3A3l7dbihnP0Cn1YmOuzQmD5ltVZpNQ=
X-Received: by 2002:a63:314d:: with SMTP id x74mr28578830pgx.10.1548089821866;
 Mon, 21 Jan 2019 08:57:01 -0800 (PST)
MIME-Version: 1.0
References: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
 <49999069-238D-4FBE-8F38-3762788A67C1@holtmann.org> <CAEQQxWxAvZBX8simb7gNu6ob_0gGXzTEQuOybiP5MTV8dq5sEg@mail.gmail.com>
 <CAEQQxWxpi7FR=RDT1cLMDBUUGzHSfSrgngHL7dCK5V1eJOOu3Q@mail.gmail.com>
 <82ABD3A9-290C-4291-A84D-C4C2DE62CD17@holtmann.org> <CAO1O6sfFqcQvn2Sy_HOLAzuc9o-Wu0g_9oLH-OFOkCxfuA=Jtg@mail.gmail.com>
 <3955F248-39F8-4581-AA44-CBDE8394066F@holtmann.org>
In-Reply-To: <3955F248-39F8-4581-AA44-CBDE8394066F@holtmann.org>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 21 Jan 2019 17:56:53 +0100
Message-ID: <CAO1O6scoMDQbD0Dc4iq7Fgpas8FnO87+-TmL4egtYYCYwMzVLw@mail.gmail.com>
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

Hi Andrey and Marcel,

Den m=C3=A5n 21 jan. 2019 kl 15:53 skrev Marcel Holtmann <marcel@holtmann.o=
rg>:
>
> Hi Emil,
>
> >>>> On Sat, Dec 29, 2018 at 9:35 AM Marcel Holtmann <marcel@holtmann.org=
> wrote:
> >>>> I think that our ECDH code was endian safe, but then it got changed =
at some point to use standard crypto and maybe something went wrong there. =
Can just provide the btmon -w trace.log for the SMP pairing so that I can h=
ave a look at the binary trace.
> >>>
> >>> I found out that if I change "swap_digits" method in
> >>> "net/bluetooth/ecdh_helper.c" to
> >>>
> >>> static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigit=
s)
> >>> {
> >>> int i;
> >>>
> >>> for (i =3D 0; i < ndigits; i++)
> >>>       out[i] =3D in[ndigits - 1 - i];
> >>> }
> >>>
> >>> then BLE pairing on big-endian become operational. I'm not sure what
> >>> proper fix should be: is it a problem with crypto API usage or a
> >>> problem with crypto itself?
> >>
> >> if the kernel ECC and ECDH crypto already swaps for us, then we don=E2=
=80=99t need to do it again. So all the swap_digits most likely can be remo=
ved from net/bluetooth/.
> >>
> >> Regards
> >>
> >> Marcel
> >>
> >
> > The Bluetooth standard is a bit strange. It assumes the AES standard
> > is big endian (although it is really just defined on a byte level),
> > but since Bluetooth is little-endian everywhere, all AES 128-bit
> > values must be reversed when a standard AES library is used. In
> > particular, SMP reverses the AES values. So the swap_digits should be
> > kept.
>
> so you are saying just reversing is needed, but not swapping? But then th=
is is no longer swap_digits, it is just a reverse. What do you want us to d=
o in this case now?

First, I was a bit too quick. This is not about AES but about
NIST-ECDH. Nevertheless, the kernel API seems to assume big endian
order of the values regardless of platform, per the NIST
specification.

By looking some more into the kernel ECDH code, the Bluetooth code is
not the buggy one. Instead the ECDH kernel code turns out to be wrong.
The function ecc_swap_digits in crypto/ecc.c looks like the following:

static inline void ecc_swap_digits(const u64 *in, u64 *out,
unsigned int ndigits)
{
    int i;
    for (i =3D 0; i < ndigits; i++)
        out[i] =3D __swab64(in[ndigits - 1 - i]);
}

It is basically used to load a pointer-casted byte buffer into an
internal little endian representation of u64 values and vice versa. So
it works on little endian platforms but will fail on big endian
platforms. Applying your patch here is the correct thing to do, and
not in the Bluetooth code. But instead of using no swap for big endian
and __swab64 for little endian platforms, simply use the be64_to_cpu
helper.

/Emil
