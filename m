Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 22:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiAGWmy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWmy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 17:42:54 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2387FC061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 14:42:54 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w184so20777635ybg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v2xlVQ+fNOqalRxeRYOAMiXDkEo0Uc1EwQWTxKyTXU8=;
        b=U4jYoZaJkDG8SHnSwyrOpY6UlRqsQcb4UDvVp4W04eXSMoSZK4HcGYPutVfjwJY/PR
         zycIHO/he3yjLN980+YU00cBsj7I+/oaCLdxTUog14Y5zwt4lYIyGMQsjMY1iu/Vfh6T
         zbaYWYqRx/dgETngVDf3Sp2hJFVGKkPekm8liidXaRHBx9WcS9DsOZdJg8mhex9spLZp
         K3vsWsnFjaWy8R6bGjgH/VUqBY1dmg46hgUkxZvue+Tfj20pIaNHbRTp5y+zK22hAp2K
         E2sRrzMvABg52MYnPmlAlJRWLS39zpL8UAsU9E0vHYiI72ClFogfOVk1cS17hqOxBEvs
         bFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v2xlVQ+fNOqalRxeRYOAMiXDkEo0Uc1EwQWTxKyTXU8=;
        b=5TRRFN0O1vsRKtZ/AQMMzezmpibhBEw4aea5iGjP+Xltj8V5dcG14WISUU6qzzvkiR
         RISOrpmdn7cUIhwWYugexxzXGIFnT+2NuXU0Od17V7EAxXQVUMSUoTjhEJuQzB/OaELB
         Y0KliMGV4feY06YxyBt89NnI+81sZRVH+WV7VjzqsJeIOCOiBBG9YOawFrGEzxCdYLLp
         qOWnx9nbGUrj20B4PQlz5h1TRSLbUghJD7OmeW5r7t8NGmr5EwOtaExlhk8kGJotKvA4
         wbweOX+7AUHB+N8O/W2gyGfWHiufAZ+0d9Zu+viG5vs/yRfqMZ5mkh5wPv1N3cQv+Igs
         W2Rw==
X-Gm-Message-State: AOAM532+upNfx/Gtvd/j/itxv+FRn9sUh4Pk+N7wNP8B7Cyl21fc8gIe
        WpkLQcPEmaGoRqWGaCebD/YKCopjfhOT8mSveYvSJrkE
X-Google-Smtp-Source: ABdhPJycLEdHUqGZdGoue1UpZOIxUj+YwwNQBw+W/wfj48lTocGI9t5EA5X4aVhyP6Y9EgTdB5nnJMhpP2va8MTIL4Q=
X-Received: by 2002:a25:6148:: with SMTP id v69mr71073862ybb.188.1641595373094;
 Fri, 07 Jan 2022 14:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20220106210319.3620823-1-luiz.dentz@gmail.com> <61d78648.1c69fb81.3e92.7dca@mx.google.com>
In-Reply-To: <61d78648.1c69fb81.3e92.7dca@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jan 2022 14:42:42 -0800
Message-ID: <CABBYNZJuQuOeMs3ejvPPua6BY4DHjjxxSibf=PPhm2wEHRKF-A@mail.gmail.com>
Subject: Re: [BlueZ,1/4] shared/util: Rename btd_malloc to util_malloc
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jan 6, 2022 at 4:16 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603319
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.96 seconds
> GitLint                       PASS      1.42 seconds
> Prep - Setup ELL              PASS      44.08 seconds
> Build - Prep                  PASS      0.55 seconds
> Build - Configure             PASS      9.53 seconds
> Build - Make                  PASS      1586.93 seconds
> Make Check                    PASS      10.98 seconds
> Make Check w/Valgrind         PASS      454.25 seconds
> Make Distcheck                PASS      242.18 seconds
> Build w/ext ELL - Configure   PASS      9.33 seconds
> Build w/ext ELL - Make        PASS      1548.57 seconds
> Incremental Build with patchesPASS      6454.71 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
