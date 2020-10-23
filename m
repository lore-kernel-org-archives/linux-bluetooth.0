Return-Path: <SRS0=0zex=D6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C5AC55178
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44342080C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 08:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePHbXwyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460864AbgJWIyF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460848AbgJWIyF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 04:54:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3048C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 01:54:04 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so1164742lfj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKLd0mpi10XjYtpvHGYA9xksbPT/j2c//vJhEsBF60M=;
        b=ePHbXwyhj8XqSO4JO8S9LoPHddPbHfeHUz0/rs9HWOl4CAfTomMWbZX9MCsqkeRbFG
         dRXhZi0TQKWbSCdEUldC2+wy4yuukbsPQ2ShSSjeoQgrCKxneyXprlH6DYNG+pJCxh8T
         xsmTbP32JsV44IL2uuORgARIdT7IGq8HTMGKSf+nCvxT3yPox9FrfJZJBlc3XKf/Cq+p
         FkvaPcujcskm4czEzJLwOZmnKgICofQPqgbUwWPqIanujkkVD2/IPuIl1dTZosVAs9XI
         cH+DLaUHO/l8I5wDJTn+/rkk0tq4EGzWgOkyCUYOULkh4ZUNMnPPdL/E46/y5a1z8UMh
         YV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lKLd0mpi10XjYtpvHGYA9xksbPT/j2c//vJhEsBF60M=;
        b=afwBeMTcyopBo20jm1wNUb33TaPhPn46l8J6LRjn5+NY+e3YxLdRRZHZ4xQjmwLR2t
         b7qNV2STBXVmZRqVGBCxUzlVDFPpJVb64y7ER1v9+vm1KRlUCzTzwn7WmeCuIoV8q9oZ
         xwmhGuHgAulwB6JQtBMRm+/VuQV1JBLTA3ax78W0ynkNhFGWv41AO9mmoloEmZsCrvv0
         X9ZLpalx5GJDN2xA0RK34cGvdwlYTj7PwDJEAEQZHVivITme0VdD8CpODplcw5DBZbXt
         YjdSGtcpzG+wGEvD6PZ3O4X00kQahB8vHMRR/4dDD3Qt1ohvDSSjxd3aN9YeKFKep64t
         HaIw==
X-Gm-Message-State: AOAM533u6V4LpuLf2OGWAQ3U3NEz8s1/rsQOpmuU05VlKZymBZuaweVS
        lsKoO70SKegF9FHh0PRTRW0=
X-Google-Smtp-Source: ABdhPJyXcUO6BMGI5VFNB5zqvd9PSty2cb12+4AJr8LTcrJ6q04nDP5pUkIPuFEp5x7O3SpHBXkrRQ==
X-Received: by 2002:a19:40ca:: with SMTP id n193mr374122lfa.96.1603443243125;
        Fri, 23 Oct 2020 01:54:03 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id y21sm76811lfk.49.2020.10.23.01.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 01:54:02 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:54:02 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: A2MP: Fix not setting request ID
Message-ID: <20201023085402.GB64331@jhedberg-mac01.home>
Mail-Followup-To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
 <20201019172529.1179996-2-luiz.dentz@gmail.com>
 <20201022210009.GA64331@jhedberg-mac01.home>
 <CABBYNZKJK+obAMiwnG+QWV4TNEdRxkajRonhwx_LPekNiH=t3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKJK+obAMiwnG+QWV4TNEdRxkajRonhwx_LPekNiH=t3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Oct 22, 2020, Luiz Augusto von Dentz wrote:
> > On Mon, Oct 19, 2020, Luiz Augusto von Dentz wrote:
> > > This fixes not resetting of the request ID when sending
> > > A2MP_GETAMPASSOC_RSP.
> > >
> > > Fixes: Bluetooth: A2MP: Fix not initializing all members
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/a2mp.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > The fix itself looks fine, but I think the "Fixes: ..." line should
> > contain the commit id followed by the commit summary within parentheses,
> > at least based on how I can see this style of annotation used in other
> > commits in the tree.
> 
> I did not add a commit id because it did not reached the Linus tree
> yet

Yes it did:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eddb7732119d53400f48a02536a84c509692faa8

Johan
