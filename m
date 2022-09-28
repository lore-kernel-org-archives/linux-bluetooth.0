Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8BC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 22:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiI1W2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1W2H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 18:28:07 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C7F684C
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 15:28:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m18so3302031qvo.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Vl5OEx5Yo9Ty49vScbvwWTeqCz+qN5miuuHqVVylDE8=;
        b=kGMiPTwVZA3l9fcH2zIcxxyijfzPa3gueSyd8ZgMOZHaYDPRrkdw5+YH7IiPaSRgpi
         ldjkSmZZ7NK2t2/aBseqzm/wqIt7VspDAplCm+G3R0HB9DM9/wFeA2sgHtEkbu91Dbzs
         BuMfXgiWD/bG2ya1d/tVLwcNIXLaLmtmsHOCSblRthbCaaMSRM7dRN2wyuK/wJylPwNb
         Pqu2eO3UP9/u5+4xC8EmshQAIDliUsGCZOej77UV3mDcbStiygA2He/zac7mcnskEA9a
         RCugJJDIj3MlMNGw/fXGnKsIh1uSwgbyL1jNThmU32A0+lXU7iTjVtWB8AXBvoEKLyBg
         FZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Vl5OEx5Yo9Ty49vScbvwWTeqCz+qN5miuuHqVVylDE8=;
        b=PsvuvUv55YPt6JaKq+Rgr1m/EWgN/xQz9J74vxnlp1taOAOjxvQQxk1MzYRgHnYHOJ
         KCU/0nCdUU0mN1IKmsRaUFIxPOd+pKu5CdwfgEW/7oMJZSjSWjU+9DbjQBGpU9ynTLDn
         UWXLkWrF2q6/1SMCHcCDNuR99Zasg54TijRPUJC7VSEVrpVnvtAJpo2LLHH3UUXQLGeL
         vEtw+FYpJf45BeCDUBiYn2dKqocOyAlPDwvzdbtBydhqdYs2jYjW8KuYeD9aq4jD+Em0
         D4bzDVRlKjKGeEPHxg3SihRB8Q6yx5IIr9gymUGIdNRMiptim/fO6ztRMOgODYumEnwb
         YNew==
X-Gm-Message-State: ACrzQf3rXFYVGloq4OQppDO+tcROpSX6ADbTZEzrBKWWkfDmUtcayKC4
        RfUlPCXAJr5Soe63UqpibedMiyqjb6gv5A==
X-Google-Smtp-Source: AMsMyM7zfuj1GGs5FMeB14h/r1NN4XE7gGaVM7TiMKJw+EBJs/GcuVrA2M5ItE1L4O5HjkKNQyCKLA==
X-Received: by 2002:a05:6214:230f:b0:4af:6ed2:9ee5 with SMTP id gc15-20020a056214230f00b004af6ed29ee5mr273526qvb.90.1664404085295;
        Wed, 28 Sep 2022 15:28:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.215.179])
        by smtp.gmail.com with ESMTPSA id q30-20020a05620a2a5e00b006bbe6e89bdcsm4505764qkp.31.2022.09.28.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:28:04 -0700 (PDT)
Message-ID: <6334ca74.050a0220.2ae97.f386@mx.google.com>
Date:   Wed, 28 Sep 2022 15:28:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7600599319750581193=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Fix attempting to acquire already acquired transport
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928212649.3824261-1-luiz.dentz@gmail.com>
References: <20220928212649.3824261-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7600599319750581193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681654

---Test result---

Test Summary:
CheckPatch                    PASS      1.78 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      27.06 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      8.89 seconds
Build - Make                  PASS      982.74 seconds
Make Check                    PASS      12.12 seconds
Make Check w/Valgrind         PASS      295.34 seconds
Make Distcheck                PASS      245.68 seconds
Build w/ext ELL - Configure   PASS      8.86 seconds
Build w/ext ELL - Make        PASS      85.98 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   521.33 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/player.c:1756:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============7600599319750581193==--
