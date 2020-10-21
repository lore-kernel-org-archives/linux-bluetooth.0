Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3DC55179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5452177B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwdgF/QC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502963AbgJUQfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438247AbgJUQfG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Oct 2020 12:35:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24EC0613CE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 09:35:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id n3so2756172oie.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/10uoXxZ1TPKQwUATI34Kv0Q0gHHOW25jc+JJMZOc0=;
        b=bwdgF/QCmbrNYBmt2SDNW32cc5r7Ds02ZWnpiMNntCWeQDrCLEEeU8CItmR8DooP4G
         Yl0HOpRMp97FZgJj3KtuaONIWlCjbGiqWRePIhLkeCX4XpXJIovLUh2U66MMT+3zSPom
         gcF7BTj6yXqO2lHoujWBAJF4Ral0Mgbj7vPAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/10uoXxZ1TPKQwUATI34Kv0Q0gHHOW25jc+JJMZOc0=;
        b=NQSa/bQr83db3KuSTsQRdEyftPYcAN7Q5UlhgdPLJSGPqA6xpPqmyRpBhqT26k7Nhe
         XoQwdWet79F+OUohepLuBfRyVT3rbPUufhEoOoKW96BLSWff3VnhbIO6gTKKBv12gWKS
         qs9xtH1lXlAIVeB1nkmqVUCCF6E5KicmikH29MGoWVzn3d3jK8X/qyMuhoJlThOHA32Z
         En1ajtcRAFzEKApQdQfmnHdfpTCYGNVOQnA3BVXhJbhcCZC7KOyga1kOeYuLoJfTq8cm
         InMgXmxpEt6AkkQEkyxCZj/Rqht3zrVPr4Xz4fcevjg6upCWHqBe21Q6ZCE3jFXVUzlH
         hBng==
X-Gm-Message-State: AOAM533HLMo91ecWY7rPQqP0IoRL8nrQgNijfva9gjIorfaJAqP1y4mC
        DJDXH76Wy7XfEjYBt4z9eA/DiLHwQ9XcbiNZynhmnA==
X-Google-Smtp-Source: ABdhPJy7LEWAvY1CCO/BDnV38CtrSlGe/e/BqV2UFqRUfp56PmIzJP2OhF1bQdzYSZS7il45urX7ohnzbFASB3GXqn4=
X-Received: by 2002:aca:ab8b:: with SMTP id u133mr2708150oie.132.1603298105597;
 Wed, 21 Oct 2020 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
In-Reply-To: <20201019172529.1179996-1-luiz.dentz@gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 21 Oct 2020 09:34:53 -0700
Message-ID: <CANFp7mVmb28hfSU5aQgsuZNd=0u0bFOPLj8jz2Z3ijzxnzY-Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Fix not checking advertisement bondaries
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 19, 2020 at 10:25 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When receiving advertisements check if the length is actually within
> the skb, this also make use of skb_pull to advance on the skb->data
> instead of a custom ptr that way skb->len shall always indicates how
> much data is remaining and can be used to perform checks if there is
> enough data to parse.
>
> Fixes: a2ec905d1e160a33b2e210e45ad30445ef26ce0e ("Bluetooth: fix kernel oops in store_pending_adv_report")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fixes rssi parsing.
>
>  net/bluetooth/hci_event.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)

Tested-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

I cherry-picked this to our 4.19 kernel and ran our LE Health tests on
the Kohaku chromebook (AX201 controller). All tests are passing.
