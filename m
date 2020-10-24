Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65633C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F16522274
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD0EHiZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756253AbgJXAY3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 20:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756249AbgJXAY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 20:24:29 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CECC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:24:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o14so2987552otj.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E4ekgIU6WasOt/Gf2fDfVdquVnYldF3bZVa1GB9jUOs=;
        b=MD0EHiZinXYW7N2sGLYyn2flx9N4mVW+xn1jC2T/RdMxCX38TxCpuB+xu4yueSTBEf
         b+D8cvvEsXvs3uRvkQCBDjFL/aeDU+FpwVJOf14HelleqDPVa/wWPX7NjgcSw9Ch9fzM
         KGSz7oEQrvcMOdWywZeArP8eO48G0VZlRYTCUC5hnQ5+BDCsLqccgRT0aPJ42dVS5oQG
         Y71/pJi01vbcrD1OSHe/AbPCkLU/NZM4M/AOKEbw9CktaSgHVqXRkHRPs+LKaZm+xHGj
         i9uhk+nCzPXxbiimNPGBraVgwhNZR/yheJcM2KOsv6ZU7gD4sHvCkd7rg/LVpD2XPCjt
         QkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E4ekgIU6WasOt/Gf2fDfVdquVnYldF3bZVa1GB9jUOs=;
        b=J9yz8Ykoc2w8l7YKwg3IwhhvSQRYaIm/eBJ4mtPkzkr9ww+AFVgVD0HBuEncML5ZRU
         AWeBHwJliC90BFp2/mVOLfYF5ObI2IgPt2AvTVIOdM9tXFrDyK/qfCxrCNuJx6NA7/PX
         0xKqocHBEwi18L4NLaSXh7qU9VKb5pY143stH3An7C908eZwqR4x1t6cQB3b8nTbNrv+
         zJo+E74n6Dxnsy1FNRrf7T9kQ3SfI/ql7bQmsO8FHSdq4mGukcsiMpLP+bxC2AAv9p8Z
         fEZPa0OMYRKckUzud9wwmz6lPrXXavx/TXqCKDuN66NCisI0A/uxwNvWAgh/MAvyx1YS
         1GUw==
X-Gm-Message-State: AOAM531BPxXjQR/rG47LsCJOMPEvuWYzwQ0F+U4jIwUILBawMwCXOet7
        LSal98QKpJaQ+EAU7XrbDzyVmid6hhhvwe9w9a0vH1ZAvfA=
X-Google-Smtp-Source: ABdhPJzSsyrI55xrovE6gkHE6ogq0Pj7X2EZZOW8VOZMlTOQT9u/Dm+xrskIpYARkschqjJ1JOh3IzpRLB7vdmn1JkY=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr4118341otn.44.1603499068636;
 Fri, 23 Oct 2020 17:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
 <20201019172529.1179996-2-luiz.dentz@gmail.com> <20201022210009.GA64331@jhedberg-mac01.home>
 <CABBYNZKJK+obAMiwnG+QWV4TNEdRxkajRonhwx_LPekNiH=t3g@mail.gmail.com> <20201023085402.GB64331@jhedberg-mac01.home>
In-Reply-To: <20201023085402.GB64331@jhedberg-mac01.home>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Oct 2020 17:24:17 -0700
Message-ID: <CABBYNZKBAn3bWZUYw_X=ki_ocZvqLv3aL0-67o0AU3OXZU0XtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: A2MP: Fix not setting request ID
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

On Fri, Oct 23, 2020 at 1:54 AM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Luiz,
>
> On Thu, Oct 22, 2020, Luiz Augusto von Dentz wrote:
> > > On Mon, Oct 19, 2020, Luiz Augusto von Dentz wrote:
> > > > This fixes not resetting of the request ID when sending
> > > > A2MP_GETAMPASSOC_RSP.
> > > >
> > > > Fixes: Bluetooth: A2MP: Fix not initializing all members
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/a2mp.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > The fix itself looks fine, but I think the "Fixes: ..." line should
> > > contain the commit id followed by the commit summary within parentheses,
> > > at least based on how I can see this style of annotation used in other
> > > commits in the tree.
> >
> > I did not add a commit id because it did not reached the Linus tree
> > yet
>
> Yes it did:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eddb7732119d53400f48a02536a84c509692faa8

Somehow I missed that, or git.kernel.org was playing tricks on me, Ive
now updated the v3 to include it.

> Johan



-- 
Luiz Augusto von Dentz
