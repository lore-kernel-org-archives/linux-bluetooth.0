Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFFC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B8C206E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 20:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M1R6AqMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgHaU43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgHaU41 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E24C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 13:56:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j185so1425619vsc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jf+by2cMfVGYoXiaZmCY+bTjqc266EFHVYXp0RH8ESc=;
        b=M1R6AqMdsetkO+AX4MhlxLKGGKiS5BUUn3OPkOAr3SakpmTnh/jk0srXqbl8RZyZ+x
         lECNuMmsXgPwNbbudAi8k5HFqT4XjcGMwUvhtc2hXk4cZw8MdCppQQLLxvmnwmCqajPP
         mWV5uo2OeyVfwHgR8QJtJgbXb3r3u9mz79wBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jf+by2cMfVGYoXiaZmCY+bTjqc266EFHVYXp0RH8ESc=;
        b=ETx/Mn4CNqlLSrpjaG8i6NZsKgZ8gDMWTFxWycTqY/+QfU1IC3NqqSYTZXs/PQPr54
         wI7cVqnGV3cyMLzMBo+O8Wbg5ABRhDkQ3MMTNP+gU7H4OXmMCezarWvjCOBRYDs2LG/v
         QuqZsoB3T7BV9qSkT6CnVvoy2HnDA5CrjrUSYGq2q/02xh59ZzGCmJbXAn2jmWiqX/Yz
         jvFrAnS5gwgNUBB+qGKx5Y2zHPBNCO/F+3ONMjzbYe/k/AQYLbMEvpR27htDRqWDJjFF
         nh6EGgngpCqqfyX/Hm3Psa6rEAcksazQWnfsr5J9lYQKVZQX4fEM8EVqzl6H6ojtBGNw
         eIHQ==
X-Gm-Message-State: AOAM53066aSvskkv2jv/9fgCVe19PWDjLOd9i5woj9mERDGOze9Nr2OO
        wTNdOtQ3p42ZLFQN6AI1KLzJVLvSEy7CvwwIWjmmtw==
X-Google-Smtp-Source: ABdhPJyU14oXwVBhctneBOUwM29iuxJsij2t0ITXHo0JJcvyYxRW6OVl+b2FyPviOv3ZZjTd1k/fj+YWHlm01XS+VEU=
X-Received: by 2002:a05:6102:5e:: with SMTP id k30mr3185433vsp.170.1598907386496;
 Mon, 31 Aug 2020 13:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
 <20200828180157.Bluez.v3.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
 <CABBYNZJTr13-XK9KuXOD+UzB6_oSwefvpJ9ptPRf0dygdAhKHw@mail.gmail.com>
 <CANFp7mVq_7no-KJ0SFZ1Yqz0ZZbabgUUChXv+PsyJ00rGicDSQ@mail.gmail.com> <CABBYNZLorj6c3KJtAO+fvwQzS=wsh21D+Xov=duyY3JixbuvOA@mail.gmail.com>
In-Reply-To: <CABBYNZLorj6c3KJtAO+fvwQzS=wsh21D+Xov=duyY3JixbuvOA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 31 Aug 2020 13:56:14 -0700
Message-ID: <CANFp7mVPnfCDLrexawK8dx7comz=_f7LKjrQn-j75i=t_RkzOw@mail.gmail.com>
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

They have not. The changes are still pending review at
https://patchwork.kernel.org/project/bluetooth/list/?series=325771.

If you'd like to wait for Marcel, let's revert these two patches and
land the whole series as one.

Thanks
Abhishek

On Mon, Aug 31, 2020 at 1:34 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Aug 31, 2020 at 11:28 AM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > Could you also merge https://patchwork.kernel.org/patch/11663455/ that
> > adds this to docs/mgmt-api.txt?
>
> Looks like Marcel had reviewed but decided to hold on until the kernel
> parts are applied, have that been resolved?
>
> > Thanks
> > Abhishek
> >
> > On Mon, Aug 31, 2020 at 10:36 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Abhishek,
> > >
> > > On Fri, Aug 28, 2020 at 6:02 PM Abhishek Pandit-Subedi
> > > <abhishekpandit@chromium.org> wrote:
> > > >
> > > > Add the controller suspend and resume events.
> > > >
> > > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3: None
> > > > Changes in v2: None
> > > >
> > > >  lib/mgmt.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > > > index a800bcab4..46d894ae9 100644
> > > > --- a/lib/mgmt.h
> > > > +++ b/lib/mgmt.h
> > > > @@ -772,6 +772,7 @@ struct mgmt_ev_device_connected {
> > > >  #define MGMT_DEV_DISCONN_TIMEOUT       0x01
> > > >  #define MGMT_DEV_DISCONN_LOCAL_HOST    0x02
> > > >  #define MGMT_DEV_DISCONN_REMOTE                0x03
> > > > +#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND    0x05
> > > >
> > > >  #define MGMT_EV_DEVICE_DISCONNECTED    0x000C
> > > >  struct mgmt_ev_device_disconnected {
> > > > @@ -959,6 +960,17 @@ struct mgmt_ev_adv_monitor_removed {
> > > >         uint16_t monitor_handle;
> > > >  }  __packed;
> > > >
> > > > +#define MGMT_EV_CONTROLLER_SUSPEND             0x002d
> > > > +struct mgmt_ev_controller_suspend {
> > > > +       uint8_t suspend_state;
> > > > +} __packed;
> > > > +
> > > > +#define MGMT_EV_CONTROLLER_RESUME              0x002e
> > > > +struct mgmt_ev_controller_resume {
> > > > +       struct mgmt_addr_info addr;
> > > > +       uint8_t wake_reason;
> > > > +} __packed;
> > > > +
> > > >  static const char *mgmt_op[] = {
> > > >         "<0x0000>",
> > > >         "Read Version",
> > > > @@ -1088,6 +1100,8 @@ static const char *mgmt_ev[] = {
> > > >         "Device Flags Changed",
> > > >         "Advertisement Monitor Added",                  /* 0x002b */
> > > >         "Advertisement Monitor Removed",
> > > > +       "Controller Suspend",
> > > > +       "Controller Resume",
> > > >  };
> > > >
> > > >  static const char *mgmt_status[] = {
> > > > --
> > > > 2.28.0.402.g5ffc5be6b7-goog
> > >
> > > Patches 1 and 2 of this series were applied, thanks.
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
