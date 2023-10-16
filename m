Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87FFCDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 06:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPGjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPGjA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 02:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432E97
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Oct 2023 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697438291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cifvyOUkqDm99gRqA7r8HDAmuZ+jj3vv6LzHyAB/feI=;
        b=Bfvg4A1jEYLReoydDFhGJjkLR04R3tpqofgUgoT8R5blFhphjYqxN+t+1sxfWkgDVEb9zF
        iOmewbd7R7zl5hpCHl7jpkeShGYmmcyGy3y0G4Zuz8ppg7NGB/PuX/BIHW9M6qJCFN37L+
        30fYgzhAU/+c0aaxMljSYH6CDwePHEY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-fJ7z5jAVOI-uCIP7b89yIg-1; Mon, 16 Oct 2023 02:38:09 -0400
X-MC-Unique: fJ7z5jAVOI-uCIP7b89yIg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b2d2d8f9e0so51067866b.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Oct 2023 23:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438288; x=1698043088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cifvyOUkqDm99gRqA7r8HDAmuZ+jj3vv6LzHyAB/feI=;
        b=pW/GdTrgd5FIhCCoWvT3OZQpgl0DjdCsOEkL1yASRQxsXL1Ie2fPNYrsy/9N0r+hd/
         Xis/hSDLScFmOLPHD0xLMROAMToF1SQ7wZe8qdKcPRHPb76mQcYBOenYqe2aFUVcTzo0
         GgBDamdcDOGFnyPEGfMmphZR8JTEnS3Z+X/ny1bRvOLKqL/TQbySZL7BnJuzlhLHw995
         xD/eN2fKg7n45JPAvQt92O7Zv6+bKiry0gAzIEyigOxPTuNpcvJkey7yx4TIXNl+GkSE
         s5kZaQ2qD9ic1N4i1HxljfjdQl4MwUntzhGiTorjO8q3HG6GFCkentv2YcVt2oiGnv91
         1uEg==
X-Gm-Message-State: AOJu0YwEGoUiNgGMhqbL8I3gJsteCXLF7RtjmusF7MGTtVfsC0HJ0B2e
        nuyQ1LUykMEU/BYg4/qEz0fqfGOJV7OUsLnqFglNNZmsDP+vHOh+i6gXoOVfJ4v3qMRfIWKmfkx
        CXXn9EjfJ47rxzEBUDY702zNa0dXX
X-Received: by 2002:a17:907:7d86:b0:9be:4cf4:d62e with SMTP id oz6-20020a1709077d8600b009be4cf4d62emr5865229ejc.5.1697438288021;
        Sun, 15 Oct 2023 23:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkR1i0Sh+EH7Z7RwQC8HFYLm0NaqBGAtpxuoR8egMYiDQuV9OHzfRfOzWFHGoA+PwFm0GqbA==
X-Received: by 2002:a17:907:7d86:b0:9be:4cf4:d62e with SMTP id oz6-20020a1709077d8600b009be4cf4d62emr5865211ejc.5.1697438287595;
        Sun, 15 Oct 2023 23:38:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-136.dyn.eolo.it. [146.241.231.136])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906535b00b0099ddc81903asm3417011ejo.221.2023.10.15.23.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 23:38:07 -0700 (PDT)
Message-ID: <57af5c65ee5510ce03c451456679be7654a4047b.camel@redhat.com>
Subject: Re: pull-request: bluetooth 2023-10-11
From:   Paolo Abeni <pabeni@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Mon, 16 Oct 2023 08:38:05 +0200
In-Reply-To: <CABBYNZ+A9Zk8HbQBPNXFLbaR_maCY7o5qHtx_MTJqhQ=LNBMPQ@mail.gmail.com>
References: <20231011191524.1042566-1-luiz.dentz@gmail.com>
         <20231013175443.5cb5c2ce@kernel.org>
         <CABBYNZ+A9Zk8HbQBPNXFLbaR_maCY7o5qHtx_MTJqhQ=LNBMPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2023-10-13 at 20:12 -0700, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>=20
> On Fri, Oct 13, 2023 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >=20
> > On Wed, 11 Oct 2023 12:15:24 -0700 Luiz Augusto von Dentz wrote:
> > >  - Fix race when opening vhci device
> > >  - Avoid memcmp() out of bounds warning
> > >  - Correctly bounds check and pad HCI_MON_NEW_INDEX name
> > >  - Fix using memcmp when comparing keys
> > >  - Ignore error return for hci_devcd_register() in btrtl
> > >  - Always check if connection is alive before deleting
> > >  - Fix a refcnt underflow problem for hci_conn
> >=20
> > Commit: fc11ae648f03 ("Bluetooth: hci_sock: Correctly bounds check and =
pad HCI_MON_NEW_INDEX name")
> >         Fixes tag: Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab =
oob read in create_monitor_event")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: 6f0ff718ed67 ("Bluetooth: avoid memcmp() out of bounds warning"=
)
> >         Fixes tag: Fixes: d70e44fef8621 ("Bluetooth: Reject connection =
with the device which has same BD_ADDR")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: b03f32b195df ("Bluetooth: hci_event: Fix coding style")
> >         Fixes tag: Fixes: d70e44fef862 ("Bluetooth: Reject connection w=
ith the device which has same BD_ADDR")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: a9500f272b3b ("Bluetooth: hci_event: Fix using memcmp when comp=
aring keys")
> >         Fixes tag: Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore N=
ULL link key")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > :(
>=20
> Not sure what I'm doing wrong, because verify_fixes.sh doesn't
> actually warn these for me, or perhaps it needs to be used in a clean
> tree/new clone since it may match commit ids of different
> branchs/remotes?=C2=A0

Indeed verify_fixes will match any commit in your tree. I personally
stumbled upon similar issues while doing backports - when references to
different trees converged in my repo.

One things that did help me is using a specific, clean, clone with a
single remote for all the netdev patches.

Cheers,

Paolo

> Anyway, I'm preparing a new pull-request.

