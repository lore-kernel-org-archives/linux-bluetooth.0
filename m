Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA86B208C7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iX6Uye0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgHDRMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgHDRMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 13:12:30 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185DC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 10:12:30 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j23so15092341vsq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aldbhSzOkNRsGNiPJyEC/gglp+26OuNIUIYrm3hBhJE=;
        b=iX6Uye0aXNQArYfLdZEVLD/zW8NoQMEHi2sfdh9o/pwjVrCyRREZ3+tgmYgVBwQH01
         VAmkPVQNbpkphKOQkbfN7v1XrkGtoZ/rB5kJYtyJaibhJwE3biZBN6x5w1xNBEd79NRz
         HMHeJcaQB7zR5LaEtOv3GRtFA811E+5vYp/0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aldbhSzOkNRsGNiPJyEC/gglp+26OuNIUIYrm3hBhJE=;
        b=W/B74WfIlSHBO/s3g0n0l9n61KCpKVx3KqJ2p1T4r6TDo3iOVv35t/Md/C/cVm6Nly
         FW8TwY1qeYYzgdx0qtZBqo9UIcN9RKkr4LhPhFwUBdYGXIMn5eI3Yc0VU/6I1o3reCe1
         Xg9sbMHuOxWReVW1wwq+aUqmKc9tskEZAfVrbub/vBp/vLY9sN9cRN66aMO3tSKxpMzo
         arnkJhLqTU0JcFp8DANVVO1H1/VvnzGdkj3oj3XjmPQ2EsYUkCxQB13FAGcvoI7zQecc
         CfolQlCbg75t/Z3p1gGt5HBOdHbUK6qLqF+D4PHzVx+7dJAzT/ZGhIwDdGdtIHpONXQK
         aWSQ==
X-Gm-Message-State: AOAM531Qm91M4qkvUY6Oofh10OiJ4SX58JOvNiHxfaUCdiv/wmm2tJdk
        LJ105I1pAP26vTY9J6DPZCBMypsr+jRti5nBeSiSwg==
X-Google-Smtp-Source: ABdhPJzexOr11cx+rybI7pAl/bxA0ZIEAMu48optiPZpp1K8AInizPGgxbP3/m/1O0WBMOGqxnCuJIYI1WI9zqhrkCM=
X-Received: by 2002:a67:3111:: with SMTP id x17mr16188920vsx.196.1596561148224;
 Tue, 04 Aug 2020 10:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200729015540.1848987-1-abhishekpandit@chromium.org>
In-Reply-To: <20200729015540.1848987-1-abhishekpandit@chromium.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 4 Aug 2020 10:12:16 -0700
Message-ID: <CANFp7mU3zRr2P7NBQKfNQQf7c-xb1T=cRys_=iGnoBBrVNFkZA@mail.gmail.com>
Subject: Re: [RFC Bluez PATCH 0/3] adapter: Reconnect audio when resuming from suspend
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

Hi,

Gentle reminder that this is waiting for feedback.

Thanks
Abhishek

On Tue, Jul 28, 2020 at 6:55 PM Abhishek Pandit-Subedi
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
>  * In the Device Disconnected management event, if the disconnect reason
>    was 0x5 (Disconnected by Local Host for Suspend) and the device is an
>    audio sink (implements major services Audio + Rendering), then it is
>    queued for reconnect.
>  * When the Controller Resumed management event is seen, we check if
>    an audio device needs to be reconnected. If yes, we queue a delayed
>    callback to do the reconnection. The delay is 5s by default and is
>    meant to allow sufficient time for any Wi-Fi activity that may occur
>    during resume (since Bluetooth connect may adversely affect that).
>
> A reconnect is only attempted once after the controller resumes and the
> delay between resume and reconnect is configurable via the
> ReconnectAudioDelay key in the General settings. The 5s delay was chosen
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
> Chromebook 14a (RTL8822CE controller) with GID6B headset. I'm hoping to
> test this with a few more headsets to make sure this is ok and I'm
> looking for some early feedback.
>
> Thanks
> Abhishek
>
>
>
> Abhishek Pandit-Subedi (3):
>   mgmt: Add controller suspend and resume events
>   monitor: Add btmon support for Suspend and Resume events
>   adapter: Reconnect audio on controller resume
>
>  lib/mgmt.h       | 14 +++++++++
>  monitor/packet.c | 55 ++++++++++++++++++++++++++++++++
>  src/adapter.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.c     | 27 ++++++++++++++++
>  src/device.h     |  2 ++
>  src/main.conf    |  6 ++++
>  6 files changed, 186 insertions(+)
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
