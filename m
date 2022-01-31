Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D1BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jan 2022 18:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357310AbiAaSpZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355479AbiAaSpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jan 2022 13:45:24 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F05C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 10:45:24 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v186so43505451ybg.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzeDWHlX+CPHOExCnEpzJJzuUo/zUOt4ryp7uO/ZF8w=;
        b=WecwhA+EFq7PB+vfH1+lA0xCnGnnuvlfpBg6p4+uFWnbRSTjn6l4V0eF6y9tjHOA0Y
         ieC9EshBtSR7/sBpCWXZK+sYeSp1a24JJZD6SaJPcift7pN4zhX23c6R+JRWv+tE9gPn
         3yB99eWv9hSixMrDxjGzXCkQVg0YLq6A+qF4np3iAj84ZpKgjTwjwefuP5PaEn3EusO1
         0Bez4uaImhPj+FksAS7RiNZg74F1A0yRyTLo/RsBjdVvCP2YTJfltD4vou2eowKs+c0u
         tmMIn7IvctfzuDzmpc4VmT6R1mHkiB6PK5T2jjC4Yov3OVVel5D8IeVDbnQDFNUXPbTJ
         NNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzeDWHlX+CPHOExCnEpzJJzuUo/zUOt4ryp7uO/ZF8w=;
        b=YjBlaSAN7SVaKDgNdE2efd8LHUSMeKsSByhetsu916whu5Hzt1T2lsuFStUwBsqyMl
         j2Rd7AA6V0H1C830jb8IttAKM++hy6PpN4vJhOR88aa8ohUB9eN6CSPFLZNrcjid4ayx
         bY9ogg2kIBHaQE6+82slDMc2mBTAa08xt1hDHatOEKH2cmzMUshBRaKYvrIznJbK4CVd
         PZS9I/ckDluz5dFQtVcUjkwBx+W/NZNhdsk+fNvC3mJt4EwgKECw5fVzZRNMvXkYmB1C
         FUyz09cAet5jgby0LWsPqtVZK3IgN5b7rjh9cRja/q9Hqy8yqhLkAxdzon26NJEo/wM6
         LXbQ==
X-Gm-Message-State: AOAM533NQ9DA1ZeOFw8H82jOea8WjjUiTcq9l/0MsFmYjGXa/16uSwpK
        6HGzVCcDFC6+bJeN7WNLLFN7ecnOe+xdYDkTBvH7U4lu/uc=
X-Google-Smtp-Source: ABdhPJwKsZT+ckX/SBR/5LgkteJCCSosuHoTuHN9vP2KQUZq0s7xhChqwIGMfoUIzFjddvYwCbSAr4B0W2yjTSBrgr4=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr31378308ybt.351.1643654723548;
 Mon, 31 Jan 2022 10:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20220126113638.1706785-1-hadess@hadess.net> <61f15596.1c69fb81.ba6f2.d20a@mx.google.com>
In-Reply-To: <61f15596.1c69fb81.ba6f2.d20a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Jan 2022 10:45:12 -0800
Message-ID: <CABBYNZLest04xf3cuAJrfMmFpA48h-+qX2BPvPuUs881ugOM3g@mail.gmail.com>
Subject: Re: [1/4] build: Always define confdir and statedir
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Jan 26, 2022 at 1:28 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608628
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      5.68 seconds
> GitLint                       PASS      3.84 seconds
> Prep - Setup ELL              PASS      41.84 seconds
> Build - Prep                  PASS      0.71 seconds
> Build - Configure             PASS      8.38 seconds
> Build - Make                  PASS      1292.67 seconds
> Make Check                    PASS      11.33 seconds
> Make Check w/Valgrind         PASS      448.95 seconds
> Make Distcheck                PASS      231.67 seconds
> Build w/ext ELL - Configure   PASS      8.74 seconds
> Build w/ext ELL - Make        PASS      1305.94 seconds
> Incremental Build with patchesPASS      5303.63 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
