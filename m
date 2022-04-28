Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0CDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbiD1Npt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiD1Nps (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 09:45:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C58E5C75B
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 06:42:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e15so3427947qtp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wudy1u4y7pG2q791g559lSPIiqE7YwZyqoMmTL71lOc=;
        b=A7WN7Dv80WnaKU+7VjHuNbqFJsK7bc9BfAESM9r3S6XttX6AZ1sFqnvR2w9zODo3Qp
         pGgS0I/llfs1fefoWVvIwM9ZYtF2WbVA7/uJ7zF9MfKqKrjjTrxvdq2rltKnRyDVEZl+
         jGN9rxmMi31CrbnTXx2AKNlRnGVAUMMX4V7s+k/K149INM5AVIKrel9wIK4mjjuXO8xf
         xjU3TDLg1VArf2LUcKGl+0Mst6D3SDXsoXqUAui9Xm95IfGYlK3u2DcLyyNZabnaooC7
         t4jG8sZ/s3eXWXm/C8zgYVMIp5wjmD/K++3KNCyylt0ECOeIQ96Mi/YGsgCR15v6Iy0v
         QgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wudy1u4y7pG2q791g559lSPIiqE7YwZyqoMmTL71lOc=;
        b=CmIzygW5tK9QhBMXeJGqnbfjXE2J3vqh8R91A7AudSqhy2YYTyaoGC/I7MQxwrYgvj
         VyrDf9GD2qkC3H8pl+B8kPBdVicQ4V22JZPv22Ljfmohu81CZEYI+j1exksHlm6wyR1R
         f/+jbQ+mVVmcONEr15xkUDBz5+sleeOPyuEODUwk+MppHmuKeoVaXZ/ctcz7IEjSnOVA
         notzJzr9XCEjgEr+K3aGzncBnwDmTNFoNVN8nKDVBg4iribXhQ/0bqxbpguEMuu///zY
         pyxywnTDrwwzp/jsGH+jsR1TRU1xfcgHNQozlYYGVpwq61l+BUBX7F0X25jPqvzKks3l
         zCNA==
X-Gm-Message-State: AOAM533aMW9p1pjeVwggbr7+yM+u9PKbXKt18Z3BwWsLoT8+3BRxQrFN
        vCdFmilhVp0xBM2rv25w6SmRtmaVEFUnVQ==
X-Google-Smtp-Source: ABdhPJySL6haVQxsafUvGJeJHCOJoYtlEnllSPfGW1UEWGYqjtAEsnNrnjBYWCSvhl6JbqkWSMDB5g==
X-Received: by 2002:ac8:7e83:0:b0:2f1:ffd5:3925 with SMTP id w3-20020ac87e83000000b002f1ffd53925mr23167453qtj.292.1651153349206;
        Thu, 28 Apr 2022 06:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.3.41])
        by smtp.gmail.com with ESMTPSA id p66-20020a374245000000b0069c387c5449sm9872586qka.9.2022.04.28.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:42:28 -0700 (PDT)
Message-ID: <626a99c4.1c69fb81.49cd9.91dd@mx.google.com>
Date:   Thu, 28 Apr 2022 06:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1158593018637342915=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: Add bluetooth error information for error codes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220428130435.896-1-tangmeng@uniontech.com>
References: <20220428130435.896-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1158593018637342915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636605

---Test result---

Test Summary:
CheckPatch                    FAIL      1.81 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.93 seconds
BuildKernel                   PASS      36.51 seconds
BuildKernel32                 PASS      32.21 seconds
Incremental Build with patchesPASS      43.91 seconds
TestRunner: Setup             PASS      545.79 seconds
TestRunner: l2cap-tester      PASS      19.20 seconds
TestRunner: bnep-tester       PASS      7.15 seconds
TestRunner: mgmt-tester       PASS      114.41 seconds
TestRunner: rfcomm-tester     PASS      10.85 seconds
TestRunner: sco-tester        PASS      10.47 seconds
TestRunner: smp-tester        PASS      10.58 seconds
TestRunner: userchan-tester   PASS      7.25 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.81 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: Add bluetooth error information for error codes\WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#91: FILE: net/bluetooth/lib.c:126:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), SCO Interval Rejected", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#92: FILE: net/bluetooth/lib.c:127:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#92: FILE: net/bluetooth/lib.c:127:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#95: FILE: net/bluetooth/lib.c:130:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), SCO Air Mode Rejected", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#96: FILE: net/bluetooth/lib.c:131:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#96: FILE: net/bluetooth/lib.c:131:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#106: FILE: net/bluetooth/lib.c:141:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), Unspecified Error", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#107: FILE: net/bluetooth/lib.c:142:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#107: FILE: net/bluetooth/lib.c:142:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#110: FILE: net/bluetooth/lib.c:145:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), Role Change Not Allowed", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#111: FILE: net/bluetooth/lib.c:146:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#111: FILE: net/bluetooth/lib.c:146:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#114: FILE: net/bluetooth/lib.c:149:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), LMP Response Timeout", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#115: FILE: net/bluetooth/lib.c:150:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#115: FILE: net/bluetooth/lib.c:150:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#118: FILE: net/bluetooth/lib.c:153:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), Unit Key Used", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#119: FILE: net/bluetooth/lib.c:154:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#119: FILE: net/bluetooth/lib.c:154:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#122: FILE: net/bluetooth/lib.c:157:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), Instant Passed", code);

WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#123: FILE: net/bluetooth/lib.c:158:
+		return ENOSYS;

WARNING:USE_NEGATIVE_ERRNO: return of an errno should typically be negative (ie: return -ENOSYS)
#123: FILE: net/bluetooth/lib.c:158:
+		return ENOSYS;

WARNING:PREFER_PR_LEVEL: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#126: FILE: net/bluetooth/lib.c:161:
+		printk(KERN_ERR "Bluetooth: errno(0x%02x), Error code unknown", code);

total: 0 errors, 22 warnings, 0 checks, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12830665.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1158593018637342915==--
