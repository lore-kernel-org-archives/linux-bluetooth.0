Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B615C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 18:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhLISsv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLISsu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 13:48:50 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF524C061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 10:45:16 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id i6so12513915uae.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz/wUmfdPxoiXFl7AIgjxwb3RJmAgmMfPeLpMSLUYvM=;
        b=ZkpjPfYnit20KXtyBt5JbvystreZ/+uAjSRf71sMPSkuZIQ79PDfLLYoxOkliJedXp
         rmzK9iGaU3njg6cPHn77UP+RQB9Jzo3qXcF9hXCO0mpI17+OiRP21DT8EzB/qgJPoLn+
         BgxVcHKFlsa40eS1Uy0HdS4fGoB+58knNAPGxriT2QZj4HoB/0Hrzb1Klo3wLpEmU8T1
         mtHqeAYFy6bepcQt9ahS942AvEW2njKZxmrNtO+661uooOs/EYHTaTYdtY7Yqzr9fcub
         BvC+2QL7Fh7h745UHtMgu0xE/FAmFJPmNQdRX/1k2MjCAaAzZ/lWy8TZixtqICP3kxSz
         G3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz/wUmfdPxoiXFl7AIgjxwb3RJmAgmMfPeLpMSLUYvM=;
        b=UlvHvTJB5LuS0lnK2U31asgocZvrlgax1D8ZoX7RPaz3r9dlUhZdOzlg2n+KdPfSdR
         5bzFniBGTHP+H6An2KYg3zGBKjkoCgfwIIYMuDrRXPnYxX5Zj1NMvD7CE3yJZxuy5jse
         CdX6Z1kDbcWM5DUZpw7eKUFu/e6Pt9Qz9OU9N058ZQTkMrdXImgv91VII13hX3YXD7uR
         Y4vIH46KCr250GWrZZP/JES3zUxkXHUhFhGY79Yh+/9HjG3VjxYL55D1j9XPrXiWFkhV
         KCDEZgAaAZxf8CdDWRGxXBXJsjLjAJtlZRZXbhS4+xerWX7oD6174JEfhceLLiucV4Vi
         UusA==
X-Gm-Message-State: AOAM533hd80/QsIvDkNlWgJaHwMLttf2XU/zzEaJu5Yn/9dcEi+pWn3k
        L671FqfCsOWQmB4r564343YlVfXIvXwoDjz/U3o=
X-Google-Smtp-Source: ABdhPJwk/fgGGykIl03HzMz9YpppxC8A635NqPGjWl33KVVNermybtHcIDcjpTGdM8ZuRjykFUdB9BaDu88daiklmBI=
X-Received: by 2002:a67:3093:: with SMTP id w141mr9837138vsw.24.1639075515799;
 Thu, 09 Dec 2021 10:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20211208223923.519664-1-hj.tedd.an@gmail.com>
In-Reply-To: <20211208223923.519664-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Dec 2021 10:45:05 -0800
Message-ID: <CABBYNZJQsn5JVVzR4Uy3AMmkZyhLbXqS_rY=H9-OZFHOeAPqoA@mail.gmail.com>
Subject: Re: [BlueZ V2 PATCH 0/5] Replace random number generation function
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Dec 8, 2021 at 5:29 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> The Coverity scan reported (CWE-676):
>   rand() should not be used for security-related applications, because
>   linear congruential algorithms are too easy to break.
>
> This series of patch replaces the standard random number generation
> function, rand(), to getrandom() syscall, which provides more secure
> random number than the standard rand() function.
>
> Tedd Ho-Jeong An (5):
>   emulator: Replace random number generation function
>   peripheral: Replace random number generation function
>   tools/btgatt-server: Replace random number generation function
>   plugins: Replace random number generation function
>   profiles/health: Replace random number generation function
>
>  emulator/le.c          | 11 +++++++++--
>  emulator/phy.c         | 10 ++++++++--
>  peripheral/main.c      | 11 ++++++-----
>  plugins/autopair.c     |  8 +++++++-
>  profiles/health/hdp.c  | 11 +++++++----
>  profiles/health/mcap.c | 17 +++++++++++++++--
>  tools/btgatt-server.c  |  7 ++++++-
>  7 files changed, 58 insertions(+), 17 deletions(-)
>
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
