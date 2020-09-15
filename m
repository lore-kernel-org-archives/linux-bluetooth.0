Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CFC43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC4921974
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 18:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="En+9bYzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIOSQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgIOSO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 14:14:27 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8976C061797
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 11:14:11 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v5so1341889uau.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dYOdscKsLLbuPXyrWmnbIC4+odjPdewltY6CArt7Y0=;
        b=En+9bYzKmMSm1MCAH971ZxSd8zQOumDWZsYHYHKPFKZrOie95wQOzOtkKNFSFGCu2b
         /BYIA5KB1Iwbwv1uNEkc8RTe1V1tQB/Vyarazg02/DVdDKXImqgRG+dFbKzHNL9E+yoJ
         d8N6MwKIeOl13LvUnauhrWCf5SUUkA0G8QAxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dYOdscKsLLbuPXyrWmnbIC4+odjPdewltY6CArt7Y0=;
        b=ldaNFSUJmEJ/UoQ3KoVNuVfBq+QW+bfbRrVLR1fmgQYUPAjO0268E9CEejx9ZsSNW7
         BPnL4WPg7MlPPfpjNUgW6jdfwf6HQLxISU96ZG7+RJAnztUnufgfmsQMQjJJ5ycWy+7p
         lm4iCEg14ULSSQjYiYSSGWZzQJrJgLIVZLTL/yaVzwQn/VLoSUxbQ1bEESRzXozl/M65
         MsDDPiZeyeeYBdjH/au0UUJKsX5j7iNQ86IOpP2w2wnLfu/edyPgMAAtSUi5XzAWsp5j
         6HcfnJOq5OYpwzfs9OX32BOWKSnsqRBqP5a0aAOcqgRRPn0co0/jipMM7D/XOCk2JqdV
         Vgrg==
X-Gm-Message-State: AOAM530ov5wNJKibJQ2Xd1zUHzS55o98S7gwLnCVAXpUNLKpF4lTdJSe
        uiMAsnI+nLuz91NvqANCj5a0coaRNZJV1Wqijg+tNA==
X-Google-Smtp-Source: ABdhPJxVgliY4UpLgJqE5mvRPmBH1jvEe9zl/fVRHlWynZA/7aPhC83faqv66D6Mr9/j7veRPo9NBaBSRo+uncOxzBA=
X-Received: by 2002:ab0:136f:: with SMTP id h44mr10190880uae.60.1600193650552;
 Tue, 15 Sep 2020 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200915174146.1693687-1-abhishekpandit@chromium.org> <CABBYNZLmyr5a_WoMwkmBsr2Y8LvnY1xiH724Y2BDOAe5zHFJjw@mail.gmail.com>
In-Reply-To: <CABBYNZLmyr5a_WoMwkmBsr2Y8LvnY1xiH724Y2BDOAe5zHFJjw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 15 Sep 2020 11:13:59 -0700
Message-ID: <CANFp7mWYbfZz7vnCTvisox=QpAyyYa72p9uwcqO13w0xgrXdNA@mail.gmail.com>
Subject: Re: [Bluez PATCH v5 0/4] adapter: Reconnect audio when resuming from suspend
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Awesome, thanks!

On Tue, Sep 15, 2020 at 11:05 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Tue, Sep 15, 2020 at 10:41 AM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> >
> > Hi Luiz and Marcel,
> >
> > This is a quality of life improvement for the behavior of audio devices
> > during system suspend. This depends on a kernel change that emits
> > suspend/resume events:
> >
> > https://patchwork.kernel.org/project/bluetooth/list/?series=325771
> >
> > Right now, audio devices will be disconnected as part of suspend but
> > won't be reconnected when the system resumes without user interaction.
> > This is annoying to some users as it causes an interruption to their
> > normal work flow.
> >
> > This change reconnects audio devices that were disconnected for suspend
> > using the following logic:
> >
> >  * In the device disconnect callback, mark any devices with the A2DP
> >    service uuid for reconnect. The reconnect will not be queued until
> >    resume.
> >  * In the controller resume callback, queue any policy items that are
> >    marked to reconnect on resume for connection with the ResumeDelay
> >    value (default = 2s).
> >
> > A reconnect is queued after the controller resumes and the delay
> > between resume and reconnect is configurable via the ResumeDelay key in
> > the Policy settings. The 2s delay was chosen arbitrarily and I think
> > anywhere up to 10s is probably ok. A longer delay is better to account
> > for spurious wakeups and Wi-Fi reconnection time (avoiding any co-ex
> > issues) at the downside of reconnection speed.
> >
> > Here are the tests I have done with this:
> > - Single suspend and verified the headphones reconnect
> > - Suspend stress test for 25 iterations and verify both Wi-Fi and
> >   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
> >   10s)
> > - Suspend test with wake time = 1s to verify that BT reconnect isn't
> >   attempted. Ran 5 iterations with low wake time and then let it stay
> >   awake to confirm reconnect finally completed on last resume.
> > - Suspend test with wake time between 1s - 4s. Ran with 5 iterations and
> >   verified it connected several times in the middle and finally at the
> >   end.
> >
> > I've tested this on a Pixelbook Go (AC-9260 controller) and HP
> > Chromebook 14a (RTL8822CE controller) with GID6B headset.
> >
> > I've also tested this with the Pixel Buds 2. These earbuds actually
> > reconnect automatically to the Chromebook (even without this policy
> > change) and I verified that the new changes don't break the reconnection
> > mechanism.
> >
> > Thanks
> > Abhishek
> >
> >
> > Changes in v5:
> > - Remove use of !! in has_kernel_features
>
> It seems I end up merging the old version by mistake, but I fixed this
> one change myself and added btd_ prefix to it since that is required
> to be exported for plugins that are not built-in.
>
> > Changes in v4:
> > - Set reconnect timer in disconnect if resume events aren't supported
> > - Only set reconnect timer if adapter matches current notification
> > - Refactor changes in src/adapter to its own commit
> > - Refactor enabling A2DP_SINK_UUID into its own commit
> >
> > Changes in v3:
> > - Refactored resume notification to use btd_adapter_driver
> > - Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
> > - Added A2DP_SINK_UUID to default reconnect list
> >
> > Changes in v2:
> > - Refactored to use policy instead of connecting directly in adapter
> >
> > Abhishek Pandit-Subedi (4):
> >   adapter: Refactor kernel feature globals
> >   adapter: Handle controller resume and notify drivers
> >   policy: Enable reconnect for a2dp-sink in defaults
> >   policy: Reconnect audio on controller resume
> >
> >  plugins/policy.c |  87 +++++++++++++++++++++++++++++++++-------
> >  src/adapter.c    | 102 +++++++++++++++++++++++++++++++++--------------
> >  src/adapter.h    |  11 +++++
> >  src/main.c       |   1 +
> >  src/main.conf    |  11 ++++-
> >  5 files changed, 168 insertions(+), 44 deletions(-)
> >
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
>
> --
> Luiz Augusto von Dentz
