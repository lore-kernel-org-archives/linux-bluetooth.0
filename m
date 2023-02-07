Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2133C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBGBIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBGBIn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:08:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16D34C0C
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:08:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so20306870lfb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8czxM+Pj0f7U2+T0+rlFZgITvS2BDSW9k6NdTxpbNHU=;
        b=l6IEytDy3f90N7f5/eSKFePPWBEF3jGvx7/INRNuxYTAA0/GtUTwH8Fw+21rcatIW2
         nAg76wZX4StcikwcfDiJpGiF1oRy7TTlNuHek9u2gFBKD4hv0nvCOLF+ARfvD448PJ+6
         UA5Nq+SAkAGdV1q5ZaisBhQPZoIG+9WZtK2axVMFSALNSk0oJbhzeHVz9n9oqpeq9lqC
         rJcz+3zqrpV9A+1Tg6Tpps/OP9XvLmZr1HAsdlZoo8GUpvSWVByNajGd2o7cGaE5SuMM
         muvHw2wqdaEFyLpU2aAuLqNb0LtckSDNHgueEl83O/QvHdETQyD2Zr+klLT4zDrDil1A
         vgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8czxM+Pj0f7U2+T0+rlFZgITvS2BDSW9k6NdTxpbNHU=;
        b=b8i4RBsBsSEaytudaNd6ih+e6e1ANvMjzXRCEQBrkLdFvK8OPBj8S0l9PcIucCaVcn
         OuhDiGtOnRfenogdyOB1KJ52fATA9bXa4u0PfK5WEZwOQdJD+tCu7uMVGsY/Z68bAiUl
         WEx8CxDAdTvVmiZStgs5U2quTYp+ka2lh6RUdfkmPU+UnpNrUQyJiOkg46x5z6H0mW4y
         oVR6C5XvJqTFS91uOftwxbcGo8Z6eBNd5XyvVPeReAil2vihKXsK/XSezxIwcpI0VG0e
         oGO8rtsqjIItA9lJuQ6mUBLkI0E3q2nb7w8PAvaJ5CC7R/jeLYmeHfh4iQb3/ePuNN3G
         W6AQ==
X-Gm-Message-State: AO0yUKWOyepYWcE9PgxM9tE8lKI1ceT7MezC20JKNSiqzPV2gT5RFsWb
        PvA5NqPXDKvEsYyG3whI5fDSO+iTrCwSGlE7awI=
X-Google-Smtp-Source: AK7set99N3EGi7Cz4hKeAYydeduzsM6b0TIiAbb6aeojVKyyg7pUdVOuZV23POXqsweNu9SQevulmOFLPUq+OMXOibo=
X-Received: by 2002:a05:6512:374d:b0:4b5:7d38:a636 with SMTP id
 a13-20020a056512374d00b004b57d38a636mr153358lfs.109.1675732120022; Mon, 06
 Feb 2023 17:08:40 -0800 (PST)
MIME-Version: 1.0
References: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:08:28 -0800
Message-ID: <CABBYNZLWt6y7beYF8-62G018LY+8yHSOhQAdvVKFbWn1YDzKQQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] doc: add MGMT setting for CIS features, remove
 Quality Report
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 10:43 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add definitions for new MGMT Controller Information settings bits,
> indicating adapter Connected Isochronous Stream - Central/Peripheral
> feature support.
>
> The Set Quality Report command was removed in
> commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
> but the settings bit was not removed. It's also not implemented on
> kernel side, so remove it now.

Let's split this into 2 patches, one removing Quality Report, since it
was never implemented, and then another including the new flags.

> ---
>
> Notes:
>     Was the quality report setting bit reserved on purpose?
>
>     From the commit log it looks like it was forgotten to remove from the
>     docs, but this is not clear.
>
>  doc/mgmt-api.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 90d612ed8..58395dc90 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -332,7 +332,8 @@ Read Controller Information Command
>                 15      Static Address
>                 16      PHY Configuration
>                 17      Wideband Speech
> -               18      Quality Report
> +               18      Connected Isochronous Stream - Central
> +               19      Connected Isochronous Stream - Peripheral
>
>         This command generates a Command Complete event on success or
>         a Command Status event on failure.
> @@ -2925,7 +2926,8 @@ Read Extended Controller Information Command
>                 15      Static Address
>                 16      PHY Configuration
>                 17      Wideband Speech
> -               18      Quality Report
> +               18      Connected Isochronous Stream - Central
> +               19      Connected Isochronous Stream - Peripheral
>
>         The EIR_Data field contains information about class of device,
>         local name and other values. Not all of them might be present. For
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
