Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A36C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 21:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhLUVfP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhLUVfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 16:35:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3553C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:35:14 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f186so373077ybg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpMEBf9QSe4tLaY7SvHwBNyNSoUpRAxdACu/EsdxAFQ=;
        b=kui0WZwrIrt5ZtF9LPoq1JNUS4f9bvwTZTzfO0SRQQQAeOFRn47umH6Ul/4jQ6hVRP
         YkzZbjWnwO2QGbgVsZjOqYV47SrYes9VgO5bjKcjRz3pO+UbNzmu2KZuNrFz6zZKLXtD
         0pvEv1ARkuTrDRcS3oey/S7de5G7M1oK9ANImtsHMxXp7EQ2OHCERmdBwZpJ9hu7Dzgz
         h2AmOJilP8APW7cdxA3oO98yqjk6VF90Arnj8Uaaz1dy4oBF+T/Z5f5JXOAVOddDac2b
         Fl9hlMJPV5wUGS7KCiLS6WqCv5GiQ6XozV8ITeb1R3paR8j1oJIh9MS+1e5XhJCLdXge
         aYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpMEBf9QSe4tLaY7SvHwBNyNSoUpRAxdACu/EsdxAFQ=;
        b=Lh6ofoZtRG/qwV93oYHXi1tyD321dCGxqSy57Hanz+xMpmbzYyvWAYn9m9I5Blryik
         NIcvHXVyhFmc5SfDUnr4L9u+bEtWJBX06UvTXSiNlMTzLlsI3WqbDhsf0Q7hqS7x5M9g
         0KbobAWXH3IrI+AjStKVj720EgBG0Z6eWaXyQzgXLkfel2oy1ODIqaV6TA5ICqyty0pI
         ozFsCcqko4VEeWCJnLpQB3MF/vcgzW4c0/niTZl46CGCLXXpNqmPPguTF/8ynIQ6+NT/
         Bcybq6JhyUKYH2nzmbNo9gZXsawItMJektU+GNrFZ+4EB0ENf8WtXG+03vlKJVrT7e5u
         ZZqA==
X-Gm-Message-State: AOAM532geRQJVy/6OzxAtdeWFh5FlCLWKYjFYa5/vDVFasa/R4cgQtZH
        bUR8wP4gF0mTK8Ci1xboRdCDPUU3PWLQkrj08W0=
X-Google-Smtp-Source: ABdhPJyuvLgNLx05cFIApLYYUDUXqa2xVU5hVHho8Njp20mO5FQ50v/wiaw/yZuukCz/Fwni65C/H/017VTZ510Gr/I=
X-Received: by 2002:a25:7287:: with SMTP id n129mr276686ybc.351.1640122513948;
 Tue, 21 Dec 2021 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <61c10192.1c69fb81.96a67.06a8@mx.google.com> <CABBYNZLQ_b8Aw21QnUzmuEedny4wh4LSu6DLQvw1pynFGvHMTA@mail.gmail.com>
 <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com>
In-Reply-To: <CACGnfjRA2Co6OpTJfosbx0GdLJwk3dVHQ8edWPqkKSo_q4JyPQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Dec 2021 13:35:03 -0800
Message-ID: <CABBYNZK+32F-AxVsFYXKXWfzbFRDoR9PXJNL6UOvKv8+H+DoUw@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH] Bluetooth: Use driver status and experiment
 value for central-peripheral support.
To:     Jesse Melhuish <melhuishj@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jesse,

On Tue, Dec 21, 2021 at 1:20 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for looking at this. I did see the main.conf file, and the
> documentation is fairly clear, but I think there is still a bug here.
> Mainly: if one enables the experiment via main.conf, but the driver
> for the kernel has not set the relevant quirk indicating that the
> device supports the functionality, we are still seeing
> "central-peripheral" listed as supported. Ultimately this leads to
> test failures for us as, believing that the functionality is
> supported, we execute tests that then fail (this is reproducible if
> you modify a test device's driver to not support this feature (for
> btusb I removed BTUSB_VALID_LE_STATES as an attribute) and enable the
> feature via main.conf). In code, I think the culprit is seen in this
> function in that the value of "action" is set exclusively by the
> main.conf file, and is then passed into "feat->func" which adds it to
> "adapter->exps" (at least for this feature). Given what you've said
> here, I believe the right solution would be to require that both the
> feature be supported (as derived from the driver) and enabled (as
> derived from main.conf) in order to consider the feature enabled (as
> reported to peers/via query).

This might be a kernel bug then, the UUID shall be omitted if not
supported, if it is being returned by MGMT_OP_READ_EXP_FEATURES_INFO
then bluetoothd will consider it supported thus causing the problem
you are describing:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3919

It looks like only it is indeed a problem for
simult_central_periph_uuid, so we shall probably change it to:

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c8baf6141026..28b873df9084 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3921,7 +3921,7 @@ static int read_exp_features_info(struct sock
*sk, struct hci_dev *hdev,
        }
 #endif

-       if (hdev) {
+       if (hdev & test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks)) {
                if (hci_dev_le_state_simultaneous(hdev))
                        flags = BIT(0);
                else

> On Tue, Dec 21, 2021 at 2:57 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Jesse,
> >
> > On Mon, Dec 20, 2021 at 5:59 PM Jesse Melhuish <melhuishj@chromium.org> wrote:
> > >
> > > ---
> > > The observed behavior without any change is that support for the
> > > central-peripheral role can be enabled through an experiment flag in
> > > BlueZ regardless of whether the controller can actually support it.
> > > Additionally, if the controller has enabled this feature but the
> > > experiment flag has not been set the central-peripheral role is not
> > > listed as supported. I'm not certain what the expected behavior should
> > > be, but enabling if either source says to enable (this patch) or only
> > > when both enable the feature both seem like reasonable options to start
> > > with.
> > >
> > >  src/adapter.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index 9fc6853c9..60325015b 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -10434,7 +10434,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
> > >                         }
> > >
> > >                         if (feat->func)
> > > -                               feat->func(adapter, action);
> > > +                               feat->func(adapter, action ||
> > > +                                       (rp->features[i].flags & BIT(0)));
> >
> > Feature being supported doesn't mean the system wants it to be enabled
> > since this is experimental after all there could be side effects, the
> > proper way to enable it is via main.conf:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n115
> >
> > >                 }
> > >         }
> > >  }
> > > --
> > > 2.31.0
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
