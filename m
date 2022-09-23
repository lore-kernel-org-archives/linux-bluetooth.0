Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EFC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 15:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIWPtH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIWPs0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 11:48:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A73147CE6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 08:47:34 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z191so218365iof.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=3YPH0ssSXX+/6TINPY7yBLgNX0qXfLV9mMQqPOo13rA=;
        b=dDx+S3FOH3qp/O12CH4jNdBSUV4GTX9Rrdk5H1fX4wI3rgO3Ip5+GIs/Wumg8s+vu+
         LnyF0HRdZ5veizMMR8zkgFlTLb6KRz6bUwUTDFFNZGqwFgK3liZPliLWoZ1pKlcj+Lud
         xH/Mrr9zu1yTA17gWa4WDJOSaN4prOwsv7B+O9EaBWXxC22AzgUnDyrZ90zvjJW9I3hM
         992R6smLDrJ1vT6dYbcprTqWd3i1R19dZ5uI8l8K1GeIvE0TRyB+t/sOadHt4o/tfwMa
         1ZgVelP9o8JvEu05vaZno+3yXhjFQpXfAoZYUYg3q1ryBW9vy52tO3L3fCdMKvbzB3W7
         YUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3YPH0ssSXX+/6TINPY7yBLgNX0qXfLV9mMQqPOo13rA=;
        b=bFyW2qDO5CXOC8DcuZn2M5k4lWRHJOpqHNtGuINTvHiuYY5YMXYshwPp2W1tdIXyxZ
         xwlEwAuAsEH/3XTl6kGbpP4Zf8k26DVp3g9fSgdephX8eXMOEzcit0ELcTYkwJag5AJp
         Iq1wVRJLT6c3/ReJM9XEzsrcYb5j0kp6T+a9rwGSBRKkoqQ42L+36uhxpWd2sPprh/tk
         iu+00Qj2MF8PIuKJ8ksNiLsVBeNFQ1HAxAAtQPBu+FIIo5Ay1Nyo2YtpsyB2vHsQIKxo
         f+lBKoA9pc45ryuuvzZG+EDJen76XszDaw/FAB4oLysHeteF7P3YeHo/C5uGqFk/npXr
         d0Zw==
X-Gm-Message-State: ACrzQf0cv8T8zBRjt8+cK/PZthhhITiWYeQuHUOgkCYG9TyEF7LMzog7
        jji4MrhDnr1xBbRmo+PRL8ZUabyZeCRKjg==
X-Google-Smtp-Source: AMsMyM6UrKdShvRFMZEB7cjLGBeT+6BcxmbQLskyUmdMzUT1+CwWFRqP6x3WC7+DAI0osPXtoghNmw==
X-Received: by 2002:a05:6602:1492:b0:6a1:e50d:ed7 with SMTP id a18-20020a056602149200b006a1e50d0ed7mr4204813iow.145.1663948052986;
        Fri, 23 Sep 2022 08:47:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.181.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a05660214cb00b0068994e773e7sm3627650iow.26.2022.09.23.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:47:32 -0700 (PDT)
Message-ID: <632dd514.050a0220.75aa.4c71@mx.google.com>
Date:   Fri, 23 Sep 2022 08:47:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1948219572109807299=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1948219572109807299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679920

---Test result---

Test Summary:
CheckPatch                    PASS      4.24 seconds
GitLint                       FAIL      2.93 seconds
Prep - Setup ELL              PASS      31.70 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      7.06 seconds
Build - Make                  PASS      884.89 seconds
Make Check                    PASS      11.33 seconds
Make Check w/Valgrind         PASS      344.83 seconds
Make Distcheck                PASS      211.00 seconds
Build w/ext ELL - Configure   PASS      7.14 seconds
Build w/ext ELL - Make        PASS      116.89 seconds
Incremental Build w/ patches  PASS      533.39 seconds
Scan Build                    PASS      715.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v2,4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
1: T1 Title exceeds max length (82>80): "[BlueZ,v2,4/9] advertising: parse_min_interval: reset min_interval if iter is NULL"




---
Regards,
Linux Bluetooth


--===============1948219572109807299==--
