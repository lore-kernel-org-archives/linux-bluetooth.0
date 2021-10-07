Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE04F60F6E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhJGT5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhJGT5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 15:57:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1228C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 12:55:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c29so6256950pfp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PrGf4K+HP1m1fBtw/sGJ7UmTZKkUJZk4G6G4qXx5bm0=;
        b=H+51rCwDEeHTN8h8luNtejw6MVAlQKeTxzk8Gu9hFE9YpFGhMC+B8lcYaAzqv/pWvx
         wfmDn2f8YS2nKuQ44tTurOVUCNy63G/EFOF0GJps6eGBEWbZR8xmCNQx1rzUVYT79K6w
         ErRenPUfQ8qSO9VpWo0YmFnQAEzW1fOWsEb/Sc9Ar3bUPDSEWImNluHEBkAk5ffmjJo1
         Y4Nw9P9SR4KZJUJDX4N4Bxm5lJ6LEVr2pPJBHDQLBbnTWf7bLa637jGQIn77vj0Mb42F
         Jq7kDsVqcXPHVtHbm+MdpwEWO1z1ZLxCEwV2eBk68qX10N1zsYNDn1z2aVUXBW6u0yVg
         A+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PrGf4K+HP1m1fBtw/sGJ7UmTZKkUJZk4G6G4qXx5bm0=;
        b=kGg6DBgiXiZnmTyFKowTrdySglIsnt0H/wTB2Iveija4a7v24o8imwHdLTJJqrnxks
         YXdPTKymCFvagHrA2piqAhDaBlre+5lo8W59Vp3L6hSWg5eO9Bjtfgez0OoAp7W/aewb
         XBI0PmMz8u7i2UMIx9CwYQ4+4rJ5TH96KBGlfF5dNE0tUyAGvFVkljiu/lRKBGSDWaZe
         E7kqzyBXgfa3RTYD0ZEUGam6UNwGEwN4CjbDj5jcEWEBqbt6ToOsr3kWKkzJo+pMIxyl
         xKzokVLxTpEnuOUKKoC6aHiU/BrTrKyPVzbnCG202QBD+spTekoIGWfXxqqEhirW4iG2
         7wbA==
X-Gm-Message-State: AOAM533Og/4Cdh7RgkBN72370mz8tIkguSH4We5j85h2VXE2zQzbQMdP
        XDI2v2TtPm5V3Oh8nHS+wd3lWYCRU4Y=
X-Google-Smtp-Source: ABdhPJxQqn+tcfNR8tzv0f9UJwXtxYIH7uoE6tei7LyFZkVC8jOJtZY3ajHkMm6yULhajed4Pso5Hw==
X-Received: by 2002:a63:4a18:: with SMTP id x24mr1202546pga.209.1633636544938;
        Thu, 07 Oct 2021 12:55:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.112.104.19])
        by smtp.gmail.com with ESMTPSA id q12sm156776pgv.26.2021.10.07.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:55:44 -0700 (PDT)
Message-ID: <615f50c0.1c69fb81.51142.0ad0@mx.google.com>
Date:   Thu, 07 Oct 2021 12:55:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8893836613188097850=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v10,1/4] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211007193643.61436-1-hj.tedd.an@gmail.com>
References: <20211007193643.61436-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8893836613188097850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=559401

---Test result---

Test Summary:
CheckPatch                    PASS      3.78 seconds
GitLint                       PASS      1.20 seconds
Prep - Setup ELL              PASS      48.83 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      8.59 seconds
Build - Make                  PASS      218.53 seconds
Make Check                    PASS      9.17 seconds
Make Distcheck                PASS      259.38 seconds
Build w/ext ELL - Configure   PASS      8.75 seconds
Build w/ext ELL - Make        PASS      200.03 seconds



---
Regards,
Linux Bluetooth


--===============8893836613188097850==--
