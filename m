Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058CC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBGBOv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBGBOu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:14:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16639752
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:14:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y19so13963144ljq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zVFc0gtX0DVia7k+DIEh8rTRm+7+yVjP/SXuAy64PA=;
        b=oRwHYVneo76D7Wm3qZob062Q5vgd5RtaOPKqJ3LcDI+LLa/N5nNOcrAiBs7jxmmUfF
         4BaNZJZPFy6Msi3BC55oqi+zY24OrFRWW4iHVGkIF0jLCYFYR97eldAfPne9FaHmK5n5
         bzrc/S07zvNTtQlLcEy8ujL1q6SzWokX/EX9md/8U+4WITO3n4fjr08EXuSly/vcfFjU
         I4/caTCxCQ6RhGNYoKumwbBeuKt00Lp/TAerSLJke5ZvYzzTGbYKZZw8bUDfro/bNBlB
         bXOcvFCyZO8nKxVvRCtawvqr/ia1RPhj14w4ctKPyO/6FfzSZYa82QG2+HPYgDesS8MW
         wUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zVFc0gtX0DVia7k+DIEh8rTRm+7+yVjP/SXuAy64PA=;
        b=O9fzF7vQrA4tbPlLs7tYC2DcSqtz28zFR6PkcL+3l8iqFbLjYBeXHamyc6XhwlvD+C
         qkTQY0yZb+75u9AqK2nUl5jhwWUGog9Yo1T4yE5DxHn99q/xMUdGUzPAB9vhTQqh2sAF
         E3irHm0WVL/+2Goq8vZaVGA5amMBSg4hdKEYX5WpikcPNEZ9LboTE3OefF2ZzpZu6FDx
         y7rQppa/BNa9yGeKZTjM57Kr31thBDXuYEHaKbHvwKC8bzWiJVMq3WvGsXTp7zHonZ+P
         hmIDA+c6dcOAvH2jSa/IEV/u1Ad75dYs/IFlmeaJe2+LwJcGTh09Y84YOWqNRW2WE9zh
         Unxg==
X-Gm-Message-State: AO0yUKXnSf4btdJ6SmDn3MNHiSM2rI4IuZlCv3YPSDZiBzFYKy1f0i+1
        sggBXcRj8Jd56bGXPxumZ6wj+HlwFGd/8zK42nCEObin
X-Google-Smtp-Source: AK7set9cVAmxp4j6RAKH40LyZRVbYyBMwKuwgVx1sunOYDHEERM4DkgmUH/w1vENoUtaQksEYCXibR/nQE/D8/mvO1c=
X-Received: by 2002:a05:651c:2325:b0:290:6ee9:f774 with SMTP id
 bi37-20020a05651c232500b002906ee9f774mr155552ljb.43.1675732488107; Mon, 06
 Feb 2023 17:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20230127205205.20235-1-pav@iki.fi> <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <b98624eb045141f941c3855631e266c93203bf91.1675103676.git.pav@iki.fi>
In-Reply-To: <b98624eb045141f941c3855631e266c93203bf91.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:14:36 -0800
Message-ID: <CABBYNZ+gUW-wQ1_UPBFmzhDCDzOi-7yjmuLenHg8pHOJa839ew@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/8] tools/btmgmt: add names for MGMT setting bits
 for CIS feature support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 10:50 AM Pauli Virtanen <pav@iki.fi> wrote:

Add the btmgmt output as a description showing the result of these changes.

> ---
>  tools/btmgmt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 29f86091f..323c26712 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -353,6 +353,8 @@ static const char *settings_str[] = {
>                                 "static-addr",
>                                 "phy-configuration",
>                                 "wide-band-speech",
> +                               "cis-central",
> +                               "cis-peripheral",
>  };
>
>  static const char *settings2str(uint32_t settings)
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
