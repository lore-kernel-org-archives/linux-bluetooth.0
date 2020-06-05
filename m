Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D3CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A224E2074B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYs11rof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFEODg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFEODg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:03:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98140C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 07:03:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so11887725ljh.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozOg08l65NDHJjFSr5S725SVOnHBb072rjbVSbt38Ao=;
        b=NYs11rofsZVgCK+sVGPZCkGY9W2TfVz4wa5EOwccjhl+BHzV4BF2TYqPhauGLdKmYc
         irm/3tF5d27qXG0DF4a8ikkOU3Sg+vJVPy14jfgr7+humRP+URiiG/oc6tHbgsdEHicI
         6EkCj7Xzir4CPlAXA92yxg0PSrJ0sKNzMB9lrLzvibYtDwdni725aVrvPZ8UdfHoN1kF
         6EZ0xhEHXn8IvA/zIqcI/Z/s+QN/3usn+ssWeZHBQGiFEgftyaJn3Yt8qAvCKAAPkQoQ
         xNnC4hYzHSpNGO9g6Q7b9B4ASL1p04HrbktBBeVslCbuA26r4mp9rhAmiwZ3Z5DHWdTk
         jUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozOg08l65NDHJjFSr5S725SVOnHBb072rjbVSbt38Ao=;
        b=FhTNO23atkZG1zfqy9mC1u/zkiixJ+ZhqOQA2ZKFjgt6TdaMXguhznR4VGuRerkvzi
         RaIXfRSJygDC9FNWswvAAsMj6g+YpEbTj2UL8flRkHt9vWTCh/MErrW1J+jsLPij37rF
         SkVyVyyb4HptpKrk+rvDQZJ49JAk5OBAkW7hz2IoMnuQ8P0CWJq4Ov46NhG+KmXxNA5h
         IFos43miam5bBVQGh9PZIlXq3Ix5x+Jxh4VrMGZuUm2cYy8G5uYxrr107Hv5X6KNiauq
         7/6PPvKjJTjOkpxyEuEEsw+Qr95Hrn/Oht2hmfXRHZ1Wlz4tZpAxObx1YGAmvqjwrRX+
         jqTA==
X-Gm-Message-State: AOAM5336mKMs9CB/+PILcPewGdovK058+dDTRc9cFnnBKnqIOCf+OB1d
        JUxhhQGdEcQxQ9Bk1D26CJLRsKxAokDc9PO0Z7lomQ==
X-Google-Smtp-Source: ABdhPJx0kXakEaNQSRMoJzIy/ZIMyuAlcLB0onLXYNAWxmCWFDjrhYoWU72Q1LHor8NtbN2OFYTkqKP3ho5/qjWHcrI=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr4967092ljj.3.1591365813798;
 Fri, 05 Jun 2020 07:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200529153814.213125-1-alainm@chromium.org> <20200529153814.213125-2-alainm@chromium.org>
 <CABBYNZKE8B2F6b9oEFWvh+A8FxEBhEGE4QrPc1gS6m_+gFW-aw@mail.gmail.com>
In-Reply-To: <CABBYNZKE8B2F6b9oEFWvh+A8FxEBhEGE4QrPc1gS6m_+gFW-aw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 5 Jun 2020 10:03:21 -0400
Message-ID: <CALWDO_WJuSEibU+Ha2_Bgd6prUyaJXsZHCDo2sxYjr3Nnce7Lw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/4] mgmt:adding load default system
 configuration definitions
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz.


On Thu, Jun 4, 2020 at 6:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Fri, May 29, 2020 at 8:42 AM Alain Michaud <alainm@chromium.org> wrote:
> >
> > This change adds the load default system configuration definitions
> >
> > ---
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >  lib/mgmt.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index b4fc72069..ea89c46b1 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -628,6 +628,24 @@ struct mgmt_rp_set_exp_feature {
> >         uint32_t flags;
> >  } __packed;
> >
> > +#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS 0x004b
> > +
> > +struct mgmt_system_parameter_tlv {
> > +       uint16_t parameter_type;
> > +       uint8_t length;
> > +       uint8_t value[];
> > +} __packed;
> > +
> > +struct mgmt_rp_read_default_system_parameters {
> > +       uint8_t parameters[0]; // mgmt_system_parameter_tlv
> > +} __packed;
> > +
> > +#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS  0x004c
> > +
> > +struct mgmt_cp_set_default_system_parameters {
> > +       uint8_t parameters[0]; // mgmt_system_parameter_tlv
> > +} __packed;
> > +
> >  #define MGMT_EV_CMD_COMPLETE           0x0001
> >  struct mgmt_ev_cmd_complete {
> >         uint16_t opcode;
> > @@ -933,6 +951,8 @@ static const char *mgmt_op[] = {
> >         "Read Security Information",                    /* 0x0048 */
> >         "Read Experimental Features Information",
> >         "Set Experimental Feature",
> > +       "Read Default System Configuration",
> > +       "Set Default System Configuration",
> >  };
> >
> >  static const char *mgmt_ev[] = {
> > --
> > 2.27.0.rc0.183.gde8f92d652-goog
>
> Applied 1-3, thanks. I could not make up my mind regarding 4/4, while
> it seems correct it doesn't seem to be a common practice on C projects
> (e.g: linux, zephyr, etc.), most likely because it would not save much
> in practice since it just making const pointer while the string
> literal is already marked as const.
>
> --
> Luiz Augusto von Dentz
