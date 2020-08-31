Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0AC208A9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWGrL2Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHaUeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgHaUeW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 16:34:22 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD3C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 13:34:22 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id y30so1791582ooj.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afPtGRN+FnzfS3mVOZ0v/4LJTXGWDmVqMyAKYPVaFzk=;
        b=AWGrL2Rtst2W8ovrexQABrUbFf46ka14qb0a6uVZnrWx7FfjyGoPjYu4u/JTi3g42N
         zjiHYRd8lhN5hcrAku/DyvK35lM2+YBvDyRpl9fsjOx4knpA8Gqq3v/uH/UoVTqAj8XN
         7IuYkeJKub2yPXDk0eLqv6lRs+iiRq8ZEi8JCoJEZa1o0mnHoov0gMbnhXWUW1yG9B/U
         kzaFXzOyxYitq5LMz0H65JUbOh/W8+LQN/HmDztHZpLZKKU2WuRBeVseEiLCHulLVraY
         r+gYLhRHQPcuOp1AR14yy3sVazt6e5pAmhhqgeQ7e93xZHLm/qhfAgxfbXLEGYtr3LCl
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afPtGRN+FnzfS3mVOZ0v/4LJTXGWDmVqMyAKYPVaFzk=;
        b=CxWBdczcCPgC6QoJIdZUVe1oI2q5Az54gen/pOYdKckj6XjeXVOt9u8PvNfZYrhoD8
         FZusuB569dr3lfyLxgV+9p9OK4F1RaaAMo+MHvbAQeJDLXW1XzMcttm7NVM4AuRWKgqP
         ZyV3wdQyFCOQcRD1Vg7/vuriWeKyZCIWbj/McARJ1+HG4VGtgySGMK6JKkGAk8Zivlrj
         vcRIjvWZykIw1EbEHic4QWU6XE2EBpf8LJBRQc8fQxj7U8gfBo3Pwgkaa4dwU5IPAluO
         ZfB4mNKSqm3n/D6rSaDAqsbkjRQSZG7XZFVrq5vj5szoGYg3qDssR/00OFBeX9MZq6bn
         XAQQ==
X-Gm-Message-State: AOAM531lof/Aal2g92O97wR7ZloutsAkuR2ob/J1XqSLv+5i8AIJ5JXp
        0JkVtXkv2slEY/BBvKc1X7z4hqx2bsTQW7Qbrh1qMKka
X-Google-Smtp-Source: ABdhPJwWrZqw52gSNjWIhpt3vTPk6VFhOsvAwZBaskUdyElVBI2X4MxhuZWEaaZ0fraUB5O64icp0C435tz+y5ar1/k=
X-Received: by 2002:a4a:924b:: with SMTP id g11mr1976063ooh.9.1598906061330;
 Mon, 31 Aug 2020 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
 <20200828180157.Bluez.v3.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
 <CABBYNZJTr13-XK9KuXOD+UzB6_oSwefvpJ9ptPRf0dygdAhKHw@mail.gmail.com> <CANFp7mVq_7no-KJ0SFZ1Yqz0ZZbabgUUChXv+PsyJ00rGicDSQ@mail.gmail.com>
In-Reply-To: <CANFp7mVq_7no-KJ0SFZ1Yqz0ZZbabgUUChXv+PsyJ00rGicDSQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 13:34:11 -0700
Message-ID: <CABBYNZLorj6c3KJtAO+fvwQzS=wsh21D+Xov=duyY3JixbuvOA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/3] mgmt: Add controller suspend and resume events
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
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

Hi Abhishek,

On Mon, Aug 31, 2020 at 11:28 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> Could you also merge https://patchwork.kernel.org/patch/11663455/ that
> adds this to docs/mgmt-api.txt?

Looks like Marcel had reviewed but decided to hold on until the kernel
parts are applied, have that been resolved?

> Thanks
> Abhishek
>
> On Mon, Aug 31, 2020 at 10:36 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Fri, Aug 28, 2020 at 6:02 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Add the controller suspend and resume events.
> > >
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > ---
> > >
> > > Changes in v3: None
> > > Changes in v2: None
> > >
> > >  lib/mgmt.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > > index a800bcab4..46d894ae9 100644
> > > --- a/lib/mgmt.h
> > > +++ b/lib/mgmt.h
> > > @@ -772,6 +772,7 @@ struct mgmt_ev_device_connected {
> > >  #define MGMT_DEV_DISCONN_TIMEOUT       0x01
> > >  #define MGMT_DEV_DISCONN_LOCAL_HOST    0x02
> > >  #define MGMT_DEV_DISCONN_REMOTE                0x03
> > > +#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND    0x05
> > >
> > >  #define MGMT_EV_DEVICE_DISCONNECTED    0x000C
> > >  struct mgmt_ev_device_disconnected {
> > > @@ -959,6 +960,17 @@ struct mgmt_ev_adv_monitor_removed {
> > >         uint16_t monitor_handle;
> > >  }  __packed;
> > >
> > > +#define MGMT_EV_CONTROLLER_SUSPEND             0x002d
> > > +struct mgmt_ev_controller_suspend {
> > > +       uint8_t suspend_state;
> > > +} __packed;
> > > +
> > > +#define MGMT_EV_CONTROLLER_RESUME              0x002e
> > > +struct mgmt_ev_controller_resume {
> > > +       struct mgmt_addr_info addr;
> > > +       uint8_t wake_reason;
> > > +} __packed;
> > > +
> > >  static const char *mgmt_op[] = {
> > >         "<0x0000>",
> > >         "Read Version",
> > > @@ -1088,6 +1100,8 @@ static const char *mgmt_ev[] = {
> > >         "Device Flags Changed",
> > >         "Advertisement Monitor Added",                  /* 0x002b */
> > >         "Advertisement Monitor Removed",
> > > +       "Controller Suspend",
> > > +       "Controller Resume",
> > >  };
> > >
> > >  static const char *mgmt_status[] = {
> > > --
> > > 2.28.0.402.g5ffc5be6b7-goog
> >
> > Patches 1 and 2 of this series were applied, thanks.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
