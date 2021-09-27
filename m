Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B15C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1587960F44
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhI0RwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbhI0Rvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 13:51:54 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA7C061769
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 10:45:47 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id o204so7281695vko.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJXXdFQHlxtsw2JhEE7ByqgYExAxkcRQj+gmmzJWWG8=;
        b=ZUhweIcERQ4VlH/V7SheG9xLscd5oU7sR+5mal40p9qigaSFT1WS/OKJR4NT0b0Ybk
         FyxEfp9YAaoeZImsOr/ELli8dP/IpHyB4WLjq0dNvRHOxX8BH1Qx/ctAIAQfRzxrj9B0
         MXpQQPDIBhfHx2EgXvQvAbWid69B40SGDBaYQJXHlhrKRt3taE9ema2m5Rp95Ik2F/Vn
         xHIShgGi+OYCVhUa/V63G0OddlfWcEXI25aHUtw3kSJEOl4GEsv9WidbzmO7Jz6pQ9QY
         Mv8dQqb7FhaYY8Fejs45H+nB7CJwZ6wjVc/eidof7Ybip5ZyHf7hUfNXJDZdFvLg7Wv7
         /MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJXXdFQHlxtsw2JhEE7ByqgYExAxkcRQj+gmmzJWWG8=;
        b=IBRs9NgKR3n3lAO5nCqHUP/77xGL2QbibjBJh9nNT+Mt03TQBV43bjM51RxwMZhIp9
         H0gV8oz7fCqH3IKhKjLNke1XNDVM/GxyI5yNbyYUuEMBlvGTP+ciVLi38FGap92QtjQN
         DTin6Pqvgg1S+jmTC3Zr40Pt98NjemtTdDHVDrsFcalTI5Zo82P3fx0KjDmaR7Xa7+3R
         VDY3RqNtlQR64pLprj1w2mc9XxLtf5wXVczRzjlwtymEKEVTzaF6BJCNBoKFSg7XYaNW
         MTwZjNEvQ4zHAygCOx4diqRfs0nPyNGCxTqoyEX0/EoReh+G8TXqwwAONR8Nz4Y9hlR8
         pj+w==
X-Gm-Message-State: AOAM53149hJbSv7W5YIDuRhvTCcJnSWffR4m2P15ipowouR1kNck2zIZ
        U9DWPWkXecsDMCiWpxWtCU0re2GcaroDioUONWpQ78kQ
X-Google-Smtp-Source: ABdhPJxon8u2Xxl2KvhlhO4I6kAa3Y5ipgEqf8VxtMfV1fQ0T+Ec7O2nyYqCRWHLGwzjeMcqXjZPkEPtuUEMqNSOh6k=
X-Received: by 2002:a1f:a9c4:: with SMTP id s187mr1383479vke.9.1632764745976;
 Mon, 27 Sep 2021 10:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210926170039.49865-2-martinez.dagan@gmail.com> <6150b012.1c69fb81.98232.f6ef@mx.google.com>
In-Reply-To: <6150b012.1c69fb81.98232.f6ef@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Sep 2021 10:45:35 -0700
Message-ID: <CABBYNZKiUs9MLe8QKjYa4OyvMaCj0iXvhXyQW16XzNktFjBGVw@mail.gmail.com>
Subject: Re: gatt: remove superfluous extended properties
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     martinez.dagan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dagan,

On Sun, Sep 26, 2021 at 11:00 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553055
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.45 seconds
> GitLint                       PASS      0.29 seconds
> Prep - Setup ELL              PASS      50.88 seconds
> Build - Prep                  PASS      0.24 seconds
> Build - Configure             PASS      9.15 seconds
> Build - Make                  PASS      219.00 seconds
> Make Check                    PASS      9.85 seconds
> Make Distcheck                PASS      256.92 seconds
> Build w/ext ELL - Configure   PASS      8.96 seconds
> Build w/ext ELL - Make        PASS      207.23 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
