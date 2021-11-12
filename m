Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C94C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B60260F93
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhKLWlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 17:41:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B87C061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:38:24 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 200so9224625pga.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NzxJ/P5xI8k/+8qyQkcuciv21kLf2JEVcGByzZ1EjNM=;
        b=Q70wAJz8x8FvqF8iVhYP8VBTcj8bxcjwI5ZJsOE4vfEm+80LfnD8H+gXxjVzRHODMV
         qNV0SwvoNE78XgAnWpvh+a1Y0PLEU7oISSfp8JyJ0YzgKnrUqPUQAneSQLCX39Ag7WFE
         x+JoxDciiuNu/XI6qaEwDwQ6o/xIaTg8L+ydh7uUi99Qam17i0QojB/b3jWb/adJQcrq
         UE9X7/owK4pFFr120iSpkHQ/MIfaAT1j53wpRD09a2tPSvN5JuoV6zdottSElHod32NG
         TkViQTrgyR7lnfzyzHswhct7dUJUj/wkc2ljqsLdxtfm2xdurLJztzc+bjnOicVFEADz
         rVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NzxJ/P5xI8k/+8qyQkcuciv21kLf2JEVcGByzZ1EjNM=;
        b=ntEw8tJ1Mi/ef7SgrB5jrONdTniNUjL1MPBGoUXgtP919C/eWU+7nOpYlWAzq44L78
         dt+smNlFGBmn3NLBsby3eiVLaIwpFDS0UEsPuVJPcADul4AgYuJNaw9vfZvie+SaYfhT
         2mFXWs9QBAs99eP7oYtvfqQtBkRoVaXujjleAZ5gDw8Zx8P60JT+uVgGpyQbG+WPYQxL
         L89+R0XpJGogNcC9xIGoIPNatdWFwlPr277/terU4OM5YHSkKs3DN6Q05393CxPbAnZy
         Tk5Wzz+Moj+FVjSWIylXxvOCW610kduakWymWC6IIy7cd+Dsv8FbMgT8P4NzevyVI70T
         9DKA==
X-Gm-Message-State: AOAM531U2wx2lv3qtYAvIigmzsK8gRgxcc4OVI9vA3InvyEvX2d4NG21
        7/bwRNVUO9uQAjSh69nepJfXo3KKwWI=
X-Google-Smtp-Source: ABdhPJypoSf+1rMUKxkMkqmM7OR85srgL+08UvwloivveZlUb6xXQGYYxEVph9OzKyIzBE1mwkImXg==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr12110728pgj.272.1636756704137;
        Fri, 12 Nov 2021 14:38:24 -0800 (PST)
Received: from [172.17.0.2] ([20.83.108.189])
        by smtp.gmail.com with ESMTPSA id f21sm2667650pfe.69.2021.11.12.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:38:23 -0800 (PST)
Message-ID: <618eecdf.1c69fb81.dd4d3.7201@mx.google.com>
Date:   Fri, 12 Nov 2021 14:38:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5707790505440990457=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] sdpd: Fix leaking buffers stored in cstates cache
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211112220538.310085-1-luiz.dentz@gmail.com>
References: <20211112220538.310085-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5707790505440990457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=579439

---Test result---

Test Summary:
CheckPatch                    FAIL      1.25 seconds
GitLint                       PASS      0.64 seconds
Prep - Setup ELL              PASS      51.41 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      9.30 seconds
Build - Make                  PASS      218.48 seconds
Make Check                    PASS      9.70 seconds
Make Distcheck                PASS      262.91 seconds
Build w/ext ELL - Configure   PASS      9.61 seconds
Build w/ext ELL - Make        PASS      209.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] sdpd: Fix leaking buffers stored in cstates cache
WARNING:NEW_TYPEDEFS: do not add new typedefs
#110: FILE: src/sdpd-request.c:45:
+typedef struct sdp_cont_info sdp_cont_info_t;

/github/workspace/src/12617365.patch total: 0 errors, 1 warnings, 393 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12617365.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/2] shared/gatt-server: Fix heap overflow when appending prepare writes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#89: 
Fixes https://github.com/bluez/bluez/security/advisories/GHSA-479m-xcq5-9g2q

/github/workspace/src/12617367.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12617367.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5707790505440990457==--
