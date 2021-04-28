Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B567C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5572C611BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 06:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD1GtB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhD1GtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 02:49:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F922C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 23:48:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z16so3128744pga.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 23:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Qf7jrWklRMPbQz/aiSl4WZ+FYvkwvBN4KEiwaVg4djo=;
        b=TWT6V8Dpl6zAvWR39yN2ScMUP4cWy6N0J26C6V+/MI366GG3n3dbIDQhGK8fflMEIN
         G0nVZ27XwTIB3dz08/DLzWfIxaJy6WeX+hktfViUSLGqgGrJ0OPnNyNPViTNlTuB/mgD
         80Pp/GlyckdrzsytJV+dyZWniD4SP8gmQJM0bJfR5JsAZCa+k3BthUO3BaVLDH4tP0KX
         w4YUoSp+OtRNcJcU2OUr//G+S3dCFnmpF839jygTDR6x9oNRY6MgkFBRTCq4iYNu/LrZ
         6ziLAga8Jj3ZmQ+Rs08uwLHi3yyG7S7mFOy4O6RxVzQdZ1xkVKxgNXn472NF6xipqT5m
         u4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Qf7jrWklRMPbQz/aiSl4WZ+FYvkwvBN4KEiwaVg4djo=;
        b=cOJqxxjDhD9IzXf8bzVUAcGMbVkRt0bx3x2MGl4eGt7PVxno8cvFdM2YuJnKps4HuL
         /DbnWGQpsvQaG0vdo28w0W/Rp5A3xXvuIqm4K3k6l53KTG+QwRzEI8iyxz8mNJ9NFOFy
         c0yngstmAPlWJOwPGUtBmJ7e/5OSpTHd9/2D2Xah3vsSKFUAiqH68W6f6qJRAFfgkaHn
         25Od5VYsop9CscM0r2J69IrV/AgIvWGGmDAQmiiEq34xs/1/drygMp6HUIOEJdb8rRd+
         MX2t8wqqmTfUqItvDgd3yUjdCnTTlcv+KEdE3qaqBZ7VUW1VTNhjnicDkzN321+CPrF8
         v1Bw==
X-Gm-Message-State: AOAM530jBn1+YmRxnY+v3ur9C7xeOEKOBIxlKJu2nNg1wEgZ/eOq4L5t
        gCMxdg3HmHRoLp6G+b9kRrIzMT7Py1c=
X-Google-Smtp-Source: ABdhPJwyX+PGwWnfE1esBcp48iMa/V8Gphk79N5VB84ZRQFYw16S2ZDmlgZQ4qm6vwMb3bfXo94sbg==
X-Received: by 2002:a62:2cb:0:b029:259:feaa:75e7 with SMTP id 194-20020a6202cb0000b0290259feaa75e7mr26310896pfc.24.1619592495374;
        Tue, 27 Apr 2021 23:48:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.243.179])
        by smtp.gmail.com with ESMTPSA id z29sm1466620pga.52.2021.04.27.23.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:48:14 -0700 (PDT)
Message-ID: <6089052e.1c69fb81.f1c34.5801@mx.google.com>
Date:   Tue, 27 Apr 2021 23:48:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1966273398624010554=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] monitor: Update manpage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210428062214.335567-1-hj.tedd.an@gmail.com>
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1966273398624010554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=474313

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.61 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.24 seconds
Build - Make                  FAIL      197.06 seconds
Make Check                    FAIL      0.65 seconds
Make Dist                     PASS      12.74 seconds
Make Dist - Configure         PASS      5.11 seconds
Make Dist - Make              PASS      79.62 seconds
Build w/ext ELL - Configure   PASS      8.24 seconds
Build w/ext ELL - Make        FAIL      185.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Update manpage
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#140: FILE: monitor/btmon.rst:1:
+=====

- total: 0 errors, 1 warnings, 240 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Update manpage" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11668: monitor/btmon.1] Error 1
make: *** [Makefile:4069: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11668: monitor/btmon.1] Error 1
make: *** [Makefile:10324: check] Error 2


##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11668: monitor/btmon.1] Error 1
make: *** [Makefile:4069: all] Error 2




---
Regards,
Linux Bluetooth


--===============1966273398624010554==--
