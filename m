Return-Path: <SRS0=RGGC=WE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF877C0650F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848F8217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 07:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONE8YxtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfHHHV3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:21:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34823 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHV3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Aug 2019 03:21:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so91187145qto.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2019 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIuRu9x7BA84LVZGVSmmDxEPe3MTxe7R9+5xyMTxusA=;
        b=ONE8YxtFpRzZEu9RvwpcU7Dh1j/4lT1e/vBPVWopR7NvjDMMHQY4T99c8BuAOUlRTc
         HEOPt88aZYXsfS85An9DCNmqnrD1Y5Qu27Bgz/yqo9UHjAM0D9VbbYnCBdr3VudNOUd5
         LAvrgb9fH6pKFzvdSG0LKIWddKNKN+BVM9pmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIuRu9x7BA84LVZGVSmmDxEPe3MTxe7R9+5xyMTxusA=;
        b=MwmPbrlufGBTA+9vgeMkEhRMe22TyV/NHi9coqjfvrPnw2+V0Dx1aEy0r+F7C90nie
         gkAxarLXnMLCB/r9uFkDUNaIQ3yWsV3MBe3Ps9D+u/h7xti8lTwXUis8ocUd/93KA5w6
         /UqH5bxd9r6I9GHHtzq4n9cMkPSgRSZAGqGn6xYbF8ln8FQtsto0Zu14ijVJGflLimgy
         Jdt3M2GDTLPbpDVIj73pgZ89P+VNSgTcg+JfU4lczuDeteRh4sre7KN162frVw4KzbC3
         0ACqdI/jgayKMdrugXzoH/tq0KF6CbAEu7mM2Opoazbnqp0H+sg+lk8JTUVvvZhVENta
         s14Q==
X-Gm-Message-State: APjAAAX0UhJQteu1jkcLsHeDzhG3sp+QVcb/IZ8a/9mkzAGQIi/nyoK5
        dP/KsiGN2BCB52rpdmDOPXwNvCN7fU0=
X-Google-Smtp-Source: APXvYqzsp78e30r0GvP6nRvSZ42DCyQ/6Jzm5whsH8vS3iGGiFQxNsvtbCbCXHFddPJv/kOZhDwnug==
X-Received: by 2002:a0c:e9d2:: with SMTP id q18mr2681823qvo.56.1565248887744;
        Thu, 08 Aug 2019 00:21:27 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id x3sm3333861qkl.71.2019.08.08.00.21.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 00:21:26 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id s145so68013480qke.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2019 00:21:25 -0700 (PDT)
X-Received: by 2002:a37:9904:: with SMTP id b4mr11502899qke.159.1565248885032;
 Thu, 08 Aug 2019 00:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190808060737.3506-1-bgodavar@codeaurora.org> <56fe734d517399c6509f6e9c45f9b096@codeaurora.org>
In-Reply-To: <56fe734d517399c6509f6e9c45f9b096@codeaurora.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 8 Aug 2019 15:21:13 +0800
X-Gmail-Original-Message-ID: <CALiNf29bmSbjT4pmzGGG_WzmC6gaZS+vBeRQUiQuT85bm-iMsg@mail.gmail.com>
Message-ID: <CALiNf29bmSbjT4pmzGGG_WzmC6gaZS+vBeRQUiQuT85bm-iMsg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btqca: Reset download type to default
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, c_hbandi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>

Hi,

Please add the Fixes: tag and I will add my Reviewed-by: tag.

Thanks,
Claire

On Thu, Aug 8, 2019 at 2:21 PM Rocky Liao <rjliao@codeaurora.org> wrote:
>
> +Claire
>
> On 2019-08-08 14:07, Balakrishna Godavarthi wrote:
> > This patch will reset the download flag to default value
> > before retrieving the download mode type.
> >
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> >  drivers/bluetooth/btqca.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > index 2221935fac7e..9fb247c10855 100644
> > --- a/drivers/bluetooth/btqca.c
> > +++ b/drivers/bluetooth/btqca.c
> > @@ -140,6 +140,7 @@ static void qca_tlv_check_data(struct rome_config
> > *config,
> >       BT_DBG("Length\t\t : %d bytes", length);
> >
> >       config->dnld_mode = ROME_SKIP_EVT_NONE;
> > +     config->dnld_type = ROME_SKIP_EVT_NONE;
> >
> >       switch (config->type) {
> >       case TLV_TYPE_PATCH:
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> a Linux Foundation Collaborative Project
