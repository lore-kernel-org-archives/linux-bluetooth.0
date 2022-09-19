Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59AECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISJgr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiISJgc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 05:36:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503813D4D
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 02:36:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ge9so15697539pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Di/buVUxAsG/rU9O5qSjHNKso2t3dgCAPbjnrGL1pN4=;
        b=X3bOgx/BhuoQSHKtZyNMHy0wvqPNIZWKOWhrT1l4lNHkKdzTXkq+igJxMtaiOjLMl8
         9EAVC/AABNjYglM85kegaJbiDe2YUARD9zW5zgQbK/vNlNXOP8yuzrAT4SVr9C9VMEfI
         H6hXgHAhjEQeUDP7Hhl443wy+xTFfYDi1LMRadreSxjphjVQXt9dUPzyV0+iW6w4Q+S+
         vwVHSv9aGQj1Mceb0rkAr6FrrK2xImci863C/LyKrbJtl7pHK+G9ZHsOqI9IkHb/zBwL
         LHpKm5YTbIBDcIiqYVzefrl9rZQyr0QL1AJ38UI+ziM+N0eN/HX+OFr9Xqm7CmBeHcW6
         5JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Di/buVUxAsG/rU9O5qSjHNKso2t3dgCAPbjnrGL1pN4=;
        b=e71XCxNjGQYeRHfaWZ8EfJMc5vLkwHq1RMzwvoViucPLT+fr/56eg9fhjOrmAKoDbl
         K4RRU/+rE0ZvWJfY44yB9qQuPQEdkb2JL8cuIvDMiYbl3cPBZRb/DokkRzEe2qomdbgN
         PvuPGXfn/lgVK03j4xXinhmYYP8cJj42MIb547MjGqWdYhIMpvApjYOO0aK+V/DySice
         0sEC8mdYA6sG25qZ+YJXphH8rZroVNGiBVsNu2GRZc+5ZrsD2GgtVAxRbXDpAbi1yjjD
         vg7NaifX9eJForEH0lFU27tw2YWTBMfTy3mldBG0XZLZ27duovZtS+3OidYidZFWOTXA
         iHyw==
X-Gm-Message-State: ACrzQf2/iQsXaU68y5IIRygA6gYd6/iL59q1kASfAy+jIDWEsinDF2Oz
        itH3YRVcAx3irIMw/w9wLXVdoDD3CM8=
X-Google-Smtp-Source: AMsMyM5xWHav+FjFtYtEBjjrKiOOtqNiTNBxnzNBA8CaKEM5icUXPsiYMvnXI4gdwXi6WmWLzba3yw==
X-Received: by 2002:a17:903:110d:b0:178:2a53:c7ff with SMTP id n13-20020a170903110d00b001782a53c7ffmr12072140plh.89.1663580190336;
        Mon, 19 Sep 2022 02:36:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.42.240])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a678300b001fb47692333sm6197890pjj.23.2022.09.19.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:36:29 -0700 (PDT)
Message-ID: <6328381d.170a0220.5327e.a238@mx.google.com>
Date:   Mon, 19 Sep 2022 02:36:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2050202094581325027=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,v3,1/3] shared/vcp: Add initial code for handling VCP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220919080722.562080-1-sathish.narasimman@intel.com>
References: <20220919080722.562080-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2050202094581325027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678079

---Test result---

Test Summary:
CheckPatch                    FAIL      3.51 seconds
GitLint                       PASS      1.42 seconds
Prep - Setup ELL              PASS      34.86 seconds
Build - Prep                  PASS      0.89 seconds
Build - Configure             PASS      10.66 seconds
Build - Make                  PASS      1181.14 seconds
Make Check                    PASS      12.57 seconds
Make Check w/Valgrind         PASS      368.00 seconds
Make Distcheck                PASS      317.23 seconds
Build w/ext ELL - Configure   PASS      11.08 seconds
Build w/ext ELL - Make        PASS      110.20 seconds
Incremental Build w/ patches  PASS      392.00 seconds
Scan Build                    PASS      806.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,1/3] shared/vcp: Add initial code for handling VCP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1215: FILE: src/shared/vcp.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/12979747.patch total: 0 errors, 1 warnings, 1169 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12979747.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,v3,2/3] profiles: Add initial code for vcp plugin
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#395: FILE: profiles/audio/vcp.c:288:
+static unsigned int vcp_id = 0;

/github/workspace/src/12979749.patch total: 1 errors, 0 warnings, 330 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12979749.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2050202094581325027==--
