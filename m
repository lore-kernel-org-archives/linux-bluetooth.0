Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D4C352BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBAE2051A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvy0kb3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgDPOyW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441812AbgDPN45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FEC061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 06:56:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so5699620lfc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVOcOOY0ED2cudmSxVcLHS8BeMKXbIr9MeNpLsVha08=;
        b=qvy0kb3DcoGhHr/JXoP51oKShaktF4vRHXHL+F0dilulnsgBV9IFqapRb0Ir6dzknx
         9xnsRiXaoYpErFCSW5TSwPJPJPj4cMkrbbzqS3HO7C+B8YAj6Nzk40zOnEJSL01W4coW
         I5VSFM7W5JRSuconZuovPAPVxvnCKhIDMKQQqFXVSqy+RCJKC2ctmTJyz+aYM8wvWP6S
         Ej+ll/ZUGY1BT5iK66o1jQK+bB8x/JYzPDh6+D399zc4JMmRgd7xjiQxxIhCL3/U42rT
         O+5oSt4jPLN2Yk8epFM0UktK53c0hBlN1qEHM2z6W7GJrOtSIKoOx2trSxDiN43E/AQP
         5DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVOcOOY0ED2cudmSxVcLHS8BeMKXbIr9MeNpLsVha08=;
        b=gdFwAZiuRoEP7RFxz6asmQ9ZlcbN9ll8SgTrN+vJp6WDtYXiDPWd1ml/4pEaZcGKKt
         JZPWNuXtITYydDVstRpYXmYG1JgcbduOm7rD5F73flg5bFz6+qWSMYKY8mE+Gt9uNyVc
         H7Np3ihSZHMWlSWUogRxedTjES2p2p0WA36jY55znD02Mc1EVQU0HGMA81EzkyBkN1dc
         8yDXg8XkTfD4Dr8WMOeTg1zDfA30h9q4Q60Fg57MeOgzbgWeXvMBuTOyae6Aw9GiYbfG
         e/tLI0uqNqzJ/HD6U4eHIZWCEh1f9T75H6gbu002ljL6u3JvIXzN6J7AF8X4OzABDNLv
         p9kA==
X-Gm-Message-State: AGi0PuY0Y4GM2rUxLNg4OLGj99wH2hh8982GBTD5drmO9tFs8uxunL4Y
        /md6CwvdkVNSJeAWA56Dm10stRMeNMwyo5loucAhtg==
X-Google-Smtp-Source: APiQypKDZ83rI0mOlPjnmio36gHXdLD/ns4FU4TuNrq0yBI7kR0dgxxQ5SC2fsp4u+XK4HiGzOiiCu94CrkqyUelclM=
X-Received: by 2002:a19:1c3:: with SMTP id 186mr6090808lfb.191.1587045414765;
 Thu, 16 Apr 2020 06:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org>
In-Reply-To: <20200403153331.101846-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 16 Apr 2020 09:56:43 -0400
Message-ID: <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendly ping on this series.


On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds an adapter Api to report the controller's
> widebandspeech enabled state.
>
> ---
>
>  doc/adapter-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index acae032d9..d8865e795 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -326,3 +326,11 @@ Properties string Address [readonly]
>
>                         Local Device ID information in modalias format
>                         used by the kernel and udev.
> +
> +               boolean WidebandSpeechEnabled [readonly]
> +
> +                       Returns true if the adapter's wideband speech feature is
> +                       supported and enabled.
> +
> +
> +
> --
> 2.26.0.292.g33ef6b2f38-goog
>
