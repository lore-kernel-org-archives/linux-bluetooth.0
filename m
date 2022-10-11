Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9308C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKMgd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJKMgV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 08:36:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C68F961
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 05:36:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h10so13075620plb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=flA7cDe6vyY9U1quz0oQE8ihEyzvHvay/DA2yYefAiU=;
        b=mf20GECvX26RrsWjb030bj4mUae9hwoURRoCw6Sijl7tIWugGC/APYjk42iVxblA1u
         FMlqnDg61XjUlqMHoIvqLHzfgYbiakELLly6MMZeJT7rr8fHb3HJJCfYNoPfkD9JVpDp
         2utFNseNrYGZVGrMFHfXVAG9Kk7wW3bffQYjQHFJib60WU+wCQ1zWu+av8fbcvGyIali
         eXma4pM8Pju17l7MjLE0mdj0ANP2cOoY26ZvxLhn0AgIVsUGa8px8Z2Lc4q87OTZIRkX
         OuP07m6vQ7j9ZK5q5+SxdEHuqhOfx+Z2jTw5oZGwmpcApo4ra/ZN8Dservw5U4DTcJmE
         KHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flA7cDe6vyY9U1quz0oQE8ihEyzvHvay/DA2yYefAiU=;
        b=zDxhKKHX4NQp/Zr6q3X0S398U3rSxLzj5QIaulZjhdiRiJDu4DWCWq2R8c/8NkUdgm
         NmOAdNGu5IYet132JCwi8WggznVFuP7H/Rx06ntOKv1WWLwwc6eDTP+CTSph3cV9fGgd
         6/L6HniozF1RTyrMu+23qdJ2HqKb0R8joZRTdYkhZk7FgSx4yfyyPnEewlN8tc+PAAmr
         o9egx1Y3/fR996DLYcr6JG+vkByYMFcYWHI1M0OgJQVxpjZMhLSYIYDDWMK4pxR2I0NM
         ziYKIjGSaaVnkqpD2qt//+xjWRZF0FDNvLs78GZEc2qhrruSOU4VKywtJ9B+Lkk54XVI
         GHrw==
X-Gm-Message-State: ACrzQf1Gqov/hbTWnwt7uJRXk7FsMaO4CM0UB4QYXbuCkEtt6YcMIiZY
        8HZeY2Ex+fbP+i7C2W9V1pemuZ3whFY=
X-Google-Smtp-Source: AMsMyM4/x9287yXPyFI/tdaEjlenen2RLXzfKSYQIc4x0l+eGmxSgP21fAUJmDRNS/fBxDFF3ox9aA==
X-Received: by 2002:a17:903:18d:b0:178:28d1:4a13 with SMTP id z13-20020a170903018d00b0017828d14a13mr24024410plg.160.1665491778157;
        Tue, 11 Oct 2022 05:36:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.72.95])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b00176ca533ea0sm1370036plk.90.2022.10.11.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 05:36:17 -0700 (PDT)
Message-ID: <63456341.170a0220.a5dde.22a7@mx.google.com>
Date:   Tue, 11 Oct 2022 05:36:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2410823600963369249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,v3,1/3] audio/transport: Adding volume callback to media transport
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221011113116.70514-1-sathish.narasimman@intel.com>
References: <20221011113116.70514-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2410823600963369249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684476

---Test result---

Test Summary:
CheckPatch                    FAIL      2.38 seconds
GitLint                       PASS      1.31 seconds
Prep - Setup ELL              PASS      30.54 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      9.45 seconds
Build - Make                  PASS      1039.19 seconds
Make Check                    PASS      12.27 seconds
Make Check w/Valgrind         PASS      331.94 seconds
Make Distcheck                PASS      273.49 seconds
Build w/ext ELL - Configure   PASS      9.51 seconds
Build w/ext ELL - Make        PASS      99.86 seconds
Incremental Build w/ patches  PASS      350.20 seconds
Scan Build                    PASS      642.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,1/3] audio/transport: Adding volume callback to media transport
WARNING:SPACING: Unnecessary space before function pointer arguments
#87: FILE: profiles/audio/transport.c:120:
+	void			(*set_volume) (struct media_transport *transp,

WARNING:SPACING: Unnecessary space before function pointer arguments
#89: FILE: profiles/audio/transport.c:122:
+	int8_t			(*get_volume) (struct media_transport *transp);

/github/workspace/src/13003868.patch total: 0 errors, 2 warnings, 198 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13003868.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2410823600963369249==--
