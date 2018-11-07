Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF5C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B320827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGLT5ELk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6B320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeKHBue (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:50:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39450 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHBue (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 20:50:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so15254560oth.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIzaJ49sIRmfrdVoc/UOWc1iVo6Z2tVCjb6gAFk4a3Y=;
        b=OGLT5ELkerpLShKDlUQC23uFh0MnqdmkB+ZGFtz3N1Dk3dG43CXwFnfRWu/d2nZ24q
         kVIiXDAly9tZSr/p4JzRR/e5TOF4ZdZEifwsZCAklhYT88RHiL6nYuh/5a6lp6G/o3c0
         tmJdZ8w+ALDiySjDSokJTTZUhL4fJYQ2OtLzIeejkezifVh38jkMQDW6oNpfwd2VKhdv
         yWccNCWuF0whnTjw8Sagn2sG2TOX4+8spdHGNqFH2V3mC6E/99oKdqOnuckTVKh3ydsg
         4miPoqlz5MDVtCZ/72eGfQp/NLQLjkSWP4UiwIXu7JGhq/vmrRH7cZqubttKoG5W9YLq
         C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIzaJ49sIRmfrdVoc/UOWc1iVo6Z2tVCjb6gAFk4a3Y=;
        b=gkxm8XG4zenImt5YZWPSYBEq7zWgHj7L68Hvidk+I0tfxOUz7kpjqZ4GjOsmuaanJp
         M4CwMbuxYNiBZGNdRlCcSa1xP6ases7HCWwXdL/feMmVas/egCJEsjBYhZgYqCivt2W2
         25o6K9EbEJLnYsk4HzPxnrrIgblYPiblgWut+qb5o8EQCFYYqZLc+2hpbJ9f3x5zcHCs
         cYVxsbFkOKlRF0WF03j0vQSHpHgFWTtgfqRNq/c8CcrB/rZXL58r6Xsak/bq0wJ+idcp
         o8xGIxYw1ZEBDMvyT4HbpFl8q+SgxFlISPRHkcnolUTBjVU6BKfjyJCbLyET6O23qbhd
         /w/A==
X-Gm-Message-State: AGRZ1gLvFNIgilLuzIqIoRuP60fW4pfxjwpz/fDdkeC1gEaCAFNZaQVa
        YD2Di4Syk7huNB8CJ87qPkgZHMPPr5BfRiKTVe8=
X-Google-Smtp-Source: AJdET5d3HRUeKEZj8xX1/lJPOkBVfLnXULZ2yPI9qOzig6uDUCfHLSPzRp+368refqmJcjA0+puzQTlvibtuWapYbZg=
X-Received: by 2002:a9d:2b8f:: with SMTP id u15mr542617ota.84.1541607571630;
 Wed, 07 Nov 2018 08:19:31 -0800 (PST)
MIME-Version: 1.0
References: <1540456194-26031-1-git-send-email-jaganath.kanakkassery@intel.com>
 <CAJzH+brrSKy-oBLcpctz=oHg9a5Yb33ChBrgAWbgVeSuJgjCog@mail.gmail.com>
 <CABBYNZJR6tZVOShTyS-EoNsXxHpHxczc94GLmtgs6m+rrmFAmg@mail.gmail.com> <CAJzH+bqzaGzjPS=cW_-+aaUFNLom4f_Se8T7kcnpPQtgXd3B2g@mail.gmail.com>
In-Reply-To: <CAJzH+bqzaGzjPS=cW_-+aaUFNLom4f_Se8T7kcnpPQtgXd3B2g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Nov 2018 18:19:19 +0200
Message-ID: <CABBYNZLmT3QQqfwd0ukj4h0iaEp1B_-D6qPO4RgPp7j_KR6z3w@mail.gmail.com>
Subject: Re: [PATCH v1] btmgmt: Add BREDR PHYs in PHY Configuration commands
To:     Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,
On Wed, Nov 7, 2018 at 1:55 PM Jaganath K <jaganath.k.os@gmail.com> wrote:
>
> On Wed, Nov 7, 2018 at 5:10 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Jaganath,
> > On Tue, Nov 6, 2018 at 11:38 AM Jaganath K <jaganath.k.os@gmail.com> wrote:
> > >
> > > Hi,
> > > On Thu, Oct 25, 2018 at 2:06 PM Jaganath Kanakkassery
> > > <jaganath.k.os@gmail.com> wrote:
> > > >
> > > > This also adds LE prefix for LE phys to make it more
> > > > descriptive
> > > > ---
> > > >  lib/mgmt.h     | 32 ++++++++++++++++---------
> > > >  tools/btmgmt.c | 75 ++++++++++++++++++++++++++++++++++------------------------
> > > >  2 files changed, 65 insertions(+), 42 deletions(-)
> > > >
> > > > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > > > index ec6a380..570dec9 100644
> > > > --- a/lib/mgmt.h
> > > > +++ b/lib/mgmt.h
> > > > @@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
> > > >
> > > >  #define MGMT_OP_GET_PHY_CONFIGURATION  0x0044
> > > >  struct mgmt_rp_get_phy_confguration {
> > > > -       uint16_t        supported_phys;
> > > > -       uint16_t        selected_phys;
> > > > -} __packed;
> > > > -
> > > > -#define MGMT_PHY_LE_1M_TX              0x0001
> > > > -#define MGMT_PHY_LE_1M_RX              0x0002
> > > > -#define MGMT_PHY_LE_2M_TX              0x0004
> > > > -#define MGMT_PHY_LE_2M_RX              0x0008
> > > > -#define MGMT_PHY_LE_CODED_TX           0x0010
> > > > -#define MGMT_PHY_LE_CODED_RX           0x0020
> > > > +       uint32_t        supported_phys;
> > > > +       uint32_t        configurable_phys;
> > > > +       uint32_t        selected_phys;
> > > > +} __packed;
> >
> > Is this a change in the protocol? It looks like the phys are now 32
> > bits, or is this an actual fix and that the way the kernel communicate
> > then? Either way this should probably be split from the changes to the
> > PHY strings.
> >
> Actually we added BREDR packet types also to PHYs and along with that
> made phy types 32 bit.
> So this change is mainly for that. One more change is renaming of LE
> PHY strings which i have
> mentioned in the commit description. You want that to be in a separate patch?

Right, well we can go with a single patch since you would have to
change the btmgmt anyway, though I would add the change to 32 bits in
the patch description.

> Thanks,
> Jaganath



-- 
Luiz Augusto von Dentz
