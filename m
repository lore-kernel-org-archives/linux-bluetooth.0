Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 00:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF9E20801
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 00:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt/5Yy3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLAyG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLAyF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 20:54:05 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0CC03E96F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 17:54:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c194so7227967oig.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqfSx7EVMtNUL/Q+w2Qfr81m3ysy8aPwb/p9odijGm8=;
        b=Vt/5Yy3v/ldTMT4OUHBOKm2QeIwqri6VDktsPtSQpTHLHDiSYAQDzz00HmnSCB4Yv5
         aobOxpNwHPLzeBcY3ibTZCIwYje7brT6/SYtLXM+2IGkfTV9gC3RCyhXOh6ofsb5G0gt
         1rSHSkCFpW65GApqxwUXeTOsWnEEBPnSQUbKChq42G3aGCorYweLmfBU/xl7MOpFFODs
         jxdaDVAleoyQqv4HiODiieCtjYiI3BycxtAMI0ky4JG99LQksTZFdjRQGmotHwa3KxO3
         IgpMT/XXNjbso2LSoh08DbpwqckWtZw/hLFpdSYS7T7QjJn6pL0pMnIlyoPMVpPqpAtl
         ZR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqfSx7EVMtNUL/Q+w2Qfr81m3ysy8aPwb/p9odijGm8=;
        b=DvhyEEW8aZGuiO6SMmzQXpS8FCEKc5ZO6L2ZD7LsmyFS/0QaSjuma03bFg2GGRQ3dt
         K5bqhaaOu31lh26fwvJraFDHceBHxJxbFmD/uw5uLk0uKnNXf9+9ZIgUPeUQU4OKtyhq
         gkwvrQf/8noaXeIhpPDbaWK1ASgtNFWeACDcySXBU/1ErkMkEWu1GXXamN3SFoxzZPAY
         McO7+qLCi0iep8QE6MAA+GA0GgnTNYiS1IeQ3htSp3wN5HKNNOaGntD7GtoxyYxy8zrq
         1lTs4G5yPLYO3el0W5PnW6+V2eiyUk7KEA3yXRBM6x2ZrZgBrZ9nz+AoL4GRld1lCZfm
         zl9A==
X-Gm-Message-State: AOAM532bPi23t9TbtWDlQFdCGaMioNBfiwjAxYl1uw9OgVyb/6gBgR03
        jsCgGYvFn4/MT6scBsI0Ve1ZAo1kQ8kt9N8cwrk=
X-Google-Smtp-Source: ABdhPJxRMSaVCRN6lWQ4jJ7h3cayIiAgJYxtAYkhfPX/mD0IUCJUctFN0qzjnLWHFoV+5XGw/BpcMFKXa2prA7oOH6o=
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr499332oii.82.1591923245097;
 Thu, 11 Jun 2020 17:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200518200949.BlueZ.v2.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
 <CABBYNZL0_kkoUzuAysoq=VvH-pw2Lz=7-UPCW1rRu4eSqwKzGw@mail.gmail.com> <CABmPvSHpUvJ3Csh86njuWiUfmOkks7ztsk8pa7xzS18Rn8Z_XQ@mail.gmail.com>
In-Reply-To: <CABmPvSHpUvJ3Csh86njuWiUfmOkks7ztsk8pa7xzS18Rn8Z_XQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Jun 2020 17:53:53 -0700
Message-ID: <CABBYNZ+E1s9f21-vSnyOrg72ME6Uz_P9T5+vGDU6YFbLu34btQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] lib: Add definitions for advertisement monitor features
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Jun 11, 2020 at 4:27 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for checking it in.
> I just update v3 to address the opcode right after this... Please ignore v3.
> Also I think there is a need of keeping pattern term to imply the
> relationship among all patterns within a monitor given the fact that
> we may need to add other monitor type that the logical relation among
> conditions can be customized.

Is that supposed to be a difference command? Monitor Added don't seem
to care what type it is adding, afaik all you can do is add new
pattern types, or we do intend to have different classes of monitors?

