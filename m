Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B52C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC5361462
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbhI2WqY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346997AbhI2WqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 18:46:23 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A815C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:44:42 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 37so2742736uaq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9o0jJdAUCZkunVukdFNl8xKZYDuj6B8MgEEVKNvohwA=;
        b=VIy7haNQiXUWoQcVqXK9sV67h9RIAi0vgS13Xutr1sH2SsbJhpP8VpQ3npz6dK3YRl
         qi/7mZK1p7oI5BJPn9e7f9VuGu0QGLB5X1LCQUtVs6MVT7KuWL2807GDGSvJlbjFD0JX
         9u054DzSSjKRF4kpcVJgwE4lisNfQ7b+LbcMc7SJCrHvDlSXZWr+udn9HwZVCo4i2QLk
         ZvnlI7G5ExD6YkQimIgapDDOgfboeut5d8wbU3aKSSl7+qVnaZVTfnMGmACIMwnfDiwO
         VHxUkSI1fAS6T1g/+ARazGRITQgbSSjlNvoyOWhDj6SzymbiHqHKFUZekucBnK4IH+U6
         gzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9o0jJdAUCZkunVukdFNl8xKZYDuj6B8MgEEVKNvohwA=;
        b=yeXXC4GNPXZp526Bl/q349upDxkesDJJynQzm6UijQ0Ew9xavSmdufvzkVZWnlVSI7
         vcEXV9vjWEYIjuH4ldn8h3nTReTE6YmG0UbmIFBEA3o4TpZxsHYw2RbqIkY9DQPV4XbF
         irwLBkG8KsWwilDNXOc/ox1XZ5jEiJF/DHUu2NToIIR5MAStHTiqs2otUIKquYesPbyl
         06UmW2DBQrOhZvV8Gvn5dy+7B0p4iw4rw5bcX7umlaRDZO+QZxbM8g7foyGLlHwdFpaO
         kOaq7E9JriDDPh85Uk4lX8kpyWNtHacmpom2EdcJ3XAfSpZrbBOjHQBCAapFDedr9jp9
         hUIw==
X-Gm-Message-State: AOAM531NAqxW0i2E01MOAzZQyHCMeBVffDEIZc1mnJ0EeosETuNHbKzS
        zVIUmGp0B/t4j1k2C3QmLnPtqHTS3OTyDGdU5XfwOe3w
X-Google-Smtp-Source: ABdhPJzO0rTpSZklvZ9vA7mszDSRYp/tMywSuMFhlySteiYehuquGBgv9FqQ/sWzIOfev61kHyzoBMVetGiZZPkX6eM=
X-Received: by 2002:ab0:6616:: with SMTP id r22mr2744665uam.129.1632955481472;
 Wed, 29 Sep 2021 15:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210929210049.35597-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210929210049.35597-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:44:30 -0700
Message-ID: <CABBYNZLtBmnPAxNoBddy=z1ZFu0nCjsM0dE7b7wkAZmrjC_dUg@mail.gmail.com>
Subject: Re: [BlueZ PATCH] tools/mgmt-tester: Fix Read Experiemental Feature
 test case
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Sep 29, 2021 at 2:34 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> The quality report feature is supported only if the device support it.
> Current emulator/btdev doesn't support it yet.
>
> This patch updates the supported experimental feature list to align with
> the current btdev implementation.
> ---
>  tools/mgmt-tester.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 9c5b26c9a..e62c4dcdc 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -9334,7 +9334,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
>  };
>
>  static const uint8_t read_exp_feat_param_success[] = {
> -       0x04, 0x00,                             /* Feature Count */
> +       0x03, 0x00,                             /* Feature Count */
>         0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,     /* UUID - Simultaneous */
>         0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,     /* Central Peripheral */
>         0xb5, 0x10, 0x1b, 0x67,
> @@ -9343,14 +9343,10 @@ static const uint8_t read_exp_feat_param_success[] = {
>         0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
>         0x48, 0xa1, 0xc0, 0x15,
>         0x02, 0x00, 0x00, 0x00,                 /* Flags */
> -       0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a,     /* UUID - Quality Report */
> -       0x70, 0x93, 0x2d, 0x49, 0x06, 0x75,
> -       0xbc, 0x59, 0x08, 0x33,
> -       0x00, 0x00, 0x00, 0x00,                 /* Flags */
>         0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,     /* UUID - Codec Offload */
>         0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
>         0xce, 0x5a, 0x69, 0xa6,
> -       0x01, 0x00, 0x00, 0x00                  /* Flags */
> +       0x00, 0x00, 0x00, 0x00                  /* Flags */
>  };
>
>  static const struct generic_data read_exp_feat_success = {
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
