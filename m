Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F5C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2111020704
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1TFgBwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAWOin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:38:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33229 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWOin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 09:38:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so2500721lfl.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2020 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nppDO3Klvkv401Q8hXNVvkXBC/xArfhyTCNbmFgCics=;
        b=g1TFgBwcDD7ApzYSZzc0ni8gv2bAvkb8VbX7xDPJXhhDVkdn2Uy8hemQdzIaU7zmQA
         H8lFVqMG/pkTHmH0vh7+vlqZ6ucnjFftFOpmrmkbGo9WKTaPlM1g5tEwt7HR7iZxgpDn
         1+j6OfnaJY8Qg8C0UyKD+azQUrxCBTY/+Le4ViWJbUA+AIInbUwfV3Gm4bKMSWhEhfOe
         lzp0YiM7o1HpmO7bCJjlTzByrHrDwgTlyr69RrL9yRAVDjS1zw+2tiGOdRy1FH/sY8qr
         CyUKWtlkMn6X49sSCve6l3lCBpneY+RdxsJCtNgjXIpUYzMRivLwSSUPdkKSQ4FTw4BG
         HvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nppDO3Klvkv401Q8hXNVvkXBC/xArfhyTCNbmFgCics=;
        b=qWw2SIrjM+ykQ1teQEMDpy6P6Xzu4FEQB7kQbRirchgcOWtJ/uAmVnf0wkT6GCrowu
         iDvHNstqMxQkOMx5IdAQoLVe/cuJNj/dEVuhbmWDj64+x1YKzomIdW1U5Ce26lCzp/fr
         fltyO0UqIyKH6o4d+GiuBHTtc9L0AIXqCm608RbCDFndnakD76SdKHS6UHNLlxFHDyxv
         41UQcsndide43nwgxpazKDACiJiFBhiIMd3o17Ppf3BqsU+Tr4fisPdroGBnXEh9F8vt
         ScnvEtv9VzrwmAsob863LSzSINtHhRZrY+zYDn2+SDjAzoiMz85361NNcJ/nQcbw5hOs
         H7Qg==
X-Gm-Message-State: APjAAAXRp/6kA2IPhuT+B1tFKWrmCz5qZVaip50QpoeheQQ9Qznw19LA
        xYTUt/19mdEdxWa+MmqNpx+sBBxwT2DBZjENpn7w5w==
X-Google-Smtp-Source: APXvYqyMU+/8XWzu2ZLheerp8ohH8xswBaIZKeQHEVynFRAUy6BKFj+2XHb0HaS51pnRkV8Ltzj+ia9B4/oDfIZwI58=
X-Received: by 2002:ac2:51de:: with SMTP id u30mr4725453lfm.69.1579790320956;
 Thu, 23 Jan 2020 06:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com> <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com> <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org>
In-Reply-To: <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 23 Jan 2020 09:38:29 -0500
Message-ID: <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Thu, Jan 23, 2020 at 12:52 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> > Thanks for your patience.  After further research dynamic_debug is not
> > available on retail chromium os user systems for a variety of reasons,
> > some of which you can find in this trail:
> > https://bugs.chromium.org/p/chromium/issues/detail?id=3D188825.
> >
> > Given we need to be able to diagnose things in the field, this is not
> > a good option for this.
> >
> > I hope this helps explain or justify the need for this interface.
>
> the reasoning from Kees is 6 years old. Are his issues still valid?
>
> So I have been looking into pushing bt_{info,warn,err} into the btmon tra=
ces. That is why we have bt_dev_* etc. error macro and have changed a lot o=
f code to use them. This will hopefully allow us to have errors and warning=
s directly in the btmon traces. For bluetoothd errors and warnings this alr=
eady works btw.
>
> I don=E2=80=99t believe that I want to duplicate the dynamic_debug functi=
onality and push even more info into dmesg ring buffer that then needs to b=
e collected and aligned with btmon traces. The big advantage is if you get =
a btmon trace and that has the actual message right in it at the right plac=
e with the right timestamp.
>
> If we push bt_{info,warn,err} into btmon, it might be simpler to do the s=
ame for BT_DBG, but it will of course require extra work since our BT_DBG s=
tatements are meant to be compiled out if dynamic_debug is disabled.

The rational is all still relevant today.  To give you some additional
background, here's how a version of this is currently used:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1697851

Note that I don't expect us to upstream this as is, in particular,
it'd expect we'd also want to forward to pr_debug to support
dynamic_debug for systems where it makes sense to use.

>
> Regards
>
> Marcel
>
