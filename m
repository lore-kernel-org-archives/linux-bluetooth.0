Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAA8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhLUW2Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhLUW2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:28:16 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2672C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:28:15 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso312207ots.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/jD1R8ooE+g/wsy904oM8VEhejh9ghsy5ZVHMnyuQE=;
        b=b2ip01hNv0lAOHyiqlrKOIu/ma9DLKJLxnHeg2UtjfvL047yilPm6WbhssxMw27xOz
         onfXR0pyMQYWxK8bTGiQduFYYR/EO9iNc5JLaL5GQ5HYcsOLzZ7EVabBa5H7MvnHzKsc
         GnqUSPr+gAA7ptZF+FaqJq4L3aaREAq+wvDfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/jD1R8ooE+g/wsy904oM8VEhejh9ghsy5ZVHMnyuQE=;
        b=dDqpduIErB7TBMTNsj0IuFwA2Xb7D6+5wnzE/NcvgPIP72FF0Eh3d/+0bl22Y2pTDS
         l8djir/IUu78/2YRv+viSp+Tpbf6OaQTlmkM0SHrENYfPh3JdgtX6f+FUSgOcoS4SO59
         ZcBJZW/nCKDKlfELWodX1oF9aMZEqXnRQ6JThShLsRMbH7Z3AwpbiMj1iyJl53N1l1Na
         cXSlNYF8dMelKQg2b1tKsw22de6q35Gcn5a20mdrearq8cR0lK+Epotbm44+WVQz2PBB
         RT5/+cxsRyYHlXG9MCylSFCbraSI2bTMEeJwrNqun144GHUW8KJJ+pcJjYyo16XcbIVC
         QXsw==
X-Gm-Message-State: AOAM530lUz98WqYpBUvI1cV4VJD8erY6/3EquJz9CrvrwU1xCLEzYMz9
        MZ0kSSJXzbg66FhCncxr+BwvOrKtU7+fiw==
X-Google-Smtp-Source: ABdhPJzt8Z7AidJHehftT1PmHzXXkjVLYS7KQbHu4kfoiVCBD5nlnHvfOxAPSeh2YPJCdGN41EZWYg==
X-Received: by 2002:a9d:c69:: with SMTP id 96mr56265otr.191.1640125694773;
        Tue, 21 Dec 2021 14:28:14 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id y22sm4928ots.40.2021.12.21.14.28.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 14:28:14 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id s73so968430oie.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:28:13 -0800 (PST)
X-Received: by 2002:a54:4190:: with SMTP id 16mr363095oiy.139.1640125693098;
 Tue, 21 Dec 2021 14:28:13 -0800 (PST)
MIME-Version: 1.0
References: <61c10192.1c69fb81.96a67.06a8@mx.google.com> <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
 <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com> <CABBYNZK+32F-AxVsFYXKXWfzbFRDoR9PXJNL6UOvKv8+H+DoUw@mail.gmail.com>
In-Reply-To: <CABBYNZK+32F-AxVsFYXKXWfzbFRDoR9PXJNL6UOvKv8+H+DoUw@mail.gmail.com>
From:   Jesse Melhuish <melhuishj@chromium.org>
Date:   Tue, 21 Dec 2021 16:27:59 -0600
X-Gmail-Original-Message-ID: <CACGnfjTJm4GP9kTbUgAnxO=+RrLWEq+=EfMLh5=DAQmJBuBnQg@mail.gmail.com>
Message-ID: <CACGnfjTJm4GP9kTbUgAnxO=+RrLWEq+=EfMLh5=DAQmJBuBnQg@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment
 value for central-peripheral support.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Jesse Melhuish <melhuishj@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

That looks good to me. I will verify and send a patch. Thanks!

On Tue, Dec 21, 2021 at 3:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jesse,
>
> On Tue, Dec 21, 2021 at 1:20 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > Thanks for looking at this. I did see the main.conf file, and the
> > documentation is fairly clear, but I think there is still a bug here.
> > Mainly: if one enables the experiment via main.conf, but the driver
> > for the kernel has not set the relevant quirk indicating that the
> > device supports the functionality, we are still seeing
> > "central-peripheral" listed as supported. Ultimately this leads to
> > test failures for us as, believing that the functionality is
> > supported, we execute tests that then fail (this is reproducible if
> > you modify a test device's driver to not support this feature (for
> > btusb I removed BTUSB_VALID_LE_STATES as an attribute) and enable the
> > feature via main.conf). In code, I think the culprit is seen in this
> > function in that the value of "action" is set exclusively by the
> > main.conf file, and is then passed into "feat->func" which adds it to
> > "adapter->exps" (at least for this feature). Given what you've said
> > here, I believe the right solution would be to require that both the
> > feature be supported (as derived from the driver) and enabled (as
> > derived from main.conf) in order to consider the feature enabled (as
> > reported to peers/via query).
>
> This might be a kernel bug then, the UUID shall be omitted if not
> supported, if it is being returned by MGMT_OP_READ_EXP_FEATURES_INFO
> then bluetoothd will consider it supported thus causing the problem
> you are describing:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3919
>
> It looks like only it is indeed a problem for
> simult_central_periph_uuid, so we shall probably change it to:
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c8baf6141026..28b873df9084 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3921,7 +3921,7 @@ static int read_exp_features_info(struct sock
> *sk, struct hci_dev *hdev,
>         }
>  #endif
>
> -       if (hdev) {
> +       if (hdev & test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks)) {
>                 if (hci_dev_le_state_simultaneous(hdev))
>                         flags = BIT(0);
>                 else
>
> > On Tue, Dec 21, 2021 at 2:57 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Jesse,
> > >
> > > On Mon, Dec 20, 2021 at 5:59 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> > > >
> > > > ---
> > > > The observed behavior without any change is that support for the
> > > > central-peripheral role can be enabled through an experiment flag in
> > > > BlueZ regardless of whether the controller can actually support it.
> > > > Additionally, if the controller has enabled this feature but the
> > > > experiment flag has not been set the central-peripheral role is not
> > > > listed as supported. I'm not certain what the expected behavior should
> > > > be, but enabling if either source says to enable (this patch) or only
> > > > when both enable the feature both seem like reasonable options to start
> > > > with.
> > > >
> > > >  src/adapter.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > index 9fc6853c9..60325015b 100644
> > > > --- a/src/adapter.c
> > > > +++ b/src/adapter.c
> > > > @@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
> > > >                         }
> > > >
> > > >                         if (feat->func)
> > > > -                               feat->func(adapter, action);
> > > > +                               feat->func(adapter, action ||
> > > > +                                       (rp->features[i].flags & BIT(0)));
> > >
> > > Feature being supported doesn't mean the system wants it to be enabled
> > > since this is experimental after all there could be side effects, the
> > > proper way to enable it is via main.conf:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n115
> > >
> > > >                 }
> > > >         }
> > > >  }
> > > > --
> > > > 2.31.0
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
