Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29251C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19C422D58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbhAESpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbhAESpi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 13:45:38 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 10:44:58 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d20so676423otl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Cr/lVCFQJq4kkEIfMAQdz/6xVlR5AeYtIYYt1BjOPLI=;
        b=bSaajpO9+HpAZaWJhOrFHa+WxL72Q1X7WeKP16wlU/+InAVal+LXw2yxUvN7W8hQ+N
         zBL2/O4gDOHj8E5UopitttF3CncTtz9qkv7vu1k4LeRAiPg988bQ848Gl4LI+VbaLEZH
         Eslo2VAXTtvs5ag5nFrhfbJ6iUJwL25s8ZMZjJrLtcVGglxhlg+ntov2Vu9ptkJt7jzI
         KYRBtHpiHLrJkldEZWHcfqwlyVT+ByPs3qASGIZ5eHPcqE57U3zIiadY7l9oyoOsvuIY
         lqxNpGEHXi1CHffdPRkoVew97rPrH8njVvPjbcm+umZr2+YKf1etme0Ajd8s1qg3fwrs
         eZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cr/lVCFQJq4kkEIfMAQdz/6xVlR5AeYtIYYt1BjOPLI=;
        b=CYpDsshY1u2Dux43KVwuzLhblNxlPppHAyPrpwZ2MbAHbViPbODxRWtJY72S0VF++b
         HqyLDqpbK8/nx3Iel02DKXucYw25S0My8AYzcS90E/TcLqYx3RsbG0LnN+53m+uQKWTI
         DQk1sA9st2GNstQ5wRU2MDVzUNo/pzkOt2kPR67tSy3+9tC5ZIRZaGZgSWDchrWT7pXU
         2rAALU5mkqN/2tN68FkFgAqO6lHosXISIkbRUCOHZIf0+NvgtK8GGZN84f6sFVR+Km2l
         DoHHsGYcFNcxauIpYAmlJOom94RMnzdzH98w9+SBW0nWZisHqFgktY6a/kJqOI466sr8
         D1wg==
X-Gm-Message-State: AOAM531HwyDzhJaINJlR+B35v0ZMRR9KgFcaCktA398stfL+/PTdNxsL
        jXPiE4i0n8tOcWnI7+eslaB7TKFRJ3a/oUQLin0rLcMk
X-Google-Smtp-Source: ABdhPJxDn4QGotU91Fo9DK/ZDTwmNIV7EldvawHl8PYRE5biljOV1Vtj+U/X/DOcXZhPr1PVMZpl/IYskmNuvtBy9Ds=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr656000otq.240.1609872297622;
 Tue, 05 Jan 2021 10:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20210104184153.3218489-1-luiz.dentz@gmail.com> <5ff36513.1c69fb81.b21ff.f493@mx.google.com>
In-Reply-To: <5ff36513.1c69fb81.b21ff.f493@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 Jan 2021 10:44:46 -0800
Message-ID: <CABBYNZLSVMwhjUOpuheENkNY7a2Zw8ejTkPwzdaWMQ3M1eeLvQ@mail.gmail.com>
Subject: Re: [BlueZ] gatt: Fix potential buffer out-of-bound
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jan 4, 2021 at 10:57 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408793
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

-- 
Luiz Augusto von Dentz
