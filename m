Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4BC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D20420872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSieb9Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgH1RWS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgH1RWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 13:22:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF1C061264
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:22:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n23so1506312otq.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMY0HHfl5UqqUfSqFkN1PL8lgIeYCFEm7vbvGLLk/2c=;
        b=RSieb9YfQ4z9cNMlhtdQ9EVfSAyNHMi69xIqebohJDDcgzChkuUTR5w+8pwvCYt825
         Nsky0rbn2rLrFioo8jfKTZSA/gxA/MAaQcCkR3tiKIeIqE1ua4D/td6dfN1EPi5m0pTG
         xiSuS7mhrMUKn6DYk+FzDB88+hoFaUVCeiVfJbMx11UoCzYXA8s3bts27WSVLP+4Y2OK
         KrI5qU/pHaTWKBENunnpQHt7WmjssJ2yzPXCz1raqsPPosZvj7pchPAEk1Z0D7MDogXq
         vE99qacVjH7LSiX23U6Mz9KHySdfggH0xPNYPlzYUvs9VfvevFnacdSq8jM6JgiC6Pya
         KVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMY0HHfl5UqqUfSqFkN1PL8lgIeYCFEm7vbvGLLk/2c=;
        b=PaKV3t5rn+jIyjYIWmqoqpQ/NzAXHidtGfwxJKT3GxTKLbJiqnFkH6t9KN0RBsPbQ4
         PQusywP7ALYqfMqabYbTN/WL2ieI/CuGNCAFqtW/Ez8MvIAnm0taTOc3Om3DT2nzbq1x
         63MeqeiSp19xmJr4CFJQR2oqXJCShffSoHYV3sIbO2rsHd2yfdNwB8f4htgi+BejWPjq
         Xx0K+d9pBTnZl0+BgSYYWrY7XvO+zhiyVA2aCcNX//e35gg7449ASEe87HyO70sX0E/4
         jYh8jXdl3L34h3vH1/CBDQG2nnugD2b3PL7BwpXs7obNFTXvPF68c6MpSCXB6Vz2zMZA
         uQ7Q==
X-Gm-Message-State: AOAM533PgfBZhxy/IsGjx33OWU/n8NqLd8ah5/BTc/QmJcNRraMsZR/b
        jOs9UxEA+dev+w2vXnVpD0gtn9aW6tP135spats=
X-Google-Smtp-Source: ABdhPJySAaRekgOVCDa0z5tOKBl5h0apKOQbkQ6oZF5XIwzLGkQkb4qJ1/KegcsIIgPj02ftKTOG//ehLx8I0N62eCY=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr1898413otj.362.1598635330926;
 Fri, 28 Aug 2020 10:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
 <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
 <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com> <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com>
In-Reply-To: <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Aug 2020 10:22:01 -0700
Message-ID: <CABBYNZ+YMfvcVnB7afXyFa_bz2oNaivgsmyhS=yOGrKuh4JG9A@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 0/3] adapter: Reconnect audio when resuming from suspend
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Thu, Aug 27, 2020 at 2:13 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> On Wed, Aug 26, 2020 at 11:21 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Wed, Aug 26, 2020 at 10:41 AM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Could you PTAL at this v2 patch series. I refactored the audio
> > > reconnect to use the policy plugin instead of doing the reconnect as
> > > part of the adapter logic, as requested.
> > >
> > > Thanks
> > > Abhishek
> > >
> > > On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
> > > <abhishekpandit@chromium.org> wrote:
> > > >
> > > >
> > > > Hi Luiz and Marcel,
> > > >
> > > > This is a quality of life improvement for the behavior of audio devices
> > > > during system suspend. This depends on a kernel change that emits
> > > > suspend/resume events:
> > > >
> > > > https://patchwork.kernel.org/project/bluetooth/list/?series=325771
> >
> > So we could not just use the disconnect reason like I suggested?
>
> I am using the disconnect reason to mark the device for reconnection
> and only queueing it for reconnect on resume. As mentioned in the
> patch, this is to account for resumes that are not user driven and
> will suspend almost immediately again (i.e. periodic wake up to check
> battery level and see if we need to shut down).
>
> >
> > > > Right now, audio devices will be disconnected as part of suspend but
> > > > won't be reconnected when the system resumes without user interaction.
> > > > This is annoying to some users as it causes an interruption to their
> > > > normal work flow.
> > > >
> > > > This change reconnects audio devices that were disconnected for suspend
> > > > using the following logic:
> > > >
> > > >  * Register a callback for controller resume in the policy plugin.
> > > >  * In the device disconnect callback, mark any devices with the A2DP
> > > >    service uuid for reconnect on resume after a delay.
> > > >  * In the controller resume callback, queue any policy items that are
> > > >    marked to reconnect on resume for connection with the
> > > >    ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).
> >
> > Something like ResumeDelay would probably be better.
>
> Sure, I will rename this.
>
> >
> > > > A reconnect is only attempted once after the controller resumes and the
> > > > delay between resume and reconnect is configurable via the
> > > > ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
> > > > arbitrarily and I think anywhere up to 10s is probably ok. A longer
> > > > delay is better to account for spurious wakeups and Wi-Fi reconnection
> > > > time (avoiding any co-ex issues) at the downside of reconnection speed.
> >
> > I would keep the same logic as out of range so the platforms can
> > customize the number of attempts.
>
> So the first reconnect attempt after resume should be separately
> configurable (i.e. 5s) but subsequent reconnect attempts would use the
> reconnect-intervals values? That sounds good to me.

Right, though 5 seconds seems awfully long compared to the normal
first attempt, so perhaps we could default it to just 1-2 seconds.

> >
> > > > Here are the tests I have done with this:
> > > > - Single suspend and verified the headphones reconnect
> > > > - Suspend stress test for 25 iterations and verify both Wi-Fi and
> > > >   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
> > > >   10s)
> > > > - Suspend test with wake time < 5s to verify that BT reconnect isn't
> > > >   attempted. Ran 5 iterations with low wake time and then let it stay
> > > >   awake to confirm reconnect finally completed after 5s+ wake time.
> > > > - Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
> > > >   verified it wasn't connected at the end. A connection attempt was
> > > >   made but not completed due to suspend. A reconnect attempt was not
> > > >   made afterwards, which is by design.
> > > >
> > > >   Luiz@ Marcel@: Does this sound ok (give up after an attempt)?
> > > >
> > > > I've tested this on a Pixelbook Go (AC-9260 controller) and HP
> > > > Chromebook 14a (RTL8822CE controller) with GID6B headset.
> > > >
> > > > I've also tested this with the Pixel Buds 2. These earbuds actually
> > > > reconnect automatically to the Chromebook (even without this policy
> > > > change) and I verified that the new changes don't break the reconnection
> > > > mechanism.
> > > >
> > > > Thanks
> > > > Abhishek
> > > >
> > > >
> > > > Changes in v2:
> > > > - Refactored to use policy instead of connecting directly in adapter
> > > >
> > > > Abhishek Pandit-Subedi (3):
> > > >   mgmt: Add controller suspend and resume events
> > > >   monitor: Add btmon support for Suspend and Resume events
> > > >   policy: Reconnect audio on controller resume
> > > >
> > > >  lib/mgmt.h       | 14 +++++++++++
> > > >  monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
> > > >  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> > > >  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
> > > >  src/adapter.h    |  6 +++++
> > > >  src/main.c       |  1 +
> > > >  src/main.conf    |  9 +++++++
> > > >  7 files changed, 190 insertions(+), 4 deletions(-)
> > > >
> > > > --
> > > > 2.28.0.297.g1956fa8f8d-goog
> > > >
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
