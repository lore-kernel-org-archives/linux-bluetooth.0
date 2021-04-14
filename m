Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA679C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 05:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C7D610FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 05:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhDNFH6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhDNFH5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 01:07:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF4C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 22:07:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t22so9113849ply.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qEoq6XIwd4GCcLpF46VbL8VIiWbTxXUOQPIN11YygnM=;
        b=E8rlxNwrBc/a37s/DOhmGG+Ee8L2lgoPL3yRavsu2a6aw6ALqnFqBTIx0+LZiNuzfx
         /ybw+3T1uLPqurvnZoQb70xul3zoJTUfQiYr+M2AdAwEQ1ez+KMXuaznNkOjWrVeP2s2
         Vw+Ruix0AfBd+SxBu5i1TIeVj9AEg6tYZ7O9yw5tnr1NMVrbFkRcOzgwnqjHCrIYPQEG
         0P7WTrbQAW14OVPHYr7CthJREHTYlEoM/9pZTFxN8jz/fksRtDDsFRkBLk/FZXeN9JR+
         MVOkVdMWdaKQcHQfIwx0QQZF3jmM/qh7Qq+uBk2bIluWI+3o9o9zxaQczgF8LDZRwoXQ
         9fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qEoq6XIwd4GCcLpF46VbL8VIiWbTxXUOQPIN11YygnM=;
        b=l93Kx/C/uuI6YqLdyC+rJO7z8O+hlPaVFCUxDZMqj7rxHxshv+irdlu24Ln01GarRA
         CAUyWiLp2yzvbpuArao5pqozY8onRA6M6GRnzeUOyJqGNgeeR+UX13HW/ZtbdlhkCYfd
         3uN63ZHwU5aEkRV368CL9DBBIUIW0OiS/i8MnmuPIZI0Bs4o0yY7gCc0AzGo7rPKLh2M
         IVF7TIkTxf5RWl0YcERL6I89wq2UP1duoiYNp3NoDZOHL+6JrBhMzP7hcLeXEDH+TIyg
         IR6D4n+8zdMq5gE8lEnicHMULbqwXhkdIp2T2FeACUs0D7Wbwc93/Nv6E1BYmoDsHnMi
         GnMg==
X-Gm-Message-State: AOAM532l3I/mHY/5B1FPNRYgtk3AMuSkge+jiNW0soZTfKeoqWOPDwsl
        4Bim+vDWzm2q5MZL59ex8hs0XA32Pq4=
X-Google-Smtp-Source: ABdhPJx6scMtPwq5FGWTS0ucZ8elZ3CAFM4XIdV12/xPpbP7h5f6yLaf2O/aMnjORu5exyJtEIbA5A==
X-Received: by 2002:a17:90a:ea84:: with SMTP id h4mr1492935pjz.169.1618376856167;
        Tue, 13 Apr 2021 22:07:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.36.89])
        by smtp.gmail.com with ESMTPSA id ml9sm3579515pjb.2.2021.04.13.22.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:07:35 -0700 (PDT)
Message-ID: <60767897.1c69fb81.14259.b6bd@mx.google.com>
Date:   Tue, 13 Apr 2021 22:07:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1198627938495638926=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Fix the incorrect vendor name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210414043857.371176-1-hj.tedd.an@gmail.com>
References: <20210414043857.371176-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1198627938495638926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=466779

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      44.99 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.84 seconds
Build - Make                  PASS      187.18 seconds
Make Check                    PASS      9.45 seconds
Make Dist                     PASS      12.13 seconds
Make Dist - Configure         PASS      4.91 seconds
Make Dist - Make              PASS      79.26 seconds
Build w/ext ELL - Configure   PASS      7.94 seconds
Build w/ext ELL - Make        PASS      181.20 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============1198627938495638926==--
