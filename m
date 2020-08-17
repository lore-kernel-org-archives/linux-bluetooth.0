Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3058C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB4220657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjCAvyXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgHQR2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgHQRLS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 13:11:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA2C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:11:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h16so13992944oti.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWeNEkNfq1meNCt3Isl8R2a96rkFpIvROSVf2r++u2A=;
        b=DjCAvyXBrXoVKz4YVQc7EDwas/ts6H55sPx9ZggebnplYs2N1tiY10AoS6GtOWRX6+
         POMXgrOLVnnI8fmA5UYWze2KPq/zwFZkHGMBsx70p5BUbMtpFkhFmNFc27SPwoUJlSiy
         1Fo2pabsGey1lvsJmMTrmcrqrKJVCzp14qEcIxfhnUuPOMmX2NqBJUnBRHu6pNA0SkRC
         2u3bBsF+QhSnbXyAUXyhAy8s1bmd3ZklRxfeRxLbqn3Ltj8r0ffLiYUZOfyZvLRtY7de
         7vkAL11ZiBcTROgUVaGvRzNg7CiEm8mPUB1EluSX2k7f+66Ba3g+aKh/b4UED2kZcDk4
         KmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWeNEkNfq1meNCt3Isl8R2a96rkFpIvROSVf2r++u2A=;
        b=L8uzZDVRcUFrCAyxGbACQlGU4vEysB/DmFB7CjDPfV8wdQx3xFBV8xIWvxVBNU81Uo
         jEf5uxf3oXZGJ2FiAaSVMX+WN5/GL9YCtLGI1RrQ7J895J/m6X3h9ngGHecxr8IhxajH
         j1fYn+3gap2HgX/QcsZ11bwTfyN/RxgIycnqYKUFIxWzF2p8EtAsRlKC7WOzId3QXN6g
         SaRZ3kVD9EYY6DIlDrPhOfJl2pCur3S07kxISi+GIdGI2kXfucxPW8JTfcAJ7WaBxC+Y
         w92Eel14xcsau4ICmxUFzRjiRHyEKEX5e2s+sX8/OQiOlo1WDVufIqVqzOHDZrnG2cqc
         gmWw==
X-Gm-Message-State: AOAM530LrRmEEsh52jyEHIYGkthxh8QqDrEXva7nhC/5XyRfNImPKEuN
        U9TCiSXzeXfJCmBhtj1gzVdZdlZq2UzgTbZ3+V8=
X-Google-Smtp-Source: ABdhPJwwO5CkMRHDYb83BDrGy/TN6kFLnvXgqE1Zz4fYFPRm6BsOI0B45nI7sTsjjj6PG0lY5/q6ypziMDEeiMhxMf4=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr11500633otj.362.1597684277869;
 Mon, 17 Aug 2020 10:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200807142429.BlueZ.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
In-Reply-To: <20200807142429.BlueZ.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 10:11:07 -0700
Message-ID: <CABBYNZL4s151e-a+X0fEA73RM54aA--m+on7as4dLrJX0xevQQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Disable auto-connect on cancel pair
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Fri, Aug 7, 2020 at 2:24 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> While pairing process is in progress, service discovery starts in the
> background. If HOG profile is detected, auto connect is enabled for
> that device. This causes future advertisement from that device to
> trigger a pairing even if the user has already cancelled the pairing.

So it looks like something is not right if the user cancel the pairing
process I would expect the device to be removed if this happens when
setting up a new device or at least call Disconnect method which would
disable auto_connect if the device is not trusted.

> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
>
>  src/device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 470596ee4..ab5bb123e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2870,6 +2870,15 @@ static void device_cancel_bonding(struct btd_device *device, uint8_t status)
>         if (!bonding)
>                 return;
>
> +       /* Auto connect may get enabled during the service discovery even
> +        * before the pairing process completes. In such case, disable it
> +        * when the user has cancelled the pairing process.
> +        */
> +       if (device->auto_connect) {
> +               device->disable_auto_connect = TRUE;
> +               device_set_auto_connect(device, FALSE);
> +       }

BlueZ has the trusted property so upper layer can actually flag if the
device is trusted regardless if it is paired on not, so this seems out
of place or we should at least check if if the device has been marked
as trusted.
>         ba2str(&device->bdaddr, addr);
>         DBG("Canceling bonding request for %s", addr);
>
> --
> 2.28.0.236.gb10cc79966-goog
>


--
Luiz Augusto von Dentz
