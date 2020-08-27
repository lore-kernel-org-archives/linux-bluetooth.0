Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 06:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E992078A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 06:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2v+dMMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgH0GVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0GVD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 02:21:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E300C06125E
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 23:21:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t7so3553646otp.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yCzYVDGjFXRToO2nHPXDmKIWs/zZ6jwx+WQx1MXFe8=;
        b=K2v+dMMkJVR13irqneSrBJyQFysfJa007wpdRNBmRw3vkV6tuGYnSB3nkGB8SFFUty
         l+BqdailEtGSu9TdIbeiwLYAJ7r6McHtJ5ft7OAJJQQ/BodaMOEr1KPbaN1nDcnZTONs
         wqYCdJqsnu0lXnwsRQ9JJjo/wUqjXmsCs7D2ATghTvatusmwUI95AAOR2ZntNVMOFUUW
         rXdjJYgqXqijTAxwQ5wcQN9YHK9or9JIpSrzQB6KCFz8Hzj61E77Szm34NY2BamFGae6
         6PM75qnjd8EMBRxaQ3G/9u9AMtjb0FayJ+Cm7SOCA6ryyDLV9VXA7UsifRMJfZvDstFo
         al+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yCzYVDGjFXRToO2nHPXDmKIWs/zZ6jwx+WQx1MXFe8=;
        b=fbO8y8BhPe/Z/bcgMBExV8lnQ01mKmDFZq75Ml2xQvn6qvq/EkGSmRfT20doAkDoHg
         +7m+6cnFd4ZUpWjzVTHDnENmYMwXO9nzMUrZjh+4JPP7Yj4pykbeKJKTYbkUP6rtlGlK
         N6sri6z2vYh2rW2GjMOVEeBucM2Cget8KNN29sPcM4TXrWJXumCV26AUujwfqu1/5CLe
         J8dzHV7wTZAM17W6KvrHYA3uYUn0AvAgjMoxqep1FUbtCUrVdNkDE2pGHJdiahf+utMQ
         jvPh7CNU4GbgX8Wkm8PaDCQNd31IrzHbGDg+oLnQ8/PaazINUDKTktfmxr/JLOjL8GhA
         Lx3A==
X-Gm-Message-State: AOAM5311y/BLO2wXDgI3+IfsWoGmh8jYV9VhR9vbniTqnzA0RXUCF+Fq
        QJFRe7J3RNADd/pr3YBtFx4BupR7v3eGhsYuNiOCeHTW
X-Google-Smtp-Source: ABdhPJyNvFweq8RStXojvIqAClTpHCRj2xSHsGhS+uEehVrIhX7yKFJytq2SodgIeUZ/K1pXIUOtfbHX29+eNH/noP8=
X-Received: by 2002:a9d:429:: with SMTP id 38mr11536777otc.88.1598509260420;
 Wed, 26 Aug 2020 23:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org> <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
In-Reply-To: <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 26 Aug 2020 23:20:49 -0700
Message-ID: <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 10:41 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> Could you PTAL at this v2 patch series. I refactored the audio
> reconnect to use the policy plugin instead of doing the reconnect as
> part of the adapter logic, as requested.
>
> Thanks
> Abhishek
>
> On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
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

So we could not just use the disconnect reason like I suggested?

> > Right now, audio devices will be disconnected as part of suspend but
> > won't be reconnected when the system resumes without user interaction.
> > This is annoying to some users as it causes an interruption to their
> > normal work flow.
> >
> > This change reconnects audio devices that were disconnected for suspend
> > using the following logic:
> >
> >  * Register a callback for controller resume in the policy plugin.
> >  * In the device disconnect callback, mark any devices with the A2DP
> >    service uuid for reconnect on resume after a delay.
> >  * In the controller resume callback, queue any policy items that are
> >    marked to reconnect on resume for connection with the
> >    ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).

Something like ResumeDelay would probably be better.

> > A reconnect is only attempted once after the controller resumes and the
> > delay between resume and reconnect is configurable via the
> > ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
> > arbitrarily and I think anywhere up to 10s is probably ok. A longer
> > delay is better to account for spurious wakeups and Wi-Fi reconnection
> > time (avoiding any co-ex issues) at the downside of reconnection speed.

I would keep the same logic as out of range so the platforms can
customize the number of attempts.

> > Here are the tests I have done with this:
> > - Single suspend and verified the headphones reconnect
> > - Suspend stress test for 25 iterations and verify both Wi-Fi and
> >   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
> >   10s)
> > - Suspend test with wake time < 5s to verify that BT reconnect isn't
> >   attempted. Ran 5 iterations with low wake time and then let it stay
> >   awake to confirm reconnect finally completed after 5s+ wake time.
> > - Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
> >   verified it wasn't connected at the end. A connection attempt was
> >   made but not completed due to suspend. A reconnect attempt was not
> >   made afterwards, which is by design.
> >
> >   Luiz@ Marcel@: Does this sound ok (give up after an attempt)?
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
> > Changes in v2:
> > - Refactored to use policy instead of connecting directly in adapter
> >
> > Abhishek Pandit-Subedi (3):
> >   mgmt: Add controller suspend and resume events
> >   monitor: Add btmon support for Suspend and Resume events
> >   policy: Reconnect audio on controller resume
> >
> >  lib/mgmt.h       | 14 +++++++++++
> >  monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
> >  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> >  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
> >  src/adapter.h    |  6 +++++
> >  src/main.c       |  1 +
> >  src/main.conf    |  9 +++++++
> >  7 files changed, 190 insertions(+), 4 deletions(-)
> >
> > --
> > 2.28.0.297.g1956fa8f8d-goog
> >



-- 
Luiz Augusto von Dentz
