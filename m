Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A5C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E30820732
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMBQuVkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIOSdP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgIOSNI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 14:13:08 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F96CC061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 11:05:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so4103514otq.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DckkTMToW/Pd08x0QOBy7IYkr6sSl78D8segN8Yf5Tc=;
        b=JMBQuVkqCjfCvc5R+aQmYagSsW9rZgC91ygi5XK3BYXSJj4ZZ+zFlT1y6rVbEoYfSk
         wv5QOn7X+XllvXasyXij9i6Li08oahcN+wd/nkSjnC8XHYM65ImtKZ/ThPYMhlx/C9ue
         s8RZ3sf28dSaOf8nA5BJZ4G8RoqqV5utAvO2k9pJk3kS6C/qNSVDjCkLLdYQrhO6w2ER
         KjYLODNJVNTU44AUDlq/sK4FSkPvb4O51HwjkO7swRA1J/KJGSoJczMmiRA2pOdHaWrm
         cOai9u4giKLRHi/p3VjRkU/AUuKoaGB+hWvzo39NPMYWLcaybCN+s5HE3gO1GVwY/9p4
         x08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DckkTMToW/Pd08x0QOBy7IYkr6sSl78D8segN8Yf5Tc=;
        b=Cc+ElL59pqIy8EB7RrW1di14tkiT1VDImdGjitEN05i6xfHpzVdaiH8awgXeSX+lE+
         xH90pDTbTGCnG9Z+I5f1rTEvkOKwyPRqp+XHFR9EXfMd0LaeEdOTnw9DdaCsBFhnB7Sr
         BM4qTISX3okO85dGV8zg0zy6Z95iS6ooRbe3tpkpfCljCINZQMTnPZM2vBOXPmh2NVlY
         xSgRJJq43g67wbNhLX8FCxszpJgRGvCIQds2y+/L8nH0goua2pXWyGFC4CoTyWt4W2VP
         hpcYwPi4mJwIcoFEYWd9uQ+JRqD80ZUgMpvN9YxepOpQRqDWKsRzdqHwi+BkxX8Aa97P
         0vBA==
X-Gm-Message-State: AOAM5336dliwnMYCu6xTBxJH9ICPOF+Y8gIPedT5ahhdZ9qkZ4ZXDJas
        t7N0MVuQheD9jLUjVKyC9U1Frur2WLo/bMPZZPaCAet6
X-Google-Smtp-Source: ABdhPJzScZwRugytri4AJ5+tTWKsNt2A4cQ9px+E2jeWLEUy+dlOF4CrREPP6IuC9q3SCBT9g3rSNlTellC2706uPOk=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr5657965otd.362.1600193115793;
 Tue, 15 Sep 2020 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200915174146.1693687-1-abhishekpandit@chromium.org>
In-Reply-To: <20200915174146.1693687-1-abhishekpandit@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Sep 2020 11:05:04 -0700
Message-ID: <CABBYNZLmyr5a_WoMwkmBsr2Y8LvnY1xiH724Y2BDOAe5zHFJjw@mail.gmail.com>
Subject: Re: [Bluez PATCH v5 0/4] adapter: Reconnect audio when resuming from suspend
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Tue, Sep 15, 2020 at 10:41 AM Abhishek Pandit-Subedi
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
>  * In the device disconnect callback, mark any devices with the A2DP
>    service uuid for reconnect. The reconnect will not be queued until
>    resume.
>  * In the controller resume callback, queue any policy items that are
>    marked to reconnect on resume for connection with the ResumeDelay
>    value (default = 2s).
>
> A reconnect is queued after the controller resumes and the delay
> between resume and reconnect is configurable via the ResumeDelay key in
> the Policy settings. The 2s delay was chosen arbitrarily and I think
> anywhere up to 10s is probably ok. A longer delay is better to account
> for spurious wakeups and Wi-Fi reconnection time (avoiding any co-ex
> issues) at the downside of reconnection speed.
>
> Here are the tests I have done with this:
> - Single suspend and verified the headphones reconnect
> - Suspend stress test for 25 iterations and verify both Wi-Fi and
>   Bluetooth audio reconnect on resume. (Ran with wake minimum time of
>   10s)
> - Suspend test with wake time = 1s to verify that BT reconnect isn't
>   attempted. Ran 5 iterations with low wake time and then let it stay
>   awake to confirm reconnect finally completed on last resume.
> - Suspend test with wake time between 1s - 4s. Ran with 5 iterations and
>   verified it connected several times in the middle and finally at the
>   end.
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
> Changes in v5:
> - Remove use of !! in has_kernel_features

It seems I end up merging the old version by mistake, but I fixed this
one change myself and added btd_ prefix to it since that is required
to be exported for plugins that are not built-in.

> Changes in v4:
> - Set reconnect timer in disconnect if resume events aren't supported
> - Only set reconnect timer if adapter matches current notification
> - Refactor changes in src/adapter to its own commit
> - Refactor enabling A2DP_SINK_UUID into its own commit
>
> Changes in v3:
> - Refactored resume notification to use btd_adapter_driver
> - Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
> - Added A2DP_SINK_UUID to default reconnect list
>
> Changes in v2:
> - Refactored to use policy instead of connecting directly in adapter
>
> Abhishek Pandit-Subedi (4):
>   adapter: Refactor kernel feature globals
>   adapter: Handle controller resume and notify drivers
>   policy: Enable reconnect for a2dp-sink in defaults
>   policy: Reconnect audio on controller resume
>
>  plugins/policy.c |  87 +++++++++++++++++++++++++++++++++-------
>  src/adapter.c    | 102 +++++++++++++++++++++++++++++++++--------------
>  src/adapter.h    |  11 +++++
>  src/main.c       |   1 +
>  src/main.conf    |  11 ++++-
>  5 files changed, 168 insertions(+), 44 deletions(-)
>
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
Luiz Augusto von Dentz
