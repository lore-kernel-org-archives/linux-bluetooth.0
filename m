Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3238DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 02:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhLHCyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhLHCyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 21:54:12 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CAC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 18:50:41 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id r15so2264207uao.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 18:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwNOVbxCtGp1DMHgJ/JcT9G0XJEhcJkEC/iqCagPzzo=;
        b=bI0YUl4IytUZ1b/jndJQaYgQ3k9IPOiUoSBe4QviOmSKVT1MSmUfRIe8dvb3fqaPmy
         KYflh+E8gD+3Xn09ow3mbuK4UUETjgGSOeCXmPta2upOujpOpvYpeNMP4rMX5mQ2dosU
         ztVRXtrnBf8peJBdewm0pI9KIj9kj0T79n/DNFuwoW5Jp61zbiIcvxF2V4igTksYd1jE
         SV0X4rf7KMENIoJ/PN/7VTyRwyjOYkdD5y1zPJ0yFTR9aoDrGgq1iAgZyVT4c3s5I++L
         AL4jR4z0W6v16X6pt/8BoE+B2MUejnH9wMCnyX3l0UxoRKSS2qbGyo7FN7/nxKwMiUn8
         kpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwNOVbxCtGp1DMHgJ/JcT9G0XJEhcJkEC/iqCagPzzo=;
        b=s3YMedDjIpO6op1f/hKXEecGXATXIltfF0zuvHJDIOaRPAVS2LHV8keeDoWcDWNCvN
         FKTuElYrBkJu2ZZFi2HHl0S9wtj7Rs88w0POxEJq5cd9ZjvJIuq5bvrD1wPGk/OGa2e/
         CWms8myE91UD2i6b0+APBw7XjhABV1DUDYyrKTkKZLFpB3fv42n65IGEK8g05/J7pR50
         BT3wDkxSWoBiSWUoNDnZ20LgjfResCGgGeMtowE+CzCQeW/2XTp23g6SAxB7xfgT7eRe
         hEUhSl0XVl8ye+Fo//naXYzECQfkLSSUZ1DQaAK3PSFog+fH8T3IiWPnhn0r5SDAenRD
         BrYg==
X-Gm-Message-State: AOAM530LXghdB5Pso3g0hLbMRHV2LEXuzx3EujMG+v4CrMqe5wvJGwIF
        3SxB1adXfbIc1LnV0vMom5KQED3bQVGu2aEzxX4W860u
X-Google-Smtp-Source: ABdhPJwj8aI7Dhqgx0s9FEvo36mxhgIp9T63miepWTVfbaRCB94h9NlU5tR//kiSGgSQkwuEut9NeRVncO1U+yrdU2E=
X-Received: by 2002:a67:e0d6:: with SMTP id m22mr50718403vsl.15.1638931840324;
 Tue, 07 Dec 2021 18:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20211206234001.4248-1-ulissesaraujocosta@gmail.com> <61aea347.1c69fb81.bfa99.9f2a@mx.google.com>
In-Reply-To: <61aea347.1c69fb81.bfa99.9f2a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Dec 2021 18:50:29 -0800
Message-ID: <CABBYNZJc4JNrS5Xjn=96Sbn1auHHx_04NdKBRbaxgXmiYOvSmA@mail.gmail.com>
Subject: Re: [BlueZ] client/gatt: Fix property_change in WriteValue for desc
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Ulisses_Ara=C3=BAjo_Costa?= 
        <ulissesaraujocosta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ulisses,

On Mon, Dec 6, 2021 at 10:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=591213
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.28 seconds
> GitLint                       PASS      0.86 seconds
> Prep - Setup ELL              PASS      42.63 seconds
> Build - Prep                  PASS      0.43 seconds
> Build - Configure             PASS      8.04 seconds
> Build - Make                  PASS      183.51 seconds
> Make Check                    PASS      9.36 seconds
> Make Distcheck                PASS      218.76 seconds
> Build w/ext ELL - Configure   PASS      8.12 seconds
> Build w/ext ELL - Make        PASS      172.56 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
