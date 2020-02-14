Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A8C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B82086A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 18:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVNlNM/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgBNS0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:26:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44966 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbgBNS0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 13:26:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so10272619oia.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2020 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KgVOFyOZ+a9ix5l6En2g5zR0wBoOVgcTRgg+tuBAT5A=;
        b=CVNlNM/Hv2X27cs1gU11Dw47A4YDwMUj0pJC35tDPMNjxiWaGhIW6LyxlE7//WDSKN
         EfPt/zUjFoTb+hi4keoVZvka5OLP3xuyYPXUqlPYf/r9jv2guQ8PZvZIoJ/qk75nYfab
         qVOT64P01GQAiz0qzfC9KI0BZF8PvD25nE4XiwTTXY3npvO2f1jYvBGe9jGk+hwTTXwF
         9tkQE/6CqVOq6cKravHPhPMMcvUuUMXaM4ROizW0DPsUB5yrLg0MjJHFUM0hmrmT9Yb3
         ol0/cw61OVxDe8npNZFYWBCraD2VIF6P5lGmnfrteDQkJg40kQDBLgtSOwMNyaErjfjG
         p8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KgVOFyOZ+a9ix5l6En2g5zR0wBoOVgcTRgg+tuBAT5A=;
        b=mwzX4RdQfvy72LFmtqHVQI0Cslin3pGRwotGg5Z6JSZt5kxfUMkDLHFVWQld3XkJQx
         bQC64hdeuyrko007qMouGDkCqSEFUuzgE5SER8wddGg+y+FtPLGbkynIo1UtUrJ+PNPj
         QlwzaJN7F9cQri85dKVR7Q2B/zu3PbmFQuviBkk0rzRqTmAT6q3aanUw5W2WNonuWFYA
         nnfAhk47mGE3xpx1weHLPFayvCBsZArxQ50WAPMOo5BKs35Ng1TWK2/QL07uImKXetBv
         FAfT0PWQv0q/X2JuQXlNLsch60D8p7aAxMlhLdjbg2g0bXYXbgMQHyIsGRVN8dze4CwF
         tILw==
X-Gm-Message-State: APjAAAU74gfUZUnoNe6+LGPfqcW/f7m8/spYiX86xGlLPv2qv4c3rJBj
        W3ZGQ8fODXHqudgQafpxWwV8AmPL0+3Nt1y9BvA=
X-Google-Smtp-Source: APXvYqz+jfhBX8dnN11k/KHaKn+E2HZRqt051GAqW5Hch/48BeA7DEEyJXrowMR/uBgywCdIz8juKRJSIddVwxCILUc=
X-Received: by 2002:aca:ab51:: with SMTP id u78mr2792877oie.21.1581704800388;
 Fri, 14 Feb 2020 10:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20200214114350.Bluez.v3.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
 <1BEAEE28-6159-491D-BCCC-4C5298891987@gmail.com>
In-Reply-To: <1BEAEE28-6159-491D-BCCC-4C5298891987@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Feb 2020 10:26:29 -0800
Message-ID: <CABBYNZ+x5r_YY7jJ=oDdpcshvvoJWm_eXpj+DbCbFGg79R4j-w@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] core: Add new policy for Just-Works repairing
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Feb 13, 2020 at 11:35 PM Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
>
> Hi Howard,
>
> On 14. Feb 2020, at 5.45, Howard Chung <howardchung@google.com> wrote:
> > @@ -6141,6 +6141,22 @@ int device_confirm_passkey(struct btd_device *de=
vice, uint8_t type,
> >       struct authentication_req *auth;
> >       int err;
> >
> > +     /* Just-Works repairing policy */
> > +     if (confirm_hint && (device_is_paired(device, BDADDR_BREDR) ||
> > +                             device_is_paired(device, BDADDR_LE_PUBLIC=
))) {
>
> Wouldn=E2=80=99t a single call to device_is_paired() using =E2=80=9Ctype=
=E2=80=9D (the address type that=E2=80=99s part of the mgmt event) be the r=
ight thing to do here?

+1, other than that it looks pretty good now so we should be able to
merge after this change.

--=20
Luiz Augusto von Dentz
