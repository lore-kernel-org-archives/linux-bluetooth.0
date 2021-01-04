Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C53C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B30F20E65
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 04:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhADESU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Jan 2021 23:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbhADESU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Jan 2021 23:18:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4EC061574
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Jan 2021 20:17:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z20so17759160qtq.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Jan 2021 20:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=T4ysV+qI8vqepY/aTmbEx6Rt00p4H03uGABobfQ1ooc=;
        b=vePFMRj6ywoj87asrVfHOHW03Mj2s9Y/R9dRMEAXTEyKTvewFgUHwQ9zPC399i6BzM
         GWhr2NI/8AnfKF1DU/JUxU9L/gYSCzSvW3NWN7+JO7m73JXS/buM+1zsy0cjflfGjv/W
         Ip8g7FxxJ1JRRM4Z1nf6qInSmFyO12BG7Hpkgkag88lI8FeYLICq1rXJlU6ER+/N6Y4p
         8WGtRriEkplublj495IgS6O0lQmZnI+ayL2gJxeDREoqoGv2O1bL1ps/LbKfZ84svTfh
         CjDIyuhAryxH7T/qQn5VR6I8zHKxxI9qDKBws0jsdqPmekDHTDCqRb6mT+lNbo15Q5Mp
         6zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=T4ysV+qI8vqepY/aTmbEx6Rt00p4H03uGABobfQ1ooc=;
        b=VvHb28a0gdQE2DBFwWGJ5hCAVdZunkoLp2969tMgs7xZxak6UpL/G9qqIjD3r3GDLn
         YsUQm0iCqrf3L/KVbYj6bCfKwFnOmvA+Q1j9NoN1l1MIp97IXglKYZXrIhDcJ61SmUdo
         YmG4hFJNTqQ6v0qitJ5pORgoIwV/5c4+jpU13uHnvbtdjuilgRsMu216sUzRWwOjev5g
         iP6MleAVD4LiMQiFJa7xPGZix9CYMkzCMwsbaiD8TKv9tBKsvIGZY4/YQygRd1jF+4zf
         xgL5AAq1h+gzOThZAteOEK4RzkNrSzD8ULwF/QqQG38DWFsyFKhlZZOTG/zzQKRahKOT
         /9RQ==
X-Gm-Message-State: AOAM532fZ/wMuw/0tqJ865n4LtOdSuLGwMJvsiUx9wea4kihAQt3qilJ
        BQz0ZLoZRRs0VuZk5DdsRetbEZequ7nKaQ==
X-Google-Smtp-Source: ABdhPJwx+TEsml3STG5/lzj60bCJfByaixwDYN1LeGk+eBp4CsqSKkQYrpuwE4HezVaYIfYqtpcIeQ==
X-Received: by 2002:ac8:4cc1:: with SMTP id l1mr69577467qtv.128.1609733859140;
        Sun, 03 Jan 2021 20:17:39 -0800 (PST)
Received: from [172.17.0.2] ([104.208.246.75])
        by smtp.gmail.com with ESMTPSA id y15sm36619438qto.51.2021.01.03.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 20:17:38 -0800 (PST)
Message-ID: <5ff296e2.1c69fb81.42099.675b@mx.google.com>
Date:   Sun, 03 Jan 2021 20:17:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8190719256635124096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mike@mnmoran.org
Subject: RE: [BlueZ,v2] mesh: Update AppKeys on transition to Phase 0
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210104034837.640081-1-mike@mnmoran.org>
References: <20210104034837.640081-1-mike@mnmoran.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8190719256635124096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408415

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8190719256635124096==--
