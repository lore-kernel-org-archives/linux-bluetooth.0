Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B48ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 23:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH3XAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiH3XAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 19:00:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02E394EC4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:00:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s11so3023087iln.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=W88hRGZS7XnnExNJc9TPs0ZLkmTcNa7H6AIIRvTqjwQ=;
        b=W945VjlE4fEW9SLWLXEGu/Jew9bLx0g6461gfZ21RrJv4TAe52OZvMq23ipgjt0mw/
         r7IcmcCBzR651OeRWeSuNdK9HADnDQcInU4x8HuD5J+rKojLGvdlu0TCSZgLNMmZ4xtd
         RWEKHYe6UIil9J7qc0+3YS8x+HHxYNiXGo/H/ScamCKQ3+mVth4WWwcUDb2a3rbsBdLt
         W0QoTrkBt50Smshe0w8QBaWo/Erkn3ylRiDEFwTcFhHcHXGx/BVO/6dPnWupSQAl/y8F
         0EH4eGE/sz7lPWIsGjImJutzaOlsdi6GZsy3KYOhfW2p6pFsGdhlZ5AdAx/DxqzN4mkG
         GvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=W88hRGZS7XnnExNJc9TPs0ZLkmTcNa7H6AIIRvTqjwQ=;
        b=uuXpUDrR5JJ3v9pTRzz0vmczImSDPm0GvAaVP9wQFH6oVOqbqsqPxt9nZ5Fk5JawLY
         b+eDbODfpVwwMq+nwFgV9JPzk08sdAwLIUVBs74DBa7jkMVc2Z0thhDK0w+emEgSg288
         5cKu8cJXTf639J36wbDXw1C1fQCGvpviPsRraT+2r6UsTuSEUTu6Iev5eSYM/h4fWd0+
         s0fopfZkNo2VBExSeMpAuQO941bzRSK8IYeJSYeNVMXDB4ZRVi1J5GxsqmR/vVCEQ/jX
         5MAXXydhab4DLEHxgLOfA9Zg586CC4ncuQWFA1MYRaK4emj+QJZvEeC5ShL57NsofdW4
         0Ycw==
X-Gm-Message-State: ACgBeo0hTBt6O2jBJ9XHN++xI3DajYT0VJa4G3S2XHTyY2oECOaPRUYq
        DOKRv6m6eUehiiMuxZu7BhYekpLeKFvsrA==
X-Google-Smtp-Source: AA6agR6KyRaQdOItKIkCZUQng6itxoIFOtXc0ILUjAQMsYwfLRF3Uy8spCM44YmDXJzJVqltyAbHBw==
X-Received: by 2002:a92:1941:0:b0:2e9:6c43:17b1 with SMTP id e1-20020a921941000000b002e96c4317b1mr13299360ilm.139.1661900436681;
        Tue, 30 Aug 2022 16:00:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.101.216])
        by smtp.gmail.com with ESMTPSA id a15-20020a92ce4f000000b002eb09a4f803sm2947171ilr.67.2022.08.30.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:00:36 -0700 (PDT)
Message-ID: <630e9694.920a0220.272a5.353c@mx.google.com>
Date:   Tue, 30 Aug 2022 16:00:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7230961303952579535=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] media: Fix registering PAC endpoints if ISO socket are not supported
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220830215444.1141653-1-luiz.dentz@gmail.com>
References: <20220830215444.1141653-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7230961303952579535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672619

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.80 seconds
Prep - Setup ELL              PASS      26.48 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      727.87 seconds
Make Check                    PASS      11.61 seconds
Make Check w/Valgrind         PASS      285.48 seconds
Make Distcheck                PASS      236.43 seconds
Build w/ext ELL - Configure   PASS      8.25 seconds
Build w/ext ELL - Make        PASS      82.57 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   482.95 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
profiles/audio/media.c:1465:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3012:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3015:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============7230961303952579535==--
