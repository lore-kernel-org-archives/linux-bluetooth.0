Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B34C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 01:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF7D23A31
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 01:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgLHBMn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLHBMm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 20:12:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97420C061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 17:12:02 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id c7so6367951qke.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 17:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5OuCKPcc6rlSGT6xzgmJO06NZtQLMY6rq2NUcBQsyDs=;
        b=fmmV1xc6eXhDiOILsX9j3TSqWbeYNTidRSDabRoMvSbP0bZbqCpnmn2P/vXxc+xIMu
         xVjxyBoO6/XZvh6ttj3pAlk8qgFpwX07HfOfKmyGHXCnOf8EdYBUbhGyAJ4jEae6Iqw3
         y7XYnxvCGTpQwGB1erWZ0X48zLWwBO6oKi9KhcmYOMLrMcMYVBmeOE2r5GMZ7ejloCTf
         1lPFO/d7T6tbimy70UOK05YwbghuzNGYVs20LzsNWLS0YcUSZ5qFewi2cauxbQYg+lUF
         62bcXpRPAejscJTTfJe5o+vUczdtjbfz6RSfQXscetJ9+QaGrRM7ftMxzsVyj2Ik3IUa
         oyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5OuCKPcc6rlSGT6xzgmJO06NZtQLMY6rq2NUcBQsyDs=;
        b=oLn+da8mM7a1LI0V+4LWuizSkIv3ifoYT2NgDne1wkH5B0h2nGZUroplrNB/fxeBD+
         /ZGCJZUvDVud/v7TPkpzWvmCMM4DuoR7t3W9X7G9fXJtMYG+KApdVoAapBSZFXe9UnYE
         im1F74bKjJ2MmtuiEDsTvwRJidCIaCPEwP8yr2/0FV/aSUxS1lOirgmbWhPkAAGCkpdW
         gxgGOmi5tgpGGPgrPoy/O0nYTtsF+5iNv5ipOsAfH4ow5h3N0IynBMl4TULwyWt2LgxG
         8L8tQ7snLABecFGN0q2zph4GV+uLuMkrWvllyP0mSHr4aCBz8lM434RQBFjIgaG9tOV+
         hh2w==
X-Gm-Message-State: AOAM531dqPH5tFbthGoR1DsVZY/2aCWK7xZ2/VkrddJNW9NKolJum2bJ
        PHt41Ihof+VtB+u1SA4Gttggb61q5K4=
X-Google-Smtp-Source: ABdhPJz4oTFOlnoIzNvN8XgmGanRbhRxryXrKrlM6yXUr3QUx6KdSqFWhmFmNgEndje2uRDg7UrUqA==
X-Received: by 2002:a37:9c41:: with SMTP id f62mr27179406qke.97.1607389921734;
        Mon, 07 Dec 2020 17:12:01 -0800 (PST)
Received: from [172.17.0.2] ([20.190.218.201])
        by smtp.gmail.com with ESMTPSA id w30sm13433919qkw.24.2020.12.07.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 17:12:01 -0800 (PST)
Message-ID: <5fced2e1.1c69fb81.44083.da1f@mx.google.com>
Date:   Mon, 07 Dec 2020 17:12:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7321410771688431237=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: policy: Fix connection stealing with Airpods
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201207154903.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid>
References: <20201207154903.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7321410771688431237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=397867

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
policy: Refactor reconnect policy for resume
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#79: FILE: plugins/policy.c:60:
+static const char *default_reconnect_resume[] = { A2DP_SINK_UUID, NULL };

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#80: FILE: plugins/policy.c:61:
+static char **reconnect_resume_uuids = NULL;

- total: 1 errors, 1 warnings, 195 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] policy: Refactor reconnect policy for resume" has style problems, please review.

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


--===============7321410771688431237==--
