Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C4FC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D17206E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyTl/NwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHaS2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHaS2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 14:28:16 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F588C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 11:28:16 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id e5so407213vkm.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h63Rj0Px9YhpYpjPVZddoHDJIC9AXL8x7ZQiNvu7YH4=;
        b=SyTl/NwAvI6Z6KVO9hDikmuv6SASItxkTxMNDTqAvF6VBnY5jPJ7rvJ3Mx9AaFDQKj
         UeBTwv1rI8/u4EKJVwI+UrBUKSXaGclHnuyf0hWiZQjYUnjJJiVfm4SxHYiPEHHS6Qpf
         ma5FSM5rtT0JqGw8j7E8WyYjtkkmjwm3KjUAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h63Rj0Px9YhpYpjPVZddoHDJIC9AXL8x7ZQiNvu7YH4=;
        b=W/UUfowP8bViEud16iNYrs+9iL28JKURBmBPKUHUkk8sr6TUcFlYDW9fgdPkwpcFZn
         Zlh99rALZEf5qZlqfbLkE26tms/dzPB4BzRbLeNtYW9qVVmHbyG94YGPXGeTTms67jRu
         0nJygxOmE+4vXZpxsivyEplExW7qDfYZV3RTZRT+yzYjvZpjY4NKqPC/kQoYWeLFf6Rc
         DCj8563x/isclSB/kZd7Z+BVPGgUVUcFSAtMEmgslXdYj38CKVY2dVBCaqCLYCExP69K
         cJgZ2tYWT9CcKSNtrP/ZaKBcnQXkL/iXSGa4K1WC0edjXqMUmPipqv71G6j63ZkczS/Y
         DDdA==
X-Gm-Message-State: AOAM531L2ZGhbLgv1k5Tl33mf28FuVAM2eiL3Ep+0AeTDwZp9WAQp50D
        EuIxUJ5aJYqjVKUxi2ILxaNa+5xzQ+CRtdKzwu4lpg==
X-Google-Smtp-Source: ABdhPJyfjthdMqZttVFDFbLfsFXicNSK2NGTUsEOZqxm6gO0DhK1vqFTB0FebvMj9pF1nA9N7tx+bw53xFrQeCtRF3Q=
X-Received: by 2002:ac5:c925:: with SMTP id u5mr2185373vkl.68.1598898495413;
 Mon, 31 Aug 2020 11:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
 <20200828180157.Bluez.v3.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
 <CABBYNZJTr13-XK9KuXOD+UzB6_oSwefvpJ9ptPRf0dygdAhKHw@mail.gmail.com>
In-Reply-To: <CABBYNZJTr13-XK9KuXOD+UzB6_oSwefvpJ9ptPRf0dygdAhKHw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 31 Aug 2020 11:28:05 -0700
Message-ID: <CANFp7mVq_7no-KJ0SFZ1Yqz0ZZbabgUUChXv+PsyJ00rGicDSQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/3] mgmt: Add controller suspend and resume events
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Could you also merge https://patchwork.kernel.org/patch/11663455/ that
adds this to docs/mgmt-api.txt?

Thanks
Abhishek

On Mon, Aug 31, 2020 at 10:36 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Fri, Aug 28, 2020 at 6:02 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Add the controller suspend and resume events.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >  lib/mgmt.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index a800bcab4..46d894ae9 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -772,6 +772,7 @@ struct mgmt_ev_device_connected {
> >  #define MGMT_DEV_DISCONN_TIMEOUT       0x01
> >  #define MGMT_DEV_DISCONN_LOCAL_HOST    0x02
> >  #define MGMT_DEV_DISCONN_REMOTE                0x03
> > +#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND    0x05
> >
> >  #define MGMT_EV_DEVICE_DISCONNECTED    0x000C
> >  struct mgmt_ev_device_disconnected {
> > @@ -959,6 +960,17 @@ struct mgmt_ev_adv_monitor_removed {
> >         uint16_t monitor_handle;
> >  }  __packed;
> >
> > +#define MGMT_EV_CONTROLLER_SUSPEND             0x002d
> > +struct mgmt_ev_controller_suspend {
> > +       uint8_t suspend_state;
> > +} __packed;
> > +
> > +#define MGMT_EV_CONTROLLER_RESUME              0x002e
> > +struct mgmt_ev_controller_resume {
> > +       struct mgmt_addr_info addr;
> > +       uint8_t wake_reason;
> > +} __packed;
> > +
> >  static const char *mgmt_op[] = {
> >         "<0x0000>",
> >         "Read Version",
> > @@ -1088,6 +1100,8 @@ static const char *mgmt_ev[] = {
> >         "Device Flags Changed",
> >         "Advertisement Monitor Added",                  /* 0x002b */
> >         "Advertisement Monitor Removed",
> > +       "Controller Suspend",
> > +       "Controller Resume",
> >  };
> >
> >  static const char *mgmt_status[] = {
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
>
> Patches 1 and 2 of this series were applied, thanks.
>
> --
> Luiz Augusto von Dentz
