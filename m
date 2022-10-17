Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD73C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 06:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJQG14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJQG1v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 02:27:51 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090552DED
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 23:27:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 137so8291079iou.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=osymlzy2oGww5mVc35iJ/oNI1qrhGKFYnkGq8guYliA=;
        b=QW8yU0eCyeLo5SxMYU8smYX4slnWqfVDJYMhDkPK6RTx8HSeQCBH3oO58R587MYJml
         VCu2ZoH6ekJN3U+O30WHm5Ss1u/UDa1JEGyh0Lrcb6vmqmkM2wJ4rPfNyFQyiw8tm50L
         hcWNgEwbnFdUFj+yOTk8CWD+autGl6QA5ctoGlVKcAPVRJlySwumL18DevEUxICQ/hnF
         e8nO00nfYR4ZT7JyB6bz//EbTdpUpSIkhaGBuLyF47Ef6Yd+A6LrwJHPXJL2qbwhHPwL
         g0+UUhbCbvchuMakqScgjnuGXPzYxCdb1vlFqtr5FxVoFvjbNvXdGf8swXQn7HUczAMV
         +VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osymlzy2oGww5mVc35iJ/oNI1qrhGKFYnkGq8guYliA=;
        b=hJvTk3ZqRd7nYXbuFwleC+hOpMBKcOQKzLmAG3+GvfV9pFsWNFBXu9FXbYb6z5qPge
         iVluLlzkMd6O0tYyfb/dc8JiXBXFxNsiGqDrvFEDQz2qGq17PC1YEy1ei/tDC0LbStmn
         4ZPULVsIToZhcPuIk2n4rSKKa8ILfWvT7etYw0MeYWXylt4KBro+ubuAdDPiNlx39EwH
         TtJ5rUCLXrrStgaRapRvCAOGEHS0HDPRPapQ6Vcb/EoeYoqxJMMQhdfvoDm07N6WqgzC
         uS85y/RASl/vGpy8nNNKvPi1sZhqHy9LDTmX6iArWmMM9l1v40jN/7cv6lNSY7g8coOj
         K6VA==
X-Gm-Message-State: ACrzQf0iqEpWm0XTd5qdOzuZyoebCErYMkEVkXo+UlziZPas89M34IaC
        G/IFNahfzlXFZ4Ks3iO8XWWEecDUfuI=
X-Google-Smtp-Source: AMsMyM7ISKOQA4CaJTqI57lfFJ47XI5fxIRV/f1ptF4Q+zu8JlxWGtCgGw/uQX0KF0of3BWqmkZsWA==
X-Received: by 2002:a05:6638:1919:b0:363:b88d:e02b with SMTP id p25-20020a056638191900b00363b88de02bmr4617419jal.154.1665988069778;
        Sun, 16 Oct 2022 23:27:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.112.22])
        by smtp.gmail.com with ESMTPSA id p63-20020a022942000000b003636cb862d0sm4177326jap.42.2022.10.16.23.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 23:27:49 -0700 (PDT)
Message-ID: <634cf5e5.020a0220.42b36.49aa@mx.google.com>
Date:   Sun, 16 Oct 2022 23:27:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4735827529638940365=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiapeng.chong@linux.alibaba.com
Subject: RE: Bluetooth: Use kzalloc instead of kmalloc/memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221017054713.7507-1-jiapeng.chong@linux.alibaba.com>
References: <20221017054713.7507-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4735827529638940365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685692

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 PASS      0.67 seconds
BuildKernel                   PASS      41.90 seconds
BuildKernel32                 PASS      38.30 seconds
Incremental Build with patchesPASS      55.12 seconds
TestRunner: Setup             PASS      620.21 seconds
TestRunner: l2cap-tester      PASS      19.71 seconds
TestRunner: iso-tester        PASS      19.59 seconds
TestRunner: bnep-tester       PASS      7.76 seconds
TestRunner: mgmt-tester       PASS      123.33 seconds
TestRunner: rfcomm-tester     PASS      12.06 seconds
TestRunner: sco-tester        PASS      11.39 seconds
TestRunner: ioctl-tester      PASS      13.07 seconds
TestRunner: mesh-tester       PASS      9.42 seconds
TestRunner: smp-tester        PASS      11.30 seconds
TestRunner: userchan-tester   PASS      8.01 seconds

Details
##############################
Test: GitLint - FAIL - 0.85 seconds
Run gitlint with rule in .gitlint
Bluetooth: Use kzalloc instead of kmalloc/memset
6: B1 Line exceeds max length (104>80): "./net/bluetooth/hci_conn.c:2038:6-13: WARNING: kzalloc should be used for cp, instead of kmalloc/memset."




---
Regards,
Linux Bluetooth


--===============4735827529638940365==--
