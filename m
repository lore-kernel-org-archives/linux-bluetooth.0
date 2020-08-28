Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A2C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D5B2098B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0lA5bHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgH1RjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1RjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 13:39:06 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC69C061264
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:39:04 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g20so626063uap.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83mTnWWXG7WFYcr10rntPntqh05P5b7hERwEwyd9wf0=;
        b=j0lA5bHKaxKxedVcnpAcn/LIBj5wcXISGJkaa64a22wQPulTAUSSDXJ/TJRHoxHtnK
         0056gKSbW//A9LcHq/EM0T7JKbfuicc0UHEioR5+VlkO1sFqYv2PAcE9i9L1+oteZTqm
         vV9q7zHg0K0RMspfSUCh1iuFu5HJn3/b1rKls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83mTnWWXG7WFYcr10rntPntqh05P5b7hERwEwyd9wf0=;
        b=G5BoKtOZdZzsMfXZe/dn10DjSMhIv7zM7tcdKf2/5c39ij5ZRu0c88/gtxBvvYnlm6
         +e/J6pRtTzbjXtEocQofSDQzxkrs4EzBO2xWhRqPi7KfNfr2dX6OiGCv7b4KppqMGyD6
         b8We3aQxsyXS4pQ+7s+g5qOFWlxt9oSFQgKDhQOZMcgVVHUjeiCBDRIBzcFzFiDjovyD
         bSdm2Zx8e27oGlSrn54MZBg3+7n6KwNuCQMvamK//S9eeyRyxuqKVfcR9calWAze6mlR
         J/VoF6W+VXuN3EKFDgiPKcLRUL9vLoLyao5NVJM9B+fI05/tLDZFnd71QISvfmWpE1Qi
         zhhw==
X-Gm-Message-State: AOAM530st1bj/wBktBAh5Q+qSMDrKhUmIr4WN90hn2ivWcH7bXG7cTQs
        c1t5a+nTQfgVU1ar/+VgYBzvQKVp70GF4tbnXwI4+w==
X-Google-Smtp-Source: ABdhPJxxrHooY3ZRSKmhwC8sKq9K/ICwN6X5V3eAnh3ZhOaaZOwPgWeWuaKF9Xh0SnnNMA/L+n53LdqEaB+kkHjNiEo=
X-Received: by 2002:ab0:5905:: with SMTP id n5mr1983421uad.90.1598636343793;
 Fri, 28 Aug 2020 10:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
 <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
 <CABBYNZLmfWWBYZjHDkHmMpzYC02zFpWMV_xAiD1pK3cc09JwSA@mail.gmail.com>
 <CANFp7mWf1xDg6+nLMyrjaMaqF0=GyhauwN43ny5QMT0MWYd+tA@mail.gmail.com> <CABBYNZ+YMfvcVnB7afXyFa_bz2oNaivgsmyhS=yOGrKuh4JG9A@mail.gmail.com>
In-Reply-To: <CABBYNZ+YMfvcVnB7afXyFa_bz2oNaivgsmyhS=yOGrKuh4JG9A@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 28 Aug 2020 10:38:51 -0700
Message-ID: <CANFp7mVWAWkDgYJT61xGKAgYzycbjyaePngFho9dcfqkxRcuPg@mail.gmail.com>
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

Hey Luiz,

