Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7343EC388F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280DB20704
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmhT/E1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgKGH0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKGH0w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:26:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2020 23:26:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id t13so3078159ilp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2020 23:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5AZqiHVelyUUoXi4KKhwrs2BKr9CpOu+j6cxXt7FQj0=;
        b=mmhT/E1bhwW3Pk2eP+xFEgQ0dBpX7ob7pBVCOksQIy33ZSMaEqbrX0d0s9izSk8uNC
         tMMDy9f1MJDEtRRaiUUVRoHScXLlbhxGLvHPoVZbycfAlINFHj+reLIxGkJHEzYyVeQN
         ZxaAwqaPdE5RKcIbI/i217E5an1SSdQD564j1b7kFYrtRxQiGtx1qeW/q8GAE3XQ17Hf
         zz/lh1RfeGCCD8MHhbxL1U4mLX0o6KD/SVM0iUW/cNAhwM8ymIfnDlw4fOmK1haMyXRx
         Rxbk2PRkiNeZVQOeye3tTdSA31JrDWcLDUr2E3MPcN0s4JJJ8B0smv76mGGava2InwQI
         5MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5AZqiHVelyUUoXi4KKhwrs2BKr9CpOu+j6cxXt7FQj0=;
        b=azTsxzMjj6fznj6rKL5ab41y+Hz35f7n2/MiwGV9oMjAwjb6MunWl9B+Gt1w1VR3Xp
         D2mKbLSYMYkhlBEfNA6wFuwDB1Bcyyx7jR80XVIaFmPJM6JWuNhtDriesYGWllZgWNp1
         itECTirZacBkTDeWcuVKf1A54MHp9m4nt7JprjDdlQ5anT9UUDdO9fOUOqXEyjwzfzDd
         rbL4avTxuCXFtZF8V4We42Jvwz87sxdsKfJATyJYvh+dcd82AhIYxglN/uIVOCjIaa73
         pkok4+tMBAkmGQBx6i8uZmlaQvHWvmrrMdM9SaPztJstnVdwW2kSH6RoD5s9m5dJLqTV
         wUeA==
X-Gm-Message-State: AOAM533UfynX05GcbFua6jv5eU2lo+I/fTU3cTPqm5gKFFyuHkCkyErT
        4lUyVhs8kYxxycXj1VsyKFB8kkUsp2M=
X-Google-Smtp-Source: ABdhPJysiuWNF/Obqy0eDidf1TOskcx3L8cIFgqYSIk3g2Eg4Hwlym9uwwdktITS4QfmEnWi9Icqdw==
X-Received: by 2002:a92:8b4e:: with SMTP id i75mr1374797ild.43.1604734011380;
        Fri, 06 Nov 2020 23:26:51 -0800 (PST)
Received: from [172.17.0.2] ([40.65.200.38])
        by smtp.gmail.com with ESMTPSA id m20sm2142547iow.2.2020.11.06.23.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 23:26:50 -0800 (PST)
Message-ID: <5fa64c3a.1c69fb81.a744.8466@mx.google.com>
Date:   Fri, 06 Nov 2020 23:26:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8069685723314605613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Convert tools to use ELL library
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201107070312.8561-2-inga.stotland@intel.com>
References: <20201107070312.8561-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8069685723314605613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=379479

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
shared/tester-ell: Create ell-based version of tester code
ERROR:INITIALISED_STATIC: do not initialise statics to false
#809: FILE: src/shared/tester-ell.c:761:
+	static bool terminated = false;

- total: 1 errors, 0 warnings, 901 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/tester-ell: Create ell-based version of tester code" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8069685723314605613==--
