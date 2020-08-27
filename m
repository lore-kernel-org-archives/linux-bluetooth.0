Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD085C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6279120825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxhZqvRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0VSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0VSz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 17:18:55 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC67C061264
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 14:18:55 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id e41so636882uad.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uvsehs1Z/ivRBh8UrxKEUL/EppasaXDq8JRk0ShquEs=;
        b=nxhZqvRi9rS+XXDTsYK8/1wLC3y5qdutJk9rZwFQly9hEn0j/UyD5gp9E5I9fvTbTF
         J5bKjOQeV9xkde+99qA0Ss+cGv5NjKXAXOy5uVKMSw3XmxVr+LozoUiPRHPDDn+BMiCZ
         BR/i/vPXuxG9BuCc9urMHqEyz177ezk0lMyYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uvsehs1Z/ivRBh8UrxKEUL/EppasaXDq8JRk0ShquEs=;
        b=m03J6rqLqswSLsdtvHe9n/RongcrGC/fz81UuuqK5qKTRg41Ah1YbpE8nM+kEpkiFB
         IGhyUhNkkCh0fsIvuXFDp7z6ew3nR0qlZc0HIktET176ipEESAm6ahW4S0pwIyTUgf2R
         +dbdOzs90FNHBz6RUghCuNvhmlhWlkizQgGOR9PkB4NJs+Wmxgc7SH2GjCZbGkIlYFWZ
         T8/0MoALQTkNlmWC7WeF96+RsXxROIBhwrFZrw1yzAlsnO8l6NO5ERw4u7ONTEX3e3oL
         nLFRZlOWA/YC7yValEiHBb7Crj8Yp+0UiPNE1WVDKhbnGGNKJSE1xUchdkX0zz5kmd/4
         tGgQ==
X-Gm-Message-State: AOAM531ktDjL6gafbWL64zMFdaKzEfFKmGxdXnXEJOKZYrtraObS5nF9
        mesqvUzRYDQF07vrBIGIUa9u6DS4EQS/Z2Jtt0dwNw==
X-Google-Smtp-Source: ABdhPJz8MhKw9Io1d5e5ahxolqWwSDMpzr7TlQWTxz9xH4//Ha+tYCN6QHpTkfXY3xC5lUvIZBTL/NPQG2Yhv1+ufCI=
X-Received: by 2002:ab0:5905:: with SMTP id n5mr1506144uad.90.1598563134246;
 Thu, 27 Aug 2020 14:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
 <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
 <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com> <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com>
In-Reply-To: <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 27 Aug 2020 14:18:40 -0700
Message-ID: <CANFp7mVGCk7bYiNfGmOvNWzr=S51ME5fe20FE+JoGR9Rkk41gA@mail.gmail.com>
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

Correction: As mentioned in my response to patch 3 in this series:
https://lore.kernel.org/linux-bluetooth/CANFp7mV03KvqpOH=LBU=0tBDhgK5K2YJ6rxYvkDKmyer4n_gLw@mail.gmail.com/

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
>
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
