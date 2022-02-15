Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60405C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 21:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiBOVpA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:45:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiBOVpA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 16:45:00 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517FD0079
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:44:49 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p19so165545ybc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sXxwxtBPF56nNeK+VEwHW+0aJk5t008hrOiqnuCJ/go=;
        b=FbzhCEdcx298eBlMVqeOqZZVF8YVPu5H+uAsCk4c4NtkRSmvfGJE3CSp5f0b1h5tXu
         sU3/sy23TvtZWt0DP/hmIfszrPKdPydG0uj2tLKM/0sDNGUwDrF3KGHPfwgu43TNdmXU
         Tw9syyxwdvIgaEQref7YvrDkay1XjCjCf/CHnKkakRoMM4DytM3GodkvBd1Rq8W9Qz5q
         4Jn3m6B7qdKMzL3bAWX6NkPpy3SMIJCe/dRvabYGV6pvltZg5bn9a88NL7TgBQuaehl9
         Pc+N5n9VJx/Znh5bC44HIY3jfgY1QpMD1bXWVFEai9MrYhOp9/x8hYfhZ67Wxub3mMAQ
         +y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sXxwxtBPF56nNeK+VEwHW+0aJk5t008hrOiqnuCJ/go=;
        b=NaY/KfqLGtKS5pNhthOdQmSohwxzIU7+t6qmBBNO+9aYaOGvR1Vp1OD9Sox1bEPx4a
         9Oi0Y/9go6BYAinAi9lYVdJySKVSyT2/4te5S9mkm153hTCy1hIWen9zpZGTZN0XuHgk
         Y+s4nXUfYSFT89ZL/GUZ6E2Vx+6kctLJgCRHdTbjIcxHMhSmogvDsszeoYWp5RBgAdPc
         gKEqzhra0kABhxvPlfsP2+SdXRXTI3/qxndXVWswcm28jQ0ONFXQgqP2K32c0LV6qLaR
         l5l3E5Uv42fiVd9XOd2jCDO1Y/AZ/CN4y66la38tEyUBZYEXbPeqjKlG2kICd/1uEitm
         dTZQ==
X-Gm-Message-State: AOAM533JECk6/o2B/sdOQDK3aZtVMvA1+t41SMSgb0CxyFlr1c1LYQw/
        oc+KSuI72qjRWyERowA+VAKg5rZnI2f4RtiYNRrHEh+S3k4=
X-Google-Smtp-Source: ABdhPJwxrTuDYDoUy953gdXazyX3X4oUc2h69w/jM4hHXPJwH3yRUFtT3aOundu1DCnVXqtp70ey3mRChXcn5pQfUrM=
X-Received: by 2002:a25:952:: with SMTP id u18mr829664ybm.733.1644961488276;
 Tue, 15 Feb 2022 13:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220214234200.1881712-1-luiz.dentz@gmail.com> <620b107a.1c69fb81.e124a.938b@mx.google.com>
In-Reply-To: <620b107a.1c69fb81.e124a.938b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Feb 2022 13:44:37 -0800
Message-ID: <CABBYNZJYEUAp5P9pi-x6enYNb2Jc1oq9SzDTKJRUdzktv-krxw@mail.gmail.com>
Subject: Re: [BlueZ] gobex: Print error if data cannot be written
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 6:31 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614288
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.43 seconds
> GitLint                       PASS      1.04 seconds
> Prep - Setup ELL              PASS      45.12 seconds
> Build - Prep                  PASS      0.78 seconds
> Build - Configure             PASS      9.33 seconds
> Build - Make                  PASS      1298.30 seconds
> Make Check                    PASS      12.01 seconds
> Make Check w/Valgrind         PASS      462.64 seconds
> Make Distcheck                PASS      243.49 seconds
> Build w/ext ELL - Configure   PASS      9.23 seconds
> Build w/ext ELL - Make        PASS      1278.19 seconds
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
