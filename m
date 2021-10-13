Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0308E61163
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJMVMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhJMVMm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 17:12:42 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F6C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:10:38 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id n201so2464168vkn.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeAlPpcDr5cU6Y1BPC+P8TKGPBKP/R9Xbp6tkKZj390=;
        b=Pjeths7KGdrRx2ZNMeXdHGGXDDfCLjQNyrVkolRxuhuPrEoS6yAxAQZTdkuInx/Kyi
         wvsGu2SaJjcDBJz0QrI40oBdJ/twIFluApcg/68q2QDTCc22BOwzEO9NdIz+NZdFdeb+
         iy/OIEJ6gi51lCiApI+8nzprgVSwWfWHLGG3HqVY/ZDxzlS9asf+R/rhi/3gHudQxjFC
         2Cub0Q1Hwh2UmW3oOKqP8AQg9FYvpHfIZ8rZUgPiUgUYnLId6aeh64cuUNTqTCTQWJB2
         cjv+rzf5f8D4fNHQI3uvrYvYNZecSFSnsAzvsB6cLYsMrxssWd/02nd8pNuww9GGrTpp
         Cmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeAlPpcDr5cU6Y1BPC+P8TKGPBKP/R9Xbp6tkKZj390=;
        b=Xvpf9cl9nPfgT6EzSmCja7MNzUktjyu42FfQ4Qj1yXzSinvU3YogBIfU026ZOw4bpX
         ZNKo+KBeV+OiWwMz68RC43E22b/k+S+kPpzkBtnNeE/DlCApTiRDQq3SlxjwgG9VSUqv
         lasTMBvDYNy2cHV//E9I9Nnezcf/MBjTWmIX3mp9YZxVBKa9ebHqT9LPZoacLtVVRgRB
         +Mq2teot23U3sdCJ2FvHpGoJwamKygCOqTYwZMkf+0rSJtCYJ3Hh1DWYQW0YsEbNtEb1
         bN1Gfyyp46c6HLUOAzf5smMQz2zmJ40kEQLe/CR8tTsvR4pRiwmuJ3ChyPDxZQplC/9I
         oWoQ==
X-Gm-Message-State: AOAM533jOudUnUqYaiiI/6dzpvZOCAJV43Fp6n0NBZtnslS+0TZPd9HN
        LSujQlK1bkL6KDgrjWa2Hsn6Xr4k+fJZ+0gY2ubtweG2
X-Google-Smtp-Source: ABdhPJyJY33s+Qv8EnZV6kMbcWM8cZMwitVHzCI+TnUKunzGUaqMfLxmS26A6W6vRYhKaiQFfK8bnVLpZczE2uv9I2c=
X-Received: by 2002:a1f:2cc2:: with SMTP id s185mr2032440vks.23.1634159437527;
 Wed, 13 Oct 2021 14:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211013003055.2664728-1-luiz.dentz@gmail.com> <3AF15FB4-3BE9-4758-9782-C1935A0F8B3D@holtmann.org>
In-Reply-To: <3AF15FB4-3BE9-4758-9782-C1935A0F8B3D@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Oct 2021 14:10:26 -0700
Message-ID: <CABBYNZL6qAMb94Qs1ekmuhm4_u2YB_CAMeUMfHKpDipPxma1eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Bluetooth: Only allow setting msft_opcode at setup stage
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Oct 12, 2021 at 11:35 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > The msft_opcode shall only be changed while at the setup stage otherwise
> > it can possible cause problems where different opcodes are used while
> > running.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Fix typos: s/extention/extension/g
> >
> > include/net/bluetooth/hci_core.h | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index dd8840e70e25..eb5d4ea88c3a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1272,11 +1272,15 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
> > __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
> > __printf(2, 3) void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
> >
> > -static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
> > +static inline int hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
> > {
> > +     if (!hci_dev_test_flag(hdev, HCI_SETUP))
> > +             return -EPERM;
> > +
> > #if IS_ENABLED(CONFIG_BT_MSFTEXT)
> >       hdev->msft_opcode = opcode;
> > #endif
> > +     return 0;
> > }
>
> this is also not going to work since some driver might set it in their probe() routine before calling hci_register_dev.

Shall we allow that though? Perhaps we should be checking for HCI_RUNNING then?

-- 
Luiz Augusto von Dentz