> Regards,
> Miao
>
> On Thu, Jun 11, 2020 at 3:38 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Mon, May 18, 2020 at 8:14 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > This adds the following command opcodes, event codes and the corresponding
> > > structures.
> > > - MGMT_OP_READ_ADV_MONITOR_FEATURES
> > > - MGMT_OP_ADD_ADV_PATTERNS_MONITOR
> > > - MGMT_OP_REMOVE_ADV_MONITOR
> > > - MGMT_EV_ADV_MONITOR_ADDED
> > > - MGMT_EV_ADV_MONITOR_REMOVED
> > > ---
> > >
> > > Changes in v2:
> > > - Fix build failures.
> > >
> > >  lib/mgmt.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >
> > > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > > index b4fc72069..6d7441ccc 100644
> > > --- a/lib/mgmt.h
> > > +++ b/lib/mgmt.h
> > > @@ -628,6 +628,42 @@ struct mgmt_rp_set_exp_feature {
> > >         uint32_t flags;
> > >  } __packed;
> > >
> > > +#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS      (1 << 0)
> > > +
> > > +#define MGMT_OP_READ_ADV_MONITOR_FEATURES      0x004B
> > > +struct mgmt_rp_read_adv_monitor_features {
> > > +       uint32_t supported_features;
> > > +       uint32_t enabled_features;
> > > +       uint16_t max_num_handles;
> > > +       uint8_t max_num_patterns;
> > > +       uint16_t num_handles;
> > > +       uint16_t handles[0];
> > > +}  __packed;
> > > +
> > > +struct mgmt_adv_pattern {
> > > +       uint8_t ad_type;
> > > +       uint8_t offset;
> > > +       uint8_t length;
> > > +       uint8_t value[31];
> > > +} __packed;
> > > +
> > > +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x004C
> > > +struct mgmt_cp_add_adv_patterns_monitor {
> > > +       uint8_t pattern_count;
> > > +       struct mgmt_adv_pattern patterns[0];
> > > +} __packed;
> > > +struct mgmt_rp_add_adv_patterns_monitor {
> > > +       uint16_t monitor_handle;
> > > +} __packed;
> > > +
> > > +#define MGMT_OP_REMOVE_ADV_MONITOR             0x004D
> > > +struct mgmt_cp_remove_adv_monitor {
> > > +       uint16_t monitor_handle;
> > > +} __packed;
> > > +struct mgmt_rp_remove_adv_monitor {
> > > +       uint16_t monitor_handle;
> > > +} __packed;
> > > +
> > >  #define MGMT_EV_CMD_COMPLETE           0x0001
> > >  struct mgmt_ev_cmd_complete {
> > >         uint16_t opcode;
> > > @@ -857,6 +893,16 @@ struct mgmt_ev_exp_feature_changed {
> > >         uint32_t flags;
> > >  } __packed;
> > >
> > > +#define MGMT_EV_ADV_MONITOR_ADDED      0x0028
> > > +struct mgmt_ev_adv_monitor_added {
> > > +       uint16_t monitor_handle;
> > > +}  __packed;
> > > +
> > > +#define MGMT_EV_ADV_MONITOR_REMOVED    0x0029
> > > +struct mgmt_ev_adv_monitor_removed {
> > > +       uint16_t monitor_handle;
> > > +}  __packed;
> > > +
> > >  static const char *mgmt_op[] = {
> > >         "<0x0000>",
> > >         "Read Version",
> > > @@ -933,6 +979,9 @@ static const char *mgmt_op[] = {
> > >         "Read Security Information",                    /* 0x0048 */
> > >         "Read Experimental Features Information",
> > >         "Set Experimental Feature",
> > > +       "Read Advertisement Monitor Features",
> > > +       "Add Advertisement Patterns Monitor",
> > > +       "Remove Advertisement Monitor",
> > >  };
> > >
> > >  static const char *mgmt_ev[] = {
> > > @@ -976,6 +1025,8 @@ static const char *mgmt_ev[] = {
> > >         "Extended Controller Information Changed",
> > >         "PHY Configuration Changed",
> > >         "Experimental Feature Changed",
> > > +       "Advertisement Monitor Added",                  /* 0x0028 */
> > > +       "Advertisement Monitor Removed",
> > >  };
> > >
> > >  static const char *mgmt_status[] = {
> > > --
> > > 2.26.2
> > >
> >
> > Applied, thanks. Note I did adjust the opcodes so it matches the ones
> > used in the documentation, I've also dropped the pattern term from the
> > add command since we can assume a monitor will always be filtering
> > based on patterns and it is not used for the event.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
