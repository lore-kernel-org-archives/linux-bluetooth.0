Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B48C6FA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 22:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiILWVF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiILWVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 18:21:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89421822
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 15:20:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r20so6673277qtn.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=IUNH3uSItqrYTxl66ijlrAHAVzPkgsBidDVvm7AlVOw=;
        b=DyuvZWFbJhFVXztdGv6mWv5464OJmSGOAkitsrqfmB88N68Adtg2afr6k7/qLX0a6k
         n+EcEBvjOnIHwM3mIp7ZM+mMgCbgzk/MeGLfXma2JmYNNZ1rvKO+3J1CVUxvGPbBHYsV
         ZAwRY9ZAMqaLgQK4sUWOy/wIIxPvDUw9+UlDr7i/3JjhHb2gDL/9x0ehKUATKzxyRpl0
         OgLFTaFpwtQq7sR0cOnodrHBM0r9nkiEPxwllSV15LGLObR/SqAM38IovLp10JFvzxr8
         b5LKuUDIScuEeyIyWbJTHhm2Atpnu6Z3y6U7JkoMqEhdWiLCpd0leF285hi3jQruYyxK
         wXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IUNH3uSItqrYTxl66ijlrAHAVzPkgsBidDVvm7AlVOw=;
        b=2Hrchpmf8G39bTZ7S0gs6iLNBkxlnwtE4/3PnAEBp5QDELVniWC4klFg5d/i1EIii5
         m1fIMS/DHwJY/ynH9xkpFhc9DElwGb47pOhIY7xeIp7sELk+pKNZUEUFRndbZIYGjSIg
         fwx+1dDL5Abd+ZrlC9QvTNKsbB190ARd+SDgYhYrLSw3IrLGoYXzc7dma3EPTdja90BY
         lO42usqxN5Bvl5W0o8QyIYb8RhSqAqrQu908nF2dpcbeoon69rKZpayjQ4/KegBdb2wo
         QCJ5Y2I1WpHg1BZG+a/tYOx3JFGCU3ANGSnid0KMLKGaIy0g0TNUUEJZvULe1Kp6W119
         kt1w==
X-Gm-Message-State: ACgBeo0TODSuqZAstLA16/R5kdGBP3l7AQteKF2hiLg3/dDeGmfKxMLg
        zCjdY9vsZETcaPwprHwinnIw+vfUrO8Hhg==
X-Google-Smtp-Source: AA6agR4NqQJVqbcdO/ihNxn4h7v+0CKwBnCitc4v8ykb7HfZ/uCOqvhkvT3i8ma71YdOlNPJT18bPQ==
X-Received: by 2002:ac8:7c46:0:b0:344:91e1:42ed with SMTP id o6-20020ac87c46000000b0034491e142edmr25186591qtv.105.1663021246323;
        Mon, 12 Sep 2022 15:20:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.206.72])
        by smtp.gmail.com with ESMTPSA id fx6-20020a05622a4ac600b0035ba90126e7sm6319686qtb.91.2022.09.12.15.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:20:45 -0700 (PDT)
Message-ID: <631fb0bd.050a0220.9188c.c751@mx.google.com>
Date:   Mon, 12 Sep 2022 15:20:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8473071416057237045=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/bap: Fix attempting to disable stream when it is idle
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220912214257.173804-1-luiz.dentz@gmail.com>
References: <20220912214257.173804-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8473071416057237045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676340

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      26.18 seconds
Build - Prep                  PASS      0.89 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      728.95 seconds
Make Check                    PASS      11.08 seconds
Make Check w/Valgrind         PASS      286.38 seconds
Make Distcheck                PASS      235.27 seconds
Build w/ext ELL - Configure   PASS      8.27 seconds
Build w/ext ELL - Make        PASS      82.56 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      504.29 seconds



---
Regards,
Linux Bluetooth


--===============8473071416057237045==--
