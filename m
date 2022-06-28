Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0BCCA479
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 07:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiF1H3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbiF1H3D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 03:29:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998F1D0D9
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 00:29:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s17so12008822iob.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n1uH+7N4JYmj8mZ5pYk2FAaUSh2nuQ/J1t/bme6NG4Q=;
        b=bhkYeWGS26GXgtUrZpXiS9SuahfftHKTjLIzBDknU0nZgK2rduWzOpyS/aVDNVkBSL
         gFurTDrirAFipeRDWhBA0QZL6gzzXzlw1SOTBMXqj1k1ZRR273KXS7zUVJB/sgo/Nwfu
         gA/tD13aOvrwkoJiZUxTN4SO85Av45/tpJBof4Jk4UrZeURJbBQqBHcfBfl11F0pMA88
         RgS2EdFzx729bowtBR3WsaJ381pNXaNF14ptEL1zUUjbezaj9xxIv1hgH507kMD3wnU7
         pNywTYB0Lw9YhojTYscuwKnsP+fgJ+XW31B58iFGprrIMIcv4Oneia5azaSw76izGL2y
         0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n1uH+7N4JYmj8mZ5pYk2FAaUSh2nuQ/J1t/bme6NG4Q=;
        b=HdyoIGPxSzCtpzWTejFqKCpIcJh1TxN7y6NJ0z3xD5FKe8Frg6RlozKqqhEdvub4Pl
         fBYvVG1Z9qiOPaW8vEtTT5nCfmN5Yh2IYZrW9TnI8k//S8v04q+CZiL8FxudfbtMd9G2
         2xlHemQtbg87qiDwwWkxbx7YeMWB4Cz9ZDUIB7fIjXQP9nyPDio9EalEdlj0KPxZNzx4
         E0L1p9ns36pusMdcEnUHRjk4Sv9/udy8E1rLceY3oJuLTnwa9h6wpKyi9ln9cRZsvZFi
         4S7P3jkeX+giDqmgtPlbp1helLknkYBVUssJXdoi8tSxxGloe3Yl9cnxky9olC/CNELe
         n+kA==
X-Gm-Message-State: AJIora9JfM1Ipri0N5WmBuDOKlMIjXCCE1hbK6113ZB5JtiVv7EBe8en
        lz8WU46z48wPt854EXG7eXkBg9hp+EA=
X-Google-Smtp-Source: AGRyM1vXze/dz+t2AtvL7+ktQhH0ihQWeDgsEsQKscYPcgjnseTlSmN0m24rCgJ604B7zE3ORcMhcA==
X-Received: by 2002:a02:a311:0:b0:33c:957a:7d2f with SMTP id q17-20020a02a311000000b0033c957a7d2fmr6145636jai.256.1656401342164;
        Tue, 28 Jun 2022 00:29:02 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.14.102])
        by smtp.gmail.com with ESMTPSA id k6-20020a02cb46000000b00331743a983asm4330172jap.179.2022.06.28.00.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:29:01 -0700 (PDT)
Message-ID: <62baadbd.1c69fb81.2c701.49f7@mx.google.com>
Date:   Tue, 28 Jun 2022 00:29:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8942968137534558130=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix obex pointer is not null judgment
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220628060107.26070-1-wangyouwan@uniontech.com>
References: <20220628060107.26070-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8942968137534558130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=654450

---Test result---

Test Summary:
CheckPatch                    FAIL      1.22 seconds
GitLint                       PASS      0.79 seconds
Prep - Setup ELL              PASS      42.64 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      8.28 seconds
Build - Make                  PASS      1277.12 seconds
Make Check                    PASS      11.49 seconds
Make Check w/Valgrind         PASS      451.73 seconds
Make Distcheck                PASS      239.01 seconds
Build w/ext ELL - Configure   PASS      8.58 seconds
Build w/ext ELL - Make        PASS      1257.30 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
obexd: Fix obex pointer is not null judgment
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#69: FILE: gobex/gobex-transfer.c:67:
+    if (transfer->obex)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (4, 16)
#69: FILE: gobex/gobex-transfer.c:67:
+    if (transfer->obex)
+		g_obex_unref(transfer->obex);

/github/workspace/src/12897744.patch total: 0 errors, 2 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12897744.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8942968137534558130==--
