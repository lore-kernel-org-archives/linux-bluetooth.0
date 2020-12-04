Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE57C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC83229C5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 16:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLDQfx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLDQfx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Dec 2020 11:35:53 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6950C061A51
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Dec 2020 08:35:12 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so8457177lfm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Dec 2020 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CAsRWS1aUlzLi/q9+iMyq1zlfiHEboJsJ2mUECDL5Cs=;
        b=CBnRu/J0dCse2eVtVl2oV9dudg8v4BMaFCSxOlbnJlAM8+tVhew1X9HLQJyw4QW+iw
         ZbXetXic8Qyw5D7ZRGBCAzBnq8uczLv5PdlUhDhzGpK0V49a0yRqTgtaIbjv8DXJE8dN
         ZSqddmmVveNjt6OS+f44uFTVa4XcsmsQ9ZBV0mXGlJ6jpo8C1bHDcOJ6f+CyTyL7FhdL
         OFNxXtMaHlkRpqUcc+nRBuwMx2J83wzoZ4JigbXmqrq1OZXCZrsz3T9LFO065hXJay+3
         1+ml8N8NEpVvnBGmZ7ugwlLDJ2d7luPE57y+k4fzcicw18CV4bJTU86B9oAlRF/xCQsY
         YdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CAsRWS1aUlzLi/q9+iMyq1zlfiHEboJsJ2mUECDL5Cs=;
        b=eObRQmNM5A/UrZoBnXTwBM+1jy+5ATwrMznDYFLvdePdXd3ASICuTiGrQbZnAXaWv3
         meffEF5WGLQEQIcqcYawx0VEn9bQJYm3b4ELsUvALB+ou4DHTX1O9pKfuiLWKRMNB5XI
         qihuKB7QXri+MjGqc2g9OnI2bdl2mJ0dCP5dhLIw1NSYjZuyfwwp7H9poEIKAWgF9i+G
         G1d1fvHbP41RPmKpFrpeiY4GAS3Pu6nULwXvkcgQuwPv4mFYxdblr3VUHB2cLmqZMqQ8
         /q1UsVLB6DWblraoc994RHV9DjZ2QXI//GkXusoTgzT6y8Kws2c0tmV/ihBsVJaKBRag
         ddSQ==
X-Gm-Message-State: AOAM532/+hTE6dwdeaCvoNup7amA5MWPSldWzJG1fVSfJYq3rU+rLeEd
        lGGdVHgoB1CDfxshEI4gDXXEGFcrc677/CvqinhomA==
X-Google-Smtp-Source: ABdhPJyRqostEN0F9Hqj98zRy8MICqwZh8zh84PLy0Vb+MPHtTCOypeYCneckx16Blb/LuHm/j9/rfZH4omFnl4adek=
X-Received: by 2002:a05:6512:5d6:: with SMTP id o22mr3915606lfo.574.1607099711115;
 Fri, 04 Dec 2020 08:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20201203102936.4049556-1-apusaka@google.com> <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
 <20B6F2AD-1A60-4E3C-84C2-E3CB7294FABC@holtmann.org> <CAJQfnxHDThaJ58iFSpyq4bLopeuATvd+4fOR2AAgbNaabNSMuQ@mail.gmail.com>
 <25116F72-CE7C-46B6-A83A-5D33E9142BF9@holtmann.org>
In-Reply-To: <25116F72-CE7C-46B6-A83A-5D33E9142BF9@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Sat, 5 Dec 2020 00:34:59 +0800
Message-ID: <CAJQfnxG_GDsTTJ1v=Ug0MqEGmTSdeYcOhEf3rQ1hDTmvJS0JrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] Bluetooth: advmon offload MSFT add rssi support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, 4 Dec 2020 at 17:51, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>> MSFT needs rssi parameter for monitoring advertisement packet,
> >>> therefore we should supply them from mgmt.
> >>>
> >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >>> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >>
> >> I don=E2=80=99t need any Reviewed-by if they are not catching an obvio=
us user API breakage.
> >>
> >>> ---
> >>>
> >>> include/net/bluetooth/hci_core.h | 9 +++++++++
> >>> include/net/bluetooth/mgmt.h     | 9 +++++++++
> >>> net/bluetooth/mgmt.c             | 8 ++++++++
> >>> 3 files changed, 26 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> >>> index 9873e1c8cd16..42d446417817 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -246,8 +246,17 @@ struct adv_pattern {
> >>>      __u8 value[HCI_MAX_AD_LENGTH];
> >>> };
> >>>
> >>> +struct adv_rssi_thresholds {
> >>> +     __s8 low_threshold;
> >>> +     __s8 high_threshold;
> >>> +     __u16 low_threshold_timeout;
> >>> +     __u16 high_threshold_timeout;
> >>> +     __u8 sampling_period;
> >>> +};
> >>> +
> >>> struct adv_monitor {
> >>>      struct list_head patterns;
> >>> +     struct adv_rssi_thresholds rssi;
> >>>      bool            active;
> >>>      __u16           handle;
> >>> };
> >>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgm=
t.h
> >>> index d8367850e8cd..dc534837be0e 100644
> >>> --- a/include/net/bluetooth/mgmt.h
> >>> +++ b/include/net/bluetooth/mgmt.h
> >>> @@ -763,9 +763,18 @@ struct mgmt_adv_pattern {
> >>>      __u8 value[31];
> >>> } __packed;
> >>>
> >>> +struct mgmt_adv_rssi_thresholds {
> >>> +     __s8 high_threshold;
> >>> +     __le16 high_threshold_timeout;
> >>> +     __s8 low_threshold;
> >>> +     __le16 low_threshold_timeout;
> >>> +     __u8 sampling_period;
> >>> +} __packed;
> >>> +
> >>> #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR      0x0052
> >>> struct mgmt_cp_add_adv_patterns_monitor {
> >>>      __u8 pattern_count;
> >>> +     struct mgmt_adv_rssi_thresholds rssi;
> >>>      struct mgmt_adv_pattern patterns[];
> >>> } __packed;
> >>
> >> This is something we can not do. It breaks an userspace facing API. Is=
 the mgmt opcode 0x0052 in an already released kernel?
> >
> > Yes, the opcode does exist in an already released kernel.
> >
> > The DBus method which accesses this API is put behind the experimental
> > flag, therefore we expect they are flexible enough to support changes.
> > Previously, we already had a discussion in an email thread with the
> > title "Offload RSSI tracking to controller", and the outcome supports
> > this change.
> >
> > Here is an excerpt of the discussion.
>
> it doesn=E2=80=99t matter. This is fixed API now and so we can not just c=
hange it. The argument above is void. What matters if it is in already rele=
ased kernel.

If that is the case, do you have a suggestion to allow RSSI to be
considered when monitoring advertisement? Would a new MGMT opcode with
these parameters suffice?
#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI 0x005?
struct mgmt_cp_add_adv_patterns_monitor {
    __u8 pattern_count;
    struct mgmt_adv_rssi_thresholds rssi;
    struct mgmt_adv_pattern patterns[];
} __packed;

Thanks,
Archie
