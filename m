Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2916CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhLVUMQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhLVUMP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:12:15 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24190C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:12:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e136so9977324ybc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZi+NoCdSdjviEIJP93cRVKpcJFyI4n0uTcTLXZbFWc=;
        b=Z/xHmg4oLH4CL2BH6Eqm6mr3nwFbOQGQ4Bj70LnC/Zhw6DzGVZsbKZPPNAXWu7Gqtz
         VNhes2qEhtaCiBKbmLmBdoWa/hftPshgzwr57/xTlT4sF1pXrxyYHGFFPRPrIYCcRHeu
         GtdgD0+HyRGEEsnH7MbPFo0AUyWagdEiQ5EOmX/TojdRDSK84dsNRN5pxRp5YoxisTac
         elMPxywEopQ03k1nTT6eVSe3WhAcoYWVeuN7jK7oJQDZ1sBZJx/sI4StBRPUbTi8F/Jz
         h6zwmJpUmwqlzDqko9T6fykl1l3ohZc1spu5JVDzNpk2XetnlK9kB9Oe+51bvpt1wMAr
         JcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZi+NoCdSdjviEIJP93cRVKpcJFyI4n0uTcTLXZbFWc=;
        b=J44me41iJu7BMOLWoNkV20d0cJpmLUrD6jSQQCvrPEvJjoyICmoLm24sDJCEAvj5HD
         EsAjdb75RlYyAAB74Bm1vCj0jZUMvP1RdIOJ4Gw3xBlIG3edk6O11NPlQEii88p3jsyA
         fXyRACHQGRUaXAUT7tp4NarFGYa+2WU0nwZgfvAc0rEy1X0BTTmldx5wA53ODBjvcYVW
         hzcEWo0xdKWlS7D5gs+ww9LdyeYiC5w6GQX4FB9iIJqD8rC/pLbz2gXgMp6geK80AiFA
         MHPFjHDuTFX2trqu5K2DVOeMb6pLKw6pYdzi2sXt4xD+4TsSNTaj5SEwAxh16VF8d2PX
         Elbg==
X-Gm-Message-State: AOAM5317d9Afag2n9W9Uzlgny+j6EVGP1o8PZUO5iZoNogWBGNPXGXmm
        PC0xt37ZtwiFPjyrQQlG/0uN7Xd3tmCcMj86mb4KTL9MmBc=
X-Google-Smtp-Source: ABdhPJyilZ4G/1DnIrMDDpSGeYfebXh7GP5MnzepzCBvRJAlb0PaYl5ofVb0CSTF4mJ7MQOW64IDq0BPBQ9n9mtkZO8=
X-Received: by 2002:a25:3dc2:: with SMTP id k185mr6457544yba.733.1640203934045;
 Wed, 22 Dec 2021 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <61c10192.1c69fb81.96a67.06a8@mx.google.com> <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
 <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com>
 <CABBYNZK+32F-AxVsFYXKXWfzbFRDoR9PXJNL6UOvKv8+H+DoUw@mail.gmail.com> <CACGnfjTJm4GP9kTbUgAnxO=+RrLWEq+=EfMLh5=DAQmJBuBnQg@mail.gmail.com>
In-Reply-To: <CACGnfjTJm4GP9kTbUgAnxO=+RrLWEq+=EfMLh5=DAQmJBuBnQg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Dec 2021 12:12:03 -0800
Message-ID: <CABBYNZJcMheKKrxJr2p7XAYVZ+v9n11mLRYGbyTo3ucP3MxioQ@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment
 value for central-peripheral support.
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Jesse,

On Tue, Dec 21, 2021 at 2:28 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> Hi Luiz,
>
> That looks good to me. I will verify and send a patch. Thanks!
>
> On Tue, Dec 21, 2021 at 3:35 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Jesse,
> >
> > On Tue, Dec 21, 2021 at 1:20 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thanks for looking at this. I did see the main.conf file, and the
> > > documentation is fairly clear, but I think there is still a bug here.
> > > Mainly: if one enables the experiment via main.conf, but the driver
> > > for the kernel has not set the relevant quirk indicating that the
> > > device supports the functionality, we are still seeing
> > > "central-peripheral" listed as supported. Ultimately this leads to
> > > test failures for us as, believing that the functionality is
> > > supported, we execute tests that then fail (this is reproducible if
> > > you modify a test device's driver to not support this feature (for
> > > btusb I removed BTUSB_VALID_LE_STATES as an attribute) and enable the
> > > feature via main.conf). In code, I think the culprit is seen in this
> > > function in that the value of "action" is set exclusively by the
> > > main.conf file, and is then passed into "feat->func" which adds it to
> > > "adapter->exps" (at least for this feature). Given what you've said
> > > here, I believe the right solution would be to require that both the
> > > feature be supported (as derived from the driver) and enabled (as
> > > derived from main.conf) in order to consider the feature enabled (as
> > > reported to peers/via query).
> >
> > This might be a kernel bug then, the UUID shall be omitted if not
> > supported, if it is being returned by MGMT_OP_READ_EXP_FEATURES_INFO
> > then bluetoothd will consider it supported thus causing the problem
> > you are describing:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3919
> >
> > It looks like only it is indeed a problem for
> > simult_central_periph_uuid, so we shall probably change it to:

I end up sending a patch myself:

https://patchwork.kernel.org/project/bluetooth/patch/20211221223357.742863-4-luiz.dentz@gmail.com/

> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index c8baf6141026..28b873df9084 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3921,7 +3921,7 @@ static int read_exp_features_info(struct sock
> > *sk, struct hci_dev *hdev,
> >         }
> >  #endif
> >
> > -       if (hdev) {
> > +       if (hdev & test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks)) {
> >                 if (hci_dev_le_state_simultaneous(hdev))
> >                         flags = BIT(0);
> >                 else
> >
> > > On Tue, Dec 21, 2021 at 2:57 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Jesse,
> > > >
> > > > On Mon, Dec 20, 2021 at 5:59 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> > > > >
> > > > > ---
> > > > > The observed behavior without any change is that support for the
> > > > > central-peripheral role can be enabled through an experiment flag in
> > > > > BlueZ regardless of whether the controller can actually support it.
> > > > > Additionally, if the controller has enabled this feature but the
> > > > > experiment flag has not been set the central-peripheral role is not
> > > > > listed as supported. I'm not certain what the expected behavior should
> > > > > be, but enabling if either source says to enable (this patch) or only
> > > > > when both enable the feature both seem like reasonable options to start
> > > > > with.
> > > > >
> > > > >  src/adapter.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index 9fc6853c9..60325015b 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
> > > > >                         }
> > > > >
> > > > >                         if (feat->func)
> > > > > -                               feat->func(adapter, action);
> > > > > +                               feat->func(adapter, action ||
> > > > > +                                       (rp->features[i].flags & BIT(0)));
> > > >
> > > > Feature being supported doesn't mean the system wants it to be enabled
> > > > since this is experimental after all there could be side effects, the
> > > > proper way to enable it is via main.conf:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n115
> > > >
> > > > >                 }
> > > > >         }
> > > > >  }
> > > > > --
> > > > > 2.31.0
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
