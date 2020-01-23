Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CBC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD4821D7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4yeCYkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWTE1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:04:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWTE1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 14:04:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id o13so4862245ljg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2020 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fmLMVkRzp/N1hHBHLYR1mm/ggH3hz1NN7z2tuRzXhQM=;
        b=i4yeCYknX+xaYoSzQtuY2UnnyEkZ6as2BlW03jraookWmDEcpxCLMGhe5eBjWlg8IN
         7fqsZKCYmvQFuM6Rrn4k/vqLBcpWIcBJK71xpW0Bs1L9jpTlxUbAQ/Ewk9HoXouMbev6
         UXdj7qfzYXc5Pv7QVRTXCCR2dQklRmSeSuNpZFGHDXWQqbjYNmqbMRydSz5caAaDff8d
         K/SnSFsIlDGRMK8pyV2G+NFX5whb8HRdYLZbUIKUoZObQBS45dAtCUpxUf0c4MO6m6uh
         CXiONTD9epgA5ukzkJRZm7B4QabhHx1j7Wt7PQJP/g+Pr18ycPFLVKHSsYT8tH46U+dE
         DTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fmLMVkRzp/N1hHBHLYR1mm/ggH3hz1NN7z2tuRzXhQM=;
        b=QqFbJHr3Qu+ju+shzSHD6jU15gN76XPwSf8gL3GNU7M34Ay2d2Zwgca8N3QNrlcov0
         9SM6JCOh/RCwvBc3sNTPPrsZiURehqNng7N5L20K1uSQ2ktHyFQhISu1s7qP4SpBofgB
         +5IFHJ9qkmqsMO/ZDYivTWWCB3VQvnf2kUj2yaswRcz6Oe39Cs1J/IA0+cTZx0SkIHdR
         dhsbA/+gqsRb2GdJJ6gbt90G+cf2cSjdWeEWHzFkEsaVcfiQejDQwWoYVVMqPhrCB6Ps
         PDI36Z8nc/bCuMeBWiZfPAYFr1nfagOMDcoQ4+rlMeQXANwzpSExtwIZr3clwkndH101
         Ul7g==
X-Gm-Message-State: APjAAAWjVMTKGNwO7XBiOigYBN5FpOUUHcHAkWOGzxZ5rC6R/QqOpwOZ
        gQYeesbxuD8y61/938jOq8c/ZUvRRJuDR82K/xkD8g==
X-Google-Smtp-Source: APXvYqwyeTzT/MPgXRVcCHG0JRcUQvgAMWU0LdCRVS8zl4KpQfhIZJanzdRMTP+tRLsb6IGBM4Ne89/p0qInLu8wRZM=
X-Received: by 2002:a2e:884c:: with SMTP id z12mr36209ljj.55.1579806265208;
 Thu, 23 Jan 2020 11:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20200118050410.257697-1-alainm@chromium.org> <37FDD376-5D3D-484C-9209-B59FACA22D0A@holtmann.org>
 <CALWDO_XWvfzRPQ0Ybnpe-x+mw-amrTOMP=PjUpDg0jnXVFRi-w@mail.gmail.com>
 <F6B3CCC4-592C-4F9B-A87B-AC1FF1CB9A78@holtmann.org> <CALWDO_VdPWaSa8MF-y5wB+h9EV9+=vSaPWXu64F+p0crqO84OA@mail.gmail.com>
 <6EF3C3FB-89A6-4B23-A4F5-ADC59FFB9F98@holtmann.org>
In-Reply-To: <6EF3C3FB-89A6-4B23-A4F5-ADC59FFB9F98@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 23 Jan 2020 14:04:14 -0500
Message-ID: <CALWDO_UpVApmeKy=679yGM7-Z62Kbd9Pj=9Xyy8FzjC3aHMkkg@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: Refactoring mgmt cmd op_code structure
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 23, 2020 at 1:42 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > I'll separate the simple one liner into a separate patch then will
> > wait for your suggestion for the rest.  Note that with a single jump
> > table as suggested, it will indeed allow us to defunc some op-codes
> > pretty easily.
>
> I have not fully thought this through yet, but here it goes.
>
> The read_version and read_commands are special since they have to be pres=
ent no matter what. So on purpose we put these two commands first when we d=
esigned the API back in the days. We can special handle them and thus also =
avoid the forward declaration. I am leaning towards this direction since we=
 might want to actually split commands over multiple files to keep this fil=
e readable over time.
>
> Now the downside with putting the opcode as a field in the data structure=
 is that we actually have to look through the every field until we find the=
 opcode and can not just jump to the position defined by that opcode. That =
means actually filling the table with NULL pointers for not supported or di=
sable commands might be better. We could still make the read_commands funct=
ion map the list of supported commands from that table.
That may be an acceptable compromise.  At least there would be exactly
one place to make sure things are aligned.  Perhaps we could also
leave the op-codes in place and create a test that ensures that if
!NULL then op_code =3D=3D index.

>
> This will still not fix the list of supported events since that is still =
static and will require manual patching.
Agreed and actually events are less problematic as there is no jump
table to fix up.  As long as it is in the supported events list, then
it works out pretty well, regardless of order...

>
> Regards
>
> Marcel
>
