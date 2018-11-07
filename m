Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EABC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0B62081D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owauRPJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0B62081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeKGVZt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:25:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38023 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGVZs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 16:25:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so6217611qtl.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sloe4SQJ9dIJuxlO9m+kA/Gxg9kyD12seUIwo0Rh5G8=;
        b=owauRPJxb/GImNtaEySRcXX5eLrCZEIA9SZPMCvCBUBdGddL6rmY98Ow2qdXzZiD1w
         kzByai2jF0V6mMkjLPC0a8VIOnHrfILf1A244w8wEucYjOVWMpTdmr8Hily3200h6uLt
         j8YVrFmCUap3trzjv7qE2WPx6LZ/uhXSQ+tchNiX2y1fnIMHZlHrdfNaNsAtw+psd32x
         UwRIXYukqu/e8SDXzKTX9bDJyrqp9xMQfSRQj5R4r0xKEl3LIdvQD+vHh93CZaJ/K0Vc
         4MYtILM1KuYBO4oJsnfxAR+KDNv538F0rwpLnJNS8gI2THPjyOeoyMGYmzw9AyKxzZ5J
         Ri+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sloe4SQJ9dIJuxlO9m+kA/Gxg9kyD12seUIwo0Rh5G8=;
        b=sZQal8fGmO1+hGkMjKIphUzCMHfY14snbnc9djaNMlmCd4Ngr6Ft/zUSXfb+gG1jso
         SABg2W/qAovllibgmMyoKo6/FTwABzFukWQBAIum3w/mJKVsjUCSq3Qn0XvGshsokWQ9
         vtmM+tOqj8g8xXS9JFGm+w9kNyW9bqc5uuqQkDEoZPl0gI+W6UfFcqkpUFRqadRUbFTZ
         zjhLPEmIypzquSm8ea8tfzT7G5p3yzecJoRs/cXw+o7JEpIBl/GkkPOm4KD0JFnmDwn5
         EJrjYnUBY5vkPEAkdsEDwkso9aDA71rALr+oHUMPD3cPg39k//NgcZ+dCHOlYCSCdYIw
         NYqw==
X-Gm-Message-State: AGRZ1gIc8NZpg689P4/XpjIEi5GT5KkptIFUKZF4p8jI7b9CZt30vdOt
        PAuu5xTfURpyQ2EgDEK061fT78RI4NmNVKUoGQY=
X-Google-Smtp-Source: AJdET5dvLWkXnQIzpi8JBshJCNDeFgRKrW4p7jDNFaDGhNa69FJ4rQxZY8+aciVPgWtHjyEhxxdPUUEi41ptm41QDeM=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr744201qta.110.1541591744935;
 Wed, 07 Nov 2018 03:55:44 -0800 (PST)
MIME-Version: 1.0
References: <1540456194-26031-1-git-send-email-jaganath.kanakkassery@intel.com>
 <CAJzH+brrSKy-oBLcpctz=oHg9a5Yb33ChBrgAWbgVeSuJgjCog@mail.gmail.com> <CABBYNZJR6tZVOShTyS-EoNsXxHpHxczc94GLmtgs6m+rrmFAmg@mail.gmail.com>
In-Reply-To: <CABBYNZJR6tZVOShTyS-EoNsXxHpHxczc94GLmtgs6m+rrmFAmg@mail.gmail.com>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Wed, 7 Nov 2018 17:25:33 +0530
Message-ID: <CAJzH+bqzaGzjPS=cW_-+aaUFNLom4f_Se8T7kcnpPQtgXd3B2g@mail.gmail.com>
Subject: Re: [PATCH v1] btmgmt: Add BREDR PHYs in PHY Configuration commands
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 7, 2018 at 5:10 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jaganath,
> On Tue, Nov 6, 2018 at 11:38 AM Jaganath K <jaganath.k.os@gmail.com> wrote:
> >
> > Hi,
> > On Thu, Oct 25, 2018 at 2:06 PM Jaganath Kanakkassery
> > <jaganath.k.os@gmail.com> wrote:
> > >
> > > This also adds LE prefix for LE phys to make it more
> > > descriptive
> > > ---
> > >  lib/mgmt.h     | 32 ++++++++++++++++---------
> > >  tools/btmgmt.c | 75 ++++++++++++++++++++++++++++++++++------------------------
> > >  2 files changed, 65 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > > index ec6a380..570dec9 100644
> > > --- a/lib/mgmt.h
> > > +++ b/lib/mgmt.h
> > > @@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
> > >
> > >  #define MGMT_OP_GET_PHY_CONFIGURATION  0x0044
> > >  struct mgmt_rp_get_phy_confguration {
> > > -       uint16_t        supported_phys;
> > > -       uint16_t        selected_phys;
> > > -} __packed;
> > > -
> > > -#define MGMT_PHY_LE_1M_TX              0x0001
> > > -#define MGMT_PHY_LE_1M_RX              0x0002
> > > -#define MGMT_PHY_LE_2M_TX              0x0004
> > > -#define MGMT_PHY_LE_2M_RX              0x0008
> > > -#define MGMT_PHY_LE_CODED_TX           0x0010
> > > -#define MGMT_PHY_LE_CODED_RX           0x0020
> > > +       uint32_t        supported_phys;
> > > +       uint32_t        configurable_phys;
> > > +       uint32_t        selected_phys;
> > > +} __packed;
>
> Is this a change in the protocol? It looks like the phys are now 32
> bits, or is this an actual fix and that the way the kernel communicate
> then? Either way this should probably be split from the changes to the
> PHY strings.
>
Actually we added BREDR packet types also to PHYs and along with that
made phy types 32 bit.
So this change is mainly for that. One more change is renaming of LE
PHY strings which i have
mentioned in the commit description. You want that to be in a separate patch?

Thanks,
Jaganath
