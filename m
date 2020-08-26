Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74547C433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4934A207DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQOOyeeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZRmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHZRlz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 13:41:55 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA75C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 10:41:40 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i20so625658vkk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjbPm9wZL1OZBXAXLIVEJy8Z8Xq+x7W89UufjmoD5cc=;
        b=AQOOyeeK8alwcxLeR/dLIDVKm7ZvvWLhUZAgkI8CA5VOpkBPXXOS9Fsuz4zQbOFvYo
         z8iFhU3JVfpW7OQDa3WE50aJrCQljZFXBwFfFrYTrnZHMibaZvrqb/+KIb5reKV0cxoP
         Rwg9db3dn4WgX2IpyWun8dcp1ICKQDcXEkK/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjbPm9wZL1OZBXAXLIVEJy8Z8Xq+x7W89UufjmoD5cc=;
        b=IK93YmqsLLWux5Xf9SpODGZesPTT1YyQOlCKtngFfifSq6U7eqipoTrT0EBbVWkczh
         DNfjf1tUH0xzpPzfT80yN8ikj0ZHvRyY21ZwNwkL36WGfuXORssSDbK4Flmi0I1WaBOl
         iEucBSPiyIQ5DG2xw9bPd4KCQe6U9ysSzCFxr9Gfxvmzx5hX3pMsrgFYB2V5BV2dqoe5
         flW/eg7gPJOb/z+Z7GjiUM310HaM19Mp/0L4igPFkMmLxBwHS9DlT/6ICFnyTC1cqJgG
         oz4CJMXNLMWnAZPF9hrDNOH/NpIlNnpxOOxDlJcps30AoRPkgw38nnWPWC4BxVMK+2Pt
         YNRQ==
X-Gm-Message-State: AOAM532JcmuPSqajTZ6n0NmUzscKVj16zJ7HWCv/svli9NlHvxExmubx
        5wRbt8pauXrXew5dxPVtrg4xTHw9DlyyLf/sh6kHhQ==
X-Google-Smtp-Source: ABdhPJykxK1jAgdMEMNI+OUnJP6yopETkGlrnY6VbCrN+la3ABTQXvoCOl+hmbNNfgNkMgZUQomhrrdt4p1YSMbGApc=
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr10122587vkc.53.1598463699769;
 Wed, 26 Aug 2020 10:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
In-Reply-To: <20200818232822.1645054-1-abhishekpandit@chromium.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 26 Aug 2020 10:41:28 -0700
Message-ID: <CANFp7mWqT1mO0OcJAt4AycTgFLz22p7zyRGjR1Hvj4bJmHHsTw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 0/3] adapter: Reconnect audio when resuming from suspend
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Could you PTAL at this v2 patch series. I refactored the audio
reconnect to use the policy plugin instead of doing the reconnect as
part of the adapter logic, as requested.

Thanks
Abhishek

On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> Hi Luiz and Marcel,
>
> This is a quality of life improvement for the behavior of audio devices
> during system suspend. This depends on a kernel change that emits
> suspend/resume events:
>
> https://patchwork.kernel.org/project/bluetooth/list/?series=325771
>
> Right now, audio devices will be disconnected as part of suspend but
> won't be reconnected when the system resumes without user interaction.
> This is annoying to some users as it causes an interruption to their
> normal work flow.
>
> This change reconnects audio devices that were disconnected for suspend
> using the following logic:
>
>  * Register a callback for controller resume in the policy plugin.
>  * In the device disconnect callback, mark any devices with the A2DP
>    service uuid for reconnect on resume after a delay.
>  * In the controller resume callback, queue any policy items that are
>    marked to reconnect on resume for connection with the
>    ReconnectAudioDelay value (default = 5s for Wi-Fi coexistence).
>
> A reconnect is only attempted once after the controller resumes and the
> delay between resume and reconnect is configurable via the
> ReconnectAudioDelay key in the Policy settings. The 5s delay was chosen
> arbitrarily and I think anywhere up to 10s is probably ok. A longer
> delay is better to account for spurious wakeups and Wi-Fi reconnection
> time (avoiding any co-ex issues) at the downside of reconnection speed.
>
> Here are the tests I have done with this:
> - Single suspend and verified the headphones reconnect
> - Suspend stress test for 25 iterations and verify both Wi-Fi and
>   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
>   10s)
> - Suspend test with wake time < 5s to verify that BT reconnect isn't
>   attempted. Ran 5 iterations with low wake time and then let it stay
>   awake to confirm reconnect finally completed after 5s+ wake time.
> - Suspend test with wake time between 3s - 6s. Ran with 5 iterations and
>   verified it wasn't connected at the end. A connection attempt was
>   made but not completed due to suspend. A reconnect attempt was not
>   made afterwards, which is by design.
>
>   Luiz@ Marcel@: Does this sound ok (give up after an attempt)?
>
> I've tested this on a Pixelbook Go (AC-9260 controller) and HP
> Chromebook 14a (RTL8822CE controller) with GID6B headset.
>
> I've also tested this with the Pixel Buds 2. These earbuds actually
> reconnect automatically to the Chromebook (even without this policy
> change) and I verified that the new changes don't break the reconnection
> mechanism.
>
> Thanks
> Abhishek
>
>
> Changes in v2:
> - Refactored to use policy instead of connecting directly in adapter
>
> Abhishek Pandit-Subedi (3):
>   mgmt: Add controller suspend and resume events
>   monitor: Add btmon support for Suspend and Resume events
>   policy: Reconnect audio on controller resume
>
>  lib/mgmt.h       | 14 +++++++++++
>  monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
>  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
>  src/adapter.h    |  6 +++++
>  src/main.c       |  1 +
>  src/main.conf    |  9 +++++++
>  7 files changed, 190 insertions(+), 4 deletions(-)
>
> --
> 2.28.0.297.g1956fa8f8d-goog
>