On Fri, Aug 28, 2020 at 10:22 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Thu, Aug 27, 2020 at 2:13 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Wed, Aug 26, 2020 at 11:21 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Abhishek,
> > >
> > > On Wed, Aug 26, 2020 at 10:41 AM Abhishek Pandit-Subedi
> > > <abhishekpandit@chromium.org> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Could you PTAL at this v2 patch series. I refactored the audio
> > > > reconnect to use the policy plugin instead of doing the reconnect as
> > > > part of the adapter logic, as requested.
> > > >
> > > > Thanks
> > > > Abhishek
> > > >
> > > > On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
> > > > <abhishekpandit@chromium.org> wrote:
> > > > >
> > > > >
> > > > > Hi Luiz and Marcel,
> > > > >
> > > > > This is a quality of life improvement for the behavior of audio devices
> > > > > during system suspend. This depends on a kernel change that emits
> > > > > suspend/resume events:
> > > > >
> > > > > https://patchwork.kernel.org/project/bluetooth/list/?series=325771
> > >
> > > So we could not just use the disconnect reason like I suggested?
> >
> > I am using the disconnect reason to mark the device for reconnection
> > and only queueing it for reconnect on resume. As mentioned in the
> > patch, this is to account for resumes that are not user driven and
> > will suspend almost immediately again (i.e. periodic wake up to check
> > battery level and see if we need to shut down).
> >
> > >
> > > > > Right now, audio devices will be disconnected as part of suspend but
> > > > > won't be reconnected when the system resumes without user interaction.
> > > > > This is annoying to some users as it causes an interruption to their
> > > > > normal work flow.
> > > > >
> > > > > This change reconnects audio devices that were disconnected for suspend
> > > > > using the following logic:
> > > > >
> > > > >  * Register a callback for controller resume in the policy plugin.
> > > > >  * In the device disconnect callback, mark any devices with the A2DP
> > > > >    service uuid for reconnect on resume after a delay.
> > > > >  * In the controller resume callback, queue any policy items that are
> > > > >    marked to reconnect on resume for connection with the
> > > > >    ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).
> > >
> > > Something like ResumeDelay would probably be better.
> >
> > Sure, I will rename this.
> >
> > >
> > > > > A reconnect is only attempted once after the controller resumes and the
> > > > > delay between resume and reconnect is configurable via the
> > > > > ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
> > > > > arbitrarily and I think anywhere up to 10s is probably ok. A longer
> > > > > delay is better to account for spurious wakeups and Wi-Fi reconnection
> > > > > time (avoiding any co-ex issues) at the downside of reconnection speed.
> > >
> > > I would keep the same logic as out of range so the platforms can
> > > customize the number of attempts.
> >
> > So the first reconnect attempt after resume should be separately
> > configurable (i.e. 5s) but subsequent reconnect attempts would use the
> > reconnect-intervals values? That sounds good to me.
>
> Right, though 5 seconds seems awfully long compared to the normal
> first attempt, so perhaps we could default it to just 1-2 seconds.
>

I will change the default to 2s and make sure we test this on some
older chipsets to check for interference with Wi-Fi.

> > >
> > > > > Here are the tests I have done with this:
> > > > > - Single suspend and verified the headphones reconnect
> > > > > - Suspend stress test for 25 iterations and verify both Wi-Fi and
> > > > >   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
> > > > >   10s)
> > > > > - Suspend test with wake time < 5s to verify that BT reconnect isn't
> > > > >   attempted. Ran 5 iterations with low wake time and then let it stay
> > > > >   awake to confirm reconnect finally completed after 5s+ wake time.
> > > > > - Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
> > > > >   verified it wasn't connected at the end. A connection attempt was
> > > > >   made but not completed due to suspend. A reconnect attempt was not
> > > > >   made afterwards, which is by design.
> > > > >
> > > > >   Luiz@ Marcel@: Does this sound ok (give up after an attempt)?
> > > > >
> > > > > I've tested this on a Pixelbook Go (AC-9260 controller) and HP
> > > > > Chromebook 14a (RTL8822CE controller) with GID6B headset.
> > > > >
> > > > > I've also tested this with the Pixel Buds 2. These earbuds actually
> > > > > reconnect automatically to the Chromebook (even without this policy
> > > > > change) and I verified that the new changes don't break the reconnection
> > > > > mechanism.
> > > > >
> > > > > Thanks
> > > > > Abhishek
> > > > >
> > > > >
> > > > > Changes in v2:
> > > > > - Refactored to use policy instead of connecting directly in adapter
> > > > >
> > > > > Abhishek Pandit-Subedi (3):
> > > > >   mgmt: Add controller suspend and resume events
> > > > >   monitor: Add btmon support for Suspend and Resume events
> > > > >   policy: Reconnect audio on controller resume
> > > > >
> > > > >  lib/mgmt.h       | 14 +++++++++++
> > > > >  monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
> > > > >  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> > > > >  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
> > > > >  src/adapter.h    |  6 +++++
> > > > >  src/main.c       |  1 +
> > > > >  src/main.conf    |  9 +++++++
> > > > >  7 files changed, 190 insertions(+), 4 deletions(-)
> > > > >
> > > > > --
> > > > > 2.28.0.297.g1956fa8f8d-goog
> > > > >
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

Thanks
Abhishek
