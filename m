Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DAAC4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A403823339
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLGKtQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 05:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLGKtQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 05:49:16 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90CC0613D2
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 02:48:35 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y19so5256628lfa.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hHdC4ujfq/sltdEUUsvjJDbRnESRD9gRv1wBr/8BciA=;
        b=Ae9ZfB8al/FPgLf4JFsxc7tvg1V9qxcJ4n+0hJhJLhan+RU/NZHHZ7RmFV7feXj98U
         zoC7EivklqYsT5m2Am2djyaTw2zBwww1qKex5P0pGsNVtp+/HjSenSObGg2pnjt+VHM5
         +NS2ZL6Egssl40XpcvcZ51nv7jrM8ITFEztypRhSA5O5S/MnI0Ryb+q5U/rvjdPsoQK+
         FFiOeIocO+5h82lr6sLGUMWPffA7OCWR6vtDp9OoN7XC3hzawYA+yFh/1NH/MVxKro4S
         VDENbA0HwfiD+uN1tQOkoSprGiYFJgy7nhbi/ixcJxDgO0vjAioGKifrwyWC4d4xxmRS
         RmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hHdC4ujfq/sltdEUUsvjJDbRnESRD9gRv1wBr/8BciA=;
        b=TLH+9O3kWlm5YOCDcjFTMjhvAtyY0Z3SoHZEcPx0O2zYEEns7B0ASTbWRi0LgydVhH
         gjkLGxlWswSx2o83TaOZbst1jorKGCxDwJWUaiRIMcBMAeMDjf0p6Uk8pOndTfLam9X+
         QQIlvtLLAl5+AMon0LdrPCanDcB0TXy0pA5nRICCfVDKNfjumCO1RE+yhwNIjkbQf6U0
         e/L/4k0QXkyk96/WIrIWvfGNi5zLJshlxcxq8LYCnAHJyfgOM4+txizDIUDN2lrTCv+n
         5cH/2NZk28NB/hbcd0705FswSo2t95OPy4eumyxsXCmD+6Q5oi/qP2ARRGcTD0+iv/wL
         69Cw==
X-Gm-Message-State: AOAM532PEAKvpyFDzqao3pUM7gLGJxFH/CgfPnWsKSz3+nLVshNeZ04c
        GkcMwnqigRKQAGoBmEGcCd8tvEth7wgqelNMI+1zjA==
X-Google-Smtp-Source: ABdhPJx9Yi4fPTOzVqekOVpmfn4yuJQ/ANOi6GRZwBZNXobm0cq1w55+gcDyVGdCkUP5tx2zlrSetJUN0QVXCM80sJw=
X-Received: by 2002:ac2:5311:: with SMTP id c17mr8180683lfh.22.1607338113921;
 Mon, 07 Dec 2020 02:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20201203102936.4049556-1-apusaka@google.com> <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
 <20B6F2AD-1A60-4E3C-84C2-E3CB7294FABC@holtmann.org> <CAJQfnxHDThaJ58iFSpyq4bLopeuATvd+4fOR2AAgbNaabNSMuQ@mail.gmail.com>
 <25116F72-CE7C-46B6-A83A-5D33E9142BF9@holtmann.org> <CAJQfnxG_GDsTTJ1v=Ug0MqEGmTSdeYcOhEf3rQ1hDTmvJS0JrQ@mail.gmail.com>
 <14E449EF-6E91-43BF-9477-61B29B20783A@holtmann.org>
In-Reply-To: <14E449EF-6E91-43BF-9477-61B29B20783A@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 7 Dec 2020 18:48:22 +0800
Message-ID: <CAJQfnxGOg_b+DkqVuUh0jqQL4VmY0ijB4kEmfGg92K3D_KbNZQ@mail.gmail.com>
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

On Mon, 7 Dec 2020 at 17:57, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>>>> MSFT needs rssi parameter for monitoring advertisement packet,
> >>>>> therefore we should supply them from mgmt.
> >>>>>
> >>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>>>> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >>>>> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >>>>
> >>>> I don=E2=80=99t need any Reviewed-by if they are not catching an obv=
ious user API breakage.
> >>>>
> >>>>> ---
> >>>>>
> >>>>> include/net/bluetooth/hci_core.h | 9 +++++++++
> >>>>> include/net/bluetooth/mgmt.h     | 9 +++++++++
> >>>>> net/bluetooth/mgmt.c             | 8 ++++++++
> >>>>> 3 files changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoo=
th/hci_core.h
> >>>>> index 9873e1c8cd16..42d446417817 100644
> >>>>> --- a/include/net/bluetooth/hci_core.h
> >>>>> +++ b/include/net/bluetooth/hci_core.h
> >>>>> @@ -246,8 +246,17 @@ struct adv_pattern {
> >>>>>     __u8 value[HCI_MAX_AD_LENGTH];
> >>>>> };
> >>>>>
> >>>>> +struct adv_rssi_thresholds {
> >>>>> +     __s8 low_threshold;
> >>>>> +     __s8 high_threshold;
> >>>>> +     __u16 low_threshold_timeout;
> >>>>> +     __u16 high_threshold_timeout;
> >>>>> +     __u8 sampling_period;
> >>>>> +};
> >>>>> +
> >>>>> struct adv_monitor {
> >>>>>     struct list_head patterns;
> >>>>> +     struct adv_rssi_thresholds rssi;
> >>>>>     bool            active;
> >>>>>     __u16           handle;
> >>>>> };
> >>>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/m=
gmt.h
> >>>>> index d8367850e8cd..dc534837be0e 100644
> >>>>> --- a/include/net/bluetooth/mgmt.h
> >>>>> +++ b/include/net/bluetooth/mgmt.h
> >>>>> @@ -763,9 +763,18 @@ struct mgmt_adv_pattern {
> >>>>>     __u8 value[31];
> >>>>> } __packed;
> >>>>>
> >>>>> +struct mgmt_adv_rssi_thresholds {
> >>>>> +     __s8 high_threshold;
> >>>>> +     __le16 high_threshold_timeout;
> >>>>> +     __s8 low_threshold;
> >>>>> +     __le16 low_threshold_timeout;
> >>>>> +     __u8 sampling_period;
> >>>>> +} __packed;
> >>>>> +
> >>>>> #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR      0x0052
> >>>>> struct mgmt_cp_add_adv_patterns_monitor {
> >>>>>     __u8 pattern_count;
> >>>>> +     struct mgmt_adv_rssi_thresholds rssi;
> >>>>>     struct mgmt_adv_pattern patterns[];
> >>>>> } __packed;
> >>>>
> >>>> This is something we can not do. It breaks an userspace facing API. =
Is the mgmt opcode 0x0052 in an already released kernel?
> >>>
> >>> Yes, the opcode does exist in an already released kernel.
> >>>
> >>> The DBus method which accesses this API is put behind the experimenta=
l
> >>> flag, therefore we expect they are flexible enough to support changes=
.
> >>> Previously, we already had a discussion in an email thread with the
> >>> title "Offload RSSI tracking to controller", and the outcome supports
> >>> this change.
> >>>
> >>> Here is an excerpt of the discussion.
> >>
> >> it doesn=E2=80=99t matter. This is fixed API now and so we can not jus=
t change it. The argument above is void. What matters if it is in already r=
eleased kernel.
> >
> > If that is the case, do you have a suggestion to allow RSSI to be
> > considered when monitoring advertisement? Would a new MGMT opcode with
> > these parameters suffice?
>
> its the only way.

I will make the necessary changes. Thanks for the confirmation.

Regards,
Archie

>
> Regards
>
> Marcel
>
