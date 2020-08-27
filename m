Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC652080C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6TOPJy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgH0VN3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgH0VN3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 17:13:29 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E944C061264
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 14:13:28 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id x142so1590921vke.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJMIcRuoc4PEJP8Cu7uCzH3gpj+jS0eHFU0v1DVRwQU=;
        b=D6TOPJy/EOu2QFp/Hm7uIT3bhvHnCvdwriKZVdbKlFWF/xPYy1guHq5+S5Jig+T+gl
         VIuveAL9m4LJHHnAcSd1zTzOWJIuleY+LGKEE3LM7JmqkrHTrvkpQQ0XdApE7NeBgnOF
         +eyBMtxcOXXZLHPeL5AHwfRsatfhEBy0CE+bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJMIcRuoc4PEJP8Cu7uCzH3gpj+jS0eHFU0v1DVRwQU=;
        b=UPotu5xxz5/HtKAKIc8oQNVNopvbGYquYa9W1Dd3auMsAen+LhCp2sL0k4IuHyZPb6
         mbM3XgYSvLHjjmv+kbwsTElbnuUs95OONtCNPtRtIdNEh3zKPGJL4ebyH2kLHDgn0MWV
         8yYm5QFQrWzxhxL+eixpheWQgXBVrPP6FQkXRxGB0kXyNSLI4WEWtRWQJdj8OVFS7QtK
         iNnCtPKnjL/b8vzIJ/3rAVPzgka9wAD5Vf842MEqJc3BCLitHOYWZsRQ7ohJUfcUKxan
         GL1NblpFlQPbvuHe3WmVbE1uLa7/cP54UYASEuRgnkhnmyPzmJAQEJvbn2ZHx05SzcTo
         OgZg==
X-Gm-Message-State: AOAM532TIZC27CN3rbytyHmcrlJHsehC5oCNrGPqIlVQEhu21wE60vk8
        U06rqHG+qXcl1WMYCLb/CHvR0TJmDO8Sdoe+CXOTgg==
X-Google-Smtp-Source: ABdhPJyUNcuR0/Os0y26GBIYBrO68UQTfqjN/iP78rZAqcOIVdUKzKv7fdolRmfeYPz+I2I3mZLlJ/KahcYSewRtDa4=
X-Received: by 2002:a1f:9bc6:: with SMTP id d189mr14379177vke.54.1598562807235;
 Thu, 27 Aug 2020 14:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
 <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com> <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com>
In-Reply-To: <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 27 Aug 2020 14:13:13 -0700
Message-ID: <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 0/3] adapter: Reconnect audio when resuming from suspend
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, Aug 26, 2020 at 11:21 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Wed, Aug 26, 2020 at 10:41 AM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > Could you PTAL at this v2 patch series. I refactored the audio
> > reconnect to use the policy plugin instead of doing the reconnect as
> > part of the adapter logic, as requested.
> >
> > Thanks
> > Abhishek
> >
> > On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > >
> > > Hi Luiz and Marcel,
> > >
> > > This is a quality of life improvement for the behavior of audio devices
> > > during system suspend. This depends on a kernel change that emits
> > > suspend/resume events:
> > >
> > > https://patchwork.kernel.org/project/bluetooth/list/?series=325771
>
> So we could not just use the disconnect reason like I suggested?

I am using the disconnect reason to mark the device for reconnection
and only queueing it for reconnect on resume. As mentioned in the
patch, this is to account for resumes that are not user driven and
will suspend almost immediately again (i.e. periodic wake up to check
battery level and see if we need to shut down).

>
> > > Right now, audio devices will be disconnected as part of suspend but
> > > won't be reconnected when the system resumes without user interaction.
> > > This is annoying to some users as it causes an interruption to their
> > > normal work flow.
> > >
> > > This change reconnects audio devices that were disconnected for suspend
> > > using the following logic:
> > >
> > >  * Register a callback for controller resume in the policy plugin.
> > >  * In the device disconnect callback, mark any devices with the A2DP
> > >    service uuid for reconnect on resume after a delay.
> > >  * In the controller resume callback, queue any policy items that are
> > >    marked to reconnect on resume for connection with the
> > >    ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).
>
> Something like ResumeDelay would probably be better.

Sure, I will rename this.

>
> > > A reconnect is only attempted once after the controller resumes and the
> > > delay between resume and reconnect is configurable via the
> > > ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
> > > arbitrarily and I think anywhere up to 10s is probably ok. A longer
> > > delay is better to account for spurious wakeups and Wi-Fi reconnection
> > > time (avoiding any co-ex issues) at the downside of reconnection speed.
>
> I would keep the same logic as out of range so the platforms can
> customize the number of attempts.

So the first reconnect attempt after resume should be separately
configurable (i.e. 5s) but subsequent reconnect attempts would use the
reconnect-intervals values? That sounds good to me.

>
> > > Here are the tests I have done with this:
> > > - Single suspend and verified the headphones reconnect
> > > - Suspend stress test for 25 iterations and verify both Wi-Fi and
> > >   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
> > >   10s)
> > > - Suspend test with wake time < 5s to verify that BT reconnect isn't
> > >   attempted. Ran 5 iterations with low wake time and then let it stay
> > >   awake to confirm reconnect finally completed after 5s+ wake time.
> > > - Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
> > >   verified it wasn't connected at the end. A connection attempt was
> > >   made but not completed due to suspend. A reconnect attempt was not
> > >   made afterwards, which is by design.
> > >
> > >   Luiz@ Marcel@: Does this sound ok (give up after an attempt)?
> > >
> > > I've tested this on a Pixelbook Go (AC-9260 controller) and HP
> > > Chromebook 14a (RTL8822CE controller) with GID6B headset.
> > >
> > > I've also tested this with the Pixel Buds 2. These earbuds actually
> > > reconnect automatically to the Chromebook (even without this policy
> > > change) and I verified that the new changes don't break the reconnection
> > > mechanism.
> > >
> > > Thanks
> > > Abhishek
> > >
> > >
> > > Changes in v2:
> > > - Refactored to use policy instead of connecting directly in adapter
> > >
> > > Abhishek Pandit-Subedi (3):
> > >   mgmt: Add controller suspend and resume events
> > >   monitor: Add btmon support for Suspend and Resume events
> > >   policy: Reconnect audio on controller resume
> > >
> > >  lib/mgmt.h       | 14 +++++++++++
> > >  monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
> > >  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> > >  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
> > >  src/adapter.h    |  6 +++++
> > >  src/main.c       |  1 +
> > >  src/main.conf    |  9 +++++++
> > >  7 files changed, 190 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.28.0.297.g1956fa8f8d-goog
> > >
>
>
>
> --
> Luiz Augusto von Dentz
