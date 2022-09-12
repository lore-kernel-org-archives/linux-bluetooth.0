Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB19C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 14:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiILOEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiILOEP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 10:04:15 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE47326FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 07:04:14 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127dca21a7dso23592204fac.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=V/QIXxkQeoj0l2HpxB1xcj5ov2TE5fq8uF024zW6JdQ=;
        b=KuJN4nR5mHGpEZ+4ku+Yi7mFK27mmrECnhyXlarAr75YVdG28VYQp+xqiYgSvdT7nK
         s7bkzu02Ki4LyHAKcyIYFJuO3t88dP9FL3s+9lHhPJonR5ZIbJE4oOd3XqJh5xqaCRR8
         TbRgkesCg/9pIHLdpmZ4dQ7/C+yjLzfbuAyP8wUdeGFRvZJPy+/8ai8F+tgW7h/ahBbS
         DfOp05d9j4Iz/6/p8D+tqxMYEzERJhOKnwl9/4FZqS4quLZu4UlrkUv7LXbK43vJ4nKi
         qcoWm43+bHI5q0u2oiXeBy6+MrKGQWSg44+LhJHAFPxIR8CC1jLUJHUCGACksA62eSQr
         oHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=V/QIXxkQeoj0l2HpxB1xcj5ov2TE5fq8uF024zW6JdQ=;
        b=MqjRBVgDN8SSthdKdlZ9Yt4VwskpQTGj/T4aROCHxxV9ZPNJq0QXEUeU+pQj7m53Bf
         0QV1p5Sjszb+M1GKtSnXOAhmXCFuV9itGsTRsa6w25vHAlhN9H3ypDVsynitXxD4H8oH
         S5BQQBLp4UiVokmfZocxQJ3fOPgtKsl9MdtPFdqaZTIhB9pJeGdvvr4U5YWM+dg9VQEW
         iqEoqLTQ8zXNyqAEsFs4H689hNzatj7cxQ7Qdt0mYzkTF9d84CLM5oyjkXZf5t6rFH5C
         7cjlZHCH/LvbmOlIhFJwgzD7FWbTlEL6A7Y+Q8OExRcEpRUpGsCj+xgu8gGcGlmKiwma
         bHqQ==
X-Gm-Message-State: ACgBeo22S5ezhNh4w/GoMxoAnysEiABFwpmhlJnC3QaP6Fe/NH2dO5VR
        tOLjnplLHI/Oxrp0awSoY+VjbdFkDWQ=
X-Google-Smtp-Source: AA6agR6atlVBwRrzBOPvMfB9ci6r+4msZn8FjLMz+ipPHOzvDLRHSYgnyYy10tbJfwNIKxw1BQZdVw==
X-Received: by 2002:a05:6808:f89:b0:344:cab1:14e9 with SMTP id o9-20020a0568080f8900b00344cab114e9mr9414180oiw.82.1662991452941;
        Mon, 12 Sep 2022 07:04:12 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.99.212])
        by smtp.gmail.com with ESMTPSA id p43-20020a05687056ab00b0010bf07976c9sm5599988oao.41.2022.09.12.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:04:12 -0700 (PDT)
Message-ID: <631f3c5c.050a0220.3a4e9.d86a@mx.google.com>
Date:   Mon, 12 Sep 2022 07:04:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9052300305721752183=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: Volume Control Profile
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220912124657.404551-2-sathish.narasimman@intel.com>
References: <20220912124657.404551-2-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9052300305721752183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676220

---Test result---

Test Summary:
CheckPatch                    FAIL      5.79 seconds
GitLint                       PASS      3.00 seconds
Prep - Setup ELL              PASS      31.92 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      9.87 seconds
Build - Make                  PASS      1165.82 seconds
Make Check                    PASS      12.98 seconds
Make Check w/Valgrind         PASS      355.07 seconds
Make Distcheck                PASS      306.75 seconds
Build w/ext ELL - Configure   PASS      10.50 seconds
Build w/ext ELL - Make        PASS      107.90 seconds
Incremental Build w/ patches  PASS      510.36 seconds
Scan Build                    WARNING   1238.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/4] shared/vcp: Add initial code for handling VCP
WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#393: FILE: src/shared/vcp.c:302:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#425: FILE: src/shared/vcp.c:334:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#458: FILE: src/shared/vcp.c:367:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#491: FILE: src/shared/vcp.c:400:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#523: FILE: src/shared/vcp.c:432:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#555: FILE: src/shared/vcp.c:464:
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1051: FILE: src/shared/vcp.c:960:
+						value_handle, vcp_vstate_register,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1080: FILE: src/shared/vcp.c:989:
+						value_handle, vcp_vflag_register,

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1146: FILE: src/shared/vcp.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/12973630.patch total: 0 errors, 9 warnings, 1098 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12973630.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,3/4] profiles: Add initial code for vcp plugin
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#395: FILE: profiles/audio/vcp.c:288:
+static unsigned int vcp_id = 0;

/github/workspace/src/12973633.patch total: 1 errors, 0 warnings, 330 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12973633.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
src/shared/vcp.c:288:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:320:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:326:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:352:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:358:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:385:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:391:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:418:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:424:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (req->change_counter != vstate->counter) {
                                   ^~~~~~~~~~~~~~~
src/shared/vcp.c:450:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:456:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:482:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        vstate = vdb->vcs->vstate;
                 ^~~~~~~~
src/shared/vcp.c:488:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
14 warnings generated.




---
Regards,
Linux Bluetooth


--===============9052300305721752183==--
