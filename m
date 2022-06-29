Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 13:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiF2Nzz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiF2Nzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 09:55:52 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5C1A83B
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 06:55:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-101e1a33fe3so21480538fac.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5kDnhyOY6mHdU+CvEAGsMUW/8q1iEdm1cDStK7p1VWQ=;
        b=HBZ7VWDxRnp1/u/2UsrWtFqdwIh1VXOdmwX3yt/BKrzBgZQ/bwxGCrfwx/7m7gJDx2
         +YTWYx1UAMT4IqJtf9bmjoneujuXnNR5TINeFZuaZRCbj5OrpIQBOzzkiH/SwrndNDOV
         rBnK+GBJ/zr88crSgtczcnmj9OgsizlzI4HBnE0W6cc4iXuRTunRmPFI9P0Iolq6jwBL
         ekeXQNTUxS+8yMc4U8MKpNd1jGCpSzTZ3Nb3I3HcaB50pc7bwMYTR/4WF1cARgPyoNOG
         sJ/tmxIQSPPZ8Yb1OstYXgmLm/r5ElVZmjLQCwsFvgP/ickEyfzgvslYIfI4UYav1Vdd
         550w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5kDnhyOY6mHdU+CvEAGsMUW/8q1iEdm1cDStK7p1VWQ=;
        b=pBpNw5n5uy/C4qDQkig/Zuc/7qYJW5+RuRck8IaXE1H608JMLdASSmj+fSeP9OKU9W
         3OgZTn70N7BhKHygjGnqGg2JwzwBwb4NB4Dd7CoQw5As2/lbnFiJvjbB1psGyk3EB8CQ
         ebzOtw7cGJwOqtColQqlIuDuBFNjy8WEFP69jPV4YpERO+AXbXy4nxmJMl9UpA3yQA0M
         KZ2fUuwhAGAK/Q5eIifBjsTSUcwtubMiFJbKFRyI3Ks6/+wELRHNFjgFOtpYwD6p+DA/
         NfGmUcm5coX/TY8gTguqPcp7xc5Ir/dhbaObLk3T3Y45uGc1YHl5knA1ps8LYmWR6mCZ
         aD1g==
X-Gm-Message-State: AJIora/xqrfOrAXYy3Ukof2rcO1n/mgLzSjvhpksJhMNtHdh6sfWflpV
        NRk9gF0nR+VHNEtMazMTqrSeGW51OBw=
X-Google-Smtp-Source: AGRyM1u/lLtipDF4Et3OPMAX12zVAeSP272QwLjSGccfbdyAQ36xmq/mNxZxL5Fnzn942OuHjhwgUw==
X-Received: by 2002:a05:6871:69e:b0:101:b7d2:7d0f with SMTP id l30-20020a056871069e00b00101b7d27d0fmr2039574oao.217.1656510951077;
        Wed, 29 Jun 2022 06:55:51 -0700 (PDT)
Received: from [172.17.0.2] ([104.214.58.129])
        by smtp.gmail.com with ESMTPSA id w70-20020acaad49000000b003351fa55a58sm8455745oie.16.2022.06.29.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:55:50 -0700 (PDT)
Message-ID: <62bc59e6.1c69fb81.d88f9.3043@mx.google.com>
Date:   Wed, 29 Jun 2022 06:55:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3622306685103419391=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lishengyu@uniontech.com
Subject: RE: [BlueZ] avdtp: fix possible minor problems
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629124656.10174-1-lishengyu@uniontech.com>
References: <20220629124656.10174-1-lishengyu@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3622306685103419391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655015

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
GitLint                       PASS      0.87 seconds
Prep - Setup ELL              PASS      44.14 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      8.63 seconds
Build - Make                  PASS      1434.45 seconds
Make Check                    PASS      11.55 seconds
Make Check w/Valgrind         PASS      450.88 seconds
Make Distcheck                PASS      240.18 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1419.52 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3622306685103419391==--
