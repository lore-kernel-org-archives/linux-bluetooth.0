Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6DCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Oct 2021 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E547461B30
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Oct 2021 10:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhJCKjp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCKjo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Oct 2021 06:39:44 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CAC0613EC
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Oct 2021 03:37:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o13so2612161qvm.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Oct 2021 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Y4fCh2p8kPZOD9nG/Y2gDmV8L5k7+QisCW+XGat/ImM=;
        b=AmR3UVermgO3atyDRMU+bP2KqwgtvGzXqmJQEYBHu/tUb7IjgDUxNUR+S+swpmXvXW
         FGZ6pTYGZX+dwBHzkbCZ2cSp156k8amXf0oDkz4zCwQfesdMBXY4j6MWl+VzBm+dMD3G
         q9zXDQ2k3GeYtqOOLgxapZyF67EYgVV84UDGDX8aJsXu2hpX4FS88oOvNX7Z0TxBtwYO
         nw8z7T1+0rMca2Giz9GC+ylcwQX0D3giVeM6Oe525MeuQqTEdRjZuWlRPbvYfqLPBjaC
         iPGO09KRFV69uQDX8ik1oCxHch63EOrD1rcJ7zjVlwJwzieL9uqMfvENBdrYU6Qb3UF5
         PYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Y4fCh2p8kPZOD9nG/Y2gDmV8L5k7+QisCW+XGat/ImM=;
        b=5VYV2CTV3K6APgbNFLO4xNuTDEIXY26mKpYCPU9AW+UTC48L3LwQuAWjCrBpG+7wsi
         vpm3aMOGeb56Yd/qET+lJbYhpbUxrYv7dVHaQaozzJ1wrCcoflwXDEwej5Lq+Yj/J6O5
         IQGq1oQYFexAWSEapyptwBlr21kmwn1xSJoFQUuWksqrajBpg9cc3hMU3dZHTrKuOBIK
         T+PA+eEA+m+DF0Z+63AVhO1uVlLUEDzyXl2NLLgVnXhZ5xdJg5J5N1D9Pd3onaDNz8vj
         qNW6vDV0d2PqvqRGx/ygwG4DL0yX9//MweANaYSmJdzkeHOL0TWRo+vVDTbHKHnA1JA4
         4cBA==
X-Gm-Message-State: AOAM530rOVwMMYIaA2C6eJ9/BL7fwsAe9scKSClJCeP+EDgYE+5q6oMb
        jzQJlwWThuNCR147FLgW7SRtMpNrsNROqA==
X-Google-Smtp-Source: ABdhPJybf139ADR5QPeBdtOSHWI1S7xEtJbYlgNEa+CQYNIgaMDMFzjvstTBxz5W39g9BZ8s2iKfbw==
X-Received: by 2002:a0c:b45a:: with SMTP id e26mr17474171qvf.59.1633257476445;
        Sun, 03 Oct 2021 03:37:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.84.83])
        by smtp.gmail.com with ESMTPSA id 14sm7382754qty.93.2021.10.03.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 03:37:56 -0700 (PDT)
Message-ID: <61598804.1c69fb81.d279a.fe3f@mx.google.com>
Date:   Sun, 03 Oct 2021 03:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7026465660761341193=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, thomas@t-8ch.de
Subject: RE: [BlueZ] Use accurate icons for headphones and headsets
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211003101834.45448-1-thomas@t-8ch.de>
References: <20211003101834.45448-1-thomas@t-8ch.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7026465660761341193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=556811

---Test result---

Test Summary:
CheckPatch                    FAIL      1.36 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      47.51 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      8.78 seconds
Build - Make                  PASS      194.30 seconds
Make Check                    PASS      8.98 seconds
Make Distcheck                PASS      228.49 seconds
Build w/ext ELL - Configure   PASS      8.21 seconds
Build w/ext ELL - Make        PASS      176.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] Use accurate icons for headphones and headsets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#50: 
are in practice implemented by at least Adwaita, Gnome, Oxygen, Arc and Breeze

/github/workspace/src/12532673.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12532673.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7026465660761341193==--
