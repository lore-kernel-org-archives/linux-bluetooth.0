Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BC2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiBRVXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiBRVXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:23:09 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798C36B52
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:22:52 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2d6923bca1aso70729777b3.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b1apJdnw8Su0Hh8rlTnY++htYdlMi7t2JOGG5QlPGjU=;
        b=IghPKVYUPorQivH5gRQ3Msh407szGgyr8lmnsEHOH8ciHD9kO9bNAvOfspj5EckUdA
         zMrHWCFOi746x4xcHeTYOZIXAHiEZom6U0SE48gdbuOuZgeFb7LQcu2LvWbRZ8DKvjA9
         ZFsYhXOZ4Uku7zM2KbcgMIePNrwaRexBv9v8E87EUlTp/OL7ZIwu+J/xvT2BeWTUHE/D
         DWmrTFIJtltozOk7915TmpsfQ1TcumPmo+HER1jZeLyb7hpODMyAXNVlNOHdQlkAV0DP
         vagkrTqowSnY40FQoxt1hwmvh17nYdk04YTHpU83LorpmmIvmgm3N4fpGa1yoDlL5Lx7
         QlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b1apJdnw8Su0Hh8rlTnY++htYdlMi7t2JOGG5QlPGjU=;
        b=p8h2buga8fMovnIOytPQWErlYlYg2XWQDKln1fgp5Tv0cMUcrdtwbGBtNdsen3S0oL
         NWOS2BAHcQnrFVkftItC/bshIFLKk4m3e6p2y3obSaqxgOG8jommq3Lc3VDgi9S4A6QU
         fy2FdZnuJZsaHsOdszTL3E57oKSjhOcUaDQGz8c0UN6fNWditfUnHUG2gFoKh/MMm/8I
         CT8ZLFPUPy03VZGliSo3KFdTl2To+GkkhlkabfmETeFElZkyiSwti8GQsBorNbtBfh3N
         mPselB/ynnrcbd2hDojp+y2w9oB/yRTnB1ZHySjm4g66dUzgqaud7sAt4wTuOdAcRXGn
         Iytw==
X-Gm-Message-State: AOAM533w1TWd2hLzWSN8sDHc7IiJwiax86hZ0QkzB/Cc0b7/364nfK4f
        EouJJd6gZki5fk2zkkDDd7hmmRWZUzqlWMJ5wwMr7fA7
X-Google-Smtp-Source: ABdhPJxqBbAfnw0yoe6aU/0AAzdh2JNQimhUjXXiB1FBXeyEQhWwlqBDa4aJ+YSIeJH1fxAkq+tkLRnl3xkOF95qUD8=
X-Received: by 2002:a81:158:0:b0:2d0:8b7f:a539 with SMTP id
 85-20020a810158000000b002d08b7fa539mr9625983ywb.233.1645219371313; Fri, 18
 Feb 2022 13:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20220218021605.3126182-1-luiz.dentz@gmail.com> <620f1210.1c69fb81.e1488.8904@mx.google.com>
In-Reply-To: <620f1210.1c69fb81.e1488.8904@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Feb 2022 13:22:40 -0800
Message-ID: <CABBYNZLb8Azh0a6xEY06LR9bBzRpQ84Pjoo3xcn5fAto_tDbnQ@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: Fix parsing of mode options
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Feb 17, 2022 at 7:27 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615612
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.55 seconds
> GitLint                       PASS      0.99 seconds
> Prep - Setup ELL              PASS      52.63 seconds
> Build - Prep                  PASS      0.81 seconds
> Build - Configure             PASS      10.55 seconds
> Build - Make                  PASS      1511.36 seconds
> Make Check                    PASS      12.99 seconds
> Make Check w/Valgrind         PASS      545.06 seconds
> Make Distcheck                PASS      281.59 seconds
> Build w/ext ELL - Configure   PASS      10.64 seconds
> Build w/ext ELL - Make        PASS      1467.66 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.
-- 
Luiz Augusto von Dentz
