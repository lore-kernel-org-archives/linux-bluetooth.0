Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4350FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 16:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbiBCQpF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiBCQpF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 11:45:05 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C3C061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 08:45:05 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v5so3040313qto.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pFExg1VrA5AVyWQdcMS2whwINgiQJ6Uz+j7NJF1RTlU=;
        b=GyxEZqgIIUlRV7xRFO0U1UwkFqExJYTYdkGDxjGW7tdh0qGHSE7qB/mI6b16NE/3qF
         2vNtJxj5BqPdZXtGOoaQSC1lOGCFL5laOyFCrZdx4vWas+JiOtLZhDMRMGu5j/aJM0Z2
         5nLoJJTNPZ2bkhv5ObdGKztDInoprEpkSyDnuEqOOZGnAbhf6gVS0gcTxR6PJv3SPpKo
         iEbVYqMBYMUoX11LbJ83Lg3uaK9VcM1ZrhIA6ptWgsVaS8IvYPEG1drSAncZ8KRy07wj
         FyvaQwFzScJ19ZH3kSYGzut/xQCriEb3xAvZyumDoYJ37lX3iRVM9nFcKNeX6uWXZYKI
         Ue2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pFExg1VrA5AVyWQdcMS2whwINgiQJ6Uz+j7NJF1RTlU=;
        b=EnUYvYP83IJk+/+kmlfy5rfmoAMrvP2bLszQQxGq5mKfTWZHh59ThfoBRhRcE/4Nfx
         DUkTDq8HkKeJH0IUdzO3J4njHKC+GLpJLy8sTSgz6ugEkovpe4IxvsSeYOknL6/iFIfO
         +nFpca9jWrepAd7hYdKDXNqWKMJhvmk14X1yaKJ40tLHySLHOTejKNOVypH13WaXLYTs
         igw1EL/VRs1jFs0P/hXfaDnez7PT98fr0swcaW6ZQcNLOLAPxa6ExZ128IArJaSb/3bt
         AES0EOJFF5yu06o+a42M4CNZRpNId4BqQqCGWfS8jzobtZ+mWf8piszyFDqr6C8Odu/k
         yfCA==
X-Gm-Message-State: AOAM533auVDTUiMh6a1KhFJMS83Y7+STAdeE8SgVyvhEvWN/5A72WWCA
        4IufVsv3SOIU24Pvi/dnSYRhWwMgcRAJcw==
X-Google-Smtp-Source: ABdhPJzIOZC+ZobLK+WiFxCAdJQP+kcBkNe4luCVs6ZX0M7kaEqPdwumtb8uYUV1x8eC9C78W8rVQQ==
X-Received: by 2002:ac8:5cc9:: with SMTP id s9mr17904698qta.215.1643906704160;
        Thu, 03 Feb 2022 08:45:04 -0800 (PST)
Received: from [172.17.0.2] ([20.186.170.88])
        by smtp.gmail.com with ESMTPSA id 5sm8208020qtp.81.2022.02.03.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:45:03 -0800 (PST)
Message-ID: <61fc068f.1c69fb81.89c13.649d@mx.google.com>
Date:   Thu, 03 Feb 2022 08:45:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7875750145234720316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ] mesh: Make key_aid and net_key_id naming consistent
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220203143849.746696-1-michal.lowas-rzechonek@silvair.com>
References: <20220203143849.746696-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7875750145234720316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611029

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      1.14 seconds
Prep - Setup ELL              PASS      52.70 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      10.47 seconds
Build - Make                  PASS      1821.87 seconds
Make Check                    PASS      12.71 seconds
Make Check w/Valgrind         PASS      559.13 seconds
Make Distcheck                PASS      293.49 seconds
Build w/ext ELL - Configure   PASS      10.83 seconds
Build w/ext ELL - Make        PASS      1784.61 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7875750145234720316==--
