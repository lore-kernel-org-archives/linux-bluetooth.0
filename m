Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D75C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 00:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798C0611C5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 00:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDAmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKDAmP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 20:42:15 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2430C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 17:39:37 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id u130so2194620vku.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6HVrCw6dm0Z9VC+IOSnNhT3ObYSAO1DcqvGIg7D3+Q8=;
        b=p6nS9KKfuByq8h2ltxdNSU4TMkXfPVc1yCGf9rShZtgd6D10hqyJmodg5wiyJqY8w3
         E9W+GANYd047vX+ZlryJXPmnwNgDxu0aPm2++SUD1H3se49agRxNj0tfQMi5lCjrFPrw
         iClRyu/6b9HrkDvEXsgNadmLzfnTVXxZ3Sv0i+S+16X6VW90aj5JwNuOuFH/0mhtO+yq
         ln5zWh7Mj++/JYkBqp2tTv673xUH7/07D3AcW6sf+JEKFcy+JkPN1d0nZUjzgCsrcpjA
         wa6y8EWQ1VieQx5RnAADo2h0SHSkK5HLSQKKpTkBfgJZY7MJOSnSPhCe0pxKe6Gg6XjU
         5cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6HVrCw6dm0Z9VC+IOSnNhT3ObYSAO1DcqvGIg7D3+Q8=;
        b=fUYpKPJn5fm/iPBF9eFAvOFrT9dNWaZfRWHEDvQHvdtA/I6SRP//c7qTTO9+gv/5ua
         7o6wYrDtknOnlAdJBI/Z4ve75bHgivWUf9yFTBARn1TFIreIWeWtU+iCtAjbVL0icHYy
         hiN1FHyyRXaUsjyNnlefLs1rLVBaNPKeM8hmfZyeZl8XkEzcK3ckoLdBP5BTVmfvN+JN
         zoI2Nn9gzxNhzY0o9As3ko7VrkSzVEY8rWCFFYFIl4m19EEQ7E9A9xtS7fiZKbhHnMlJ
         UEJwdmqAF9ogwhv8OFrxwfYa1Tgtcibkz60oB6Bax7gHVOGwefVo2rw7UuTXlp2JDI91
         qYow==
X-Gm-Message-State: AOAM532Oopru1ZFEtSf2COtOGGqgdEyYzA9suZ7GP3sjMOpGNMftSYdR
        xXZyFbaW1bPuHywjXIZTE202FCuQlELtydm22bNMZWP4
X-Google-Smtp-Source: ABdhPJxYbm59vpqyrVLo3f2QtbG9twngjs3/EJNeKYHU6ql1pdbnOQigUcIzoS5zzZ+cU9TQpwFOeTf1Ec/rdgGI62k=
X-Received: by 2002:a05:6122:1793:: with SMTP id o19mr15991198vkf.23.1635986376858;
 Wed, 03 Nov 2021 17:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211101134918.69565-2-jajcus@jajcus.net> <617ffb3e.1c69fb81.5a7dc.15f7@mx.google.com>
In-Reply-To: <617ffb3e.1c69fb81.5a7dc.15f7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Nov 2021 17:39:26 -0700
Message-ID: <CABBYNZJwfafpHSoBqbg851T3w0wb7yZP+8gk=oziXciNLn+7fw@mail.gmail.com>
Subject: Re: Free ALSA seq resources in midi_device_remove()
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Jacek Konieczny <jajcus@jajcus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jacek,

On Mon, Nov 1, 2021 at 7:36 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573565
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.43 seconds
> GitLint                       PASS      0.89 seconds
> Prep - Setup ELL              PASS      46.37 seconds
> Build - Prep                  PASS      0.50 seconds
> Build - Configure             PASS      8.57 seconds
> Build - Make                  PASS      202.34 seconds
> Make Check                    PASS      9.49 seconds
> Make Distcheck                PASS      242.98 seconds
> Build w/ext ELL - Configure   PASS      8.72 seconds
> Build w/ext ELL - Make        PASS      191.05 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
