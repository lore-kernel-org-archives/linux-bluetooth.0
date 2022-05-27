Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiE0Abn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 20:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiE0Abm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 20:31:42 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0013F7D
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 17:31:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h186so2636364pgc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=l0jfIWG3lQre23iyESSxO1aNkcoPRfMXLo24kgxxbpc=;
        b=auw6l6xm3O8O4pGj9zKKi8d2Ae7HTN8AOEoH4SO2jqmX+h1iVfJOF3wd7pouObtU8u
         BlAr6iNb42//7c5WEEN4JKFap9BBxJDlD+Bn/63pdEdxpgf6Ph29pJy3GtSeEHgsCwOH
         HtRVPopbxd/itbQKReIw7YXskYM4MqrMyyZYxAlKTCbkMGt2Tr7Pq5LGcB6/T6CFUoJ0
         24BhL7OSsIgFD7n9Wkq/uqZ4nTslI/8tYACiHohWGmNg4fcQvG7agC1RJHtYywGLxmLI
         2EDkSes5mOGcHc8HxIfEbYdBPnb35wpyO33P0CxVfDavMFPNKqEgRHa6javUdtc/oS1j
         MPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=l0jfIWG3lQre23iyESSxO1aNkcoPRfMXLo24kgxxbpc=;
        b=G3zG91SLmnmB6J4Q6p3bnVNSbKNgd5i0YnhhSni9KgCdc7RWNmKkgPOlX3zQ3cm/li
         CVd4bwv48DXuVFgzwy06kT+LAMHjJZ5uU0+SprgFL7lj57p0U5owYTxjEq//ghNmT/ow
         8tzXg4Mh/2Lj8expvKp7oB4oiI4xD8d6PfvedyWqOIsmOu8b2k47QdzcQwUiPIaR/6zn
         qxsCp2R7g+KKi/pfFRR9BGnNmchgOeeWxsi5PS7zbrFGpUm2hddSqtFKioHIyHWs3wwr
         GfTa2/Eex20vdrsi8F21q8U/EgVZfNGEJxWyLtv5viD0hax3YewnEIsfaDEuSWcgJRjo
         VIkg==
X-Gm-Message-State: AOAM531KRlUPYje1o+1+/9DR2I/MHaq3NtuT+/hQKbMAqT91hKx5swNn
        bpSogY1hj0UcbHmcFEYtpj3UQXKIog8=
X-Google-Smtp-Source: ABdhPJxm2BwmuF2i/C3g7mwcoOTNmmjBWSmpGfL/XV8UM+AyRl27SlIRMd0i4LuDm7f4dPX7PyP1dw==
X-Received: by 2002:a05:6a02:206:b0:399:3c9:f465 with SMTP id bh6-20020a056a02020600b0039903c9f465mr36072949pgb.388.1653611499688;
        Thu, 26 May 2022 17:31:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.218.34])
        by smtp.gmail.com with ESMTPSA id cd21-20020a056a00421500b0050dc7628175sm2013121pfb.79.2022.05.26.17.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 17:31:39 -0700 (PDT)
Message-ID: <62901beb.1c69fb81.6a4cc.4fbc@mx.google.com>
Date:   Thu, 26 May 2022 17:31:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1127574747056670399=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] monitor/att: Simplify CCC decoders
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220526205937.4159665-1-luiz.dentz@gmail.com>
References: <20220526205937.4159665-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1127574747056670399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645406

---Test result---

Test Summary:
CheckPatch                    FAIL      3.81 seconds
GitLint                       FAIL      1.81 seconds
Prep - Setup ELL              PASS      50.69 seconds
Build - Prep                  PASS      0.58 seconds
Build - Configure             PASS      9.45 seconds
Build - Make                  PASS      1699.16 seconds
Make Check                    PASS      12.03 seconds
Make Check w/Valgrind         PASS      505.71 seconds
Make Distcheck                PASS      265.28 seconds
Build w/ext ELL - Configure   PASS      9.39 seconds
Build w/ext ELL - Make        PASS      1683.63 seconds
Incremental Build with patchesPASS      6830.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,3/4] monitor/att: Add decoding support for ASE Sink/Source
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#95: 
      Channel: 64 len 51 sdu 49 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}

WARNING:NEW_TYPEDEFS: do not add new typedefs
#188: FILE: lib/bluetooth.h:380:
+typedef struct {

/github/workspace/src/12862782.patch total: 0 errors, 2 warnings, 610 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12862782.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,4/4] monitor/att: Add decoding support for ASE Control Point
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
      Channel: 64 len 26 sdu 24 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}

/github/workspace/src/12862783.patch total: 0 errors, 1 warnings, 904 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12862783.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[v2,3/4] monitor/att: Add decoding support for ASE Sink/Source
22: B1 Line exceeds max length (86>80): "          Data: 01010000000a00204e00409c00204e00409c0006000000000a02010302020103042800"




---
Regards,
Linux Bluetooth


--===============1127574747056670399==--
