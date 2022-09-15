Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57220ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 11:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIOLgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOLgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 07:36:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D665A3F1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 04:36:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so18051239plr.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=lG8EmjPLe90XPzcZN5is2xNLrt9HQQbd9wk3UgIULP0=;
        b=gVdq3nkn/wC+TWue169im64AbJcRiBWNyYuct9ROcN0wdhacfBGvFgmAGk+ot1pbmn
         vTHvtj+BMpkhTKhxWNebhAetvSCCtRWaUAtSuc/ChVfLaUQOwpUXtgJaZWdZ3kidB9ry
         Srom2KFrbmS4eB0qopbz16JN0asQrHrnkyEDQkS4VS/vmAGVjasEuXBOZHDsUMymCAtP
         YZCHdZSXZ0aucGa333nZJrRIZJr7035m7mu6rGHgipd1pWNlibIRSJ/s8aOdPj0YWtST
         Z2cP2HTOlzznu0Ou9PXNWtbTfPs30thFiSfki0IWWfG6qIO+2cvP/OuD9BxNJrnL14yW
         HnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=lG8EmjPLe90XPzcZN5is2xNLrt9HQQbd9wk3UgIULP0=;
        b=oDN5Tu7AAo5idqpmviavqf/BZZMrPWf/8iTGiJGuIiIZUZ2jdw651TzNEdnphouLop
         hrT0d739534OFo85tMgHGEn3cbRqHaLccZfxbSrsXF5pTXkkWPY1dxB7SAPvA/XdQk0H
         N1yyOKF0epqjBem+Tgg6hre3CQaP0LmUi5FLc+tW6ZxoClKYc5xlCJCknp2L63+/83sH
         hkpLeE36ImSgGKJBYbi8dejKsSpNPHB9VocOT/nWEWoF9EBeKp45a5d65x9blIzwehI0
         0iw0aJaIz27AYhwMviG0IacAhYDMtzsUHXA+fpYOnbyE+EfPv5gGmSuAtiBhVSTXhpoI
         87zg==
X-Gm-Message-State: ACrzQf3Wots2GKoSMOOBy1/eLG7foccWCR37/xN1VWiEDnUqtM++8Uc1
        907IiIUdJgeqIrI7jAgiOSKw8TuGgY4=
X-Google-Smtp-Source: AMsMyM6Z5it8r6Q6xRQtXsPIwpIBGTW5V5DHCdObIqN1lWASsadi+Fu38Uy6a2bygsuJJH7vDbCvCw==
X-Received: by 2002:a17:903:11c7:b0:170:cde7:d24a with SMTP id q7-20020a17090311c700b00170cde7d24amr3940233plh.91.1663241809949;
        Thu, 15 Sep 2022 04:36:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.72.135])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b005367c28fd32sm12123942pfj.185.2022.09.15.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:36:49 -0700 (PDT)
Message-ID: <63230e51.050a0220.6c72d.5248@mx.google.com>
Date:   Thu, 15 Sep 2022 04:36:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6137940332675989445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,v2,1/4] lib/uuid: Add VCS UUIDs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220915095412.462210-1-sathish.narasimman@intel.com>
References: <20220915095412.462210-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6137940332675989445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677268

---Test result---

Test Summary:
CheckPatch                    FAIL      4.02 seconds
GitLint                       PASS      1.89 seconds
Prep - Setup ELL              PASS      33.60 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      10.44 seconds
Build - Make                  PASS      1169.04 seconds
Make Check                    PASS      12.60 seconds
Make Check w/Valgrind         PASS      356.41 seconds
Make Distcheck                PASS      304.10 seconds
Build w/ext ELL - Configure   PASS      11.04 seconds
Build w/ext ELL - Make        PASS      108.76 seconds
Incremental Build w/ patches  PASS      511.45 seconds
Scan Build                    WARNING   1239.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2,2/4] shared/vcp: Add initial code for handling VCP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1154: FILE: src/shared/vcp.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/12977204.patch total: 0 errors, 1 warnings, 1106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12977204.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,v2,3/4] profiles: Add initial code for vcp plugin
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#395: FILE: profiles/audio/vcp.c:288:
+static unsigned int vcp_id = 0;

/github/workspace/src/12977206.patch total: 1 errors, 0 warnings, 330 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12977206.patch has style problems, please review.

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
src/shared/vcp.c:285:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:318:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:327:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:351:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:360:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:385:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:394:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:419:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:428:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (req->change_counter != vstate->counter) {
                                   ^~~~~~~~~~~~~~~
src/shared/vcp.c:452:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:461:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
src/shared/vcp.c:485:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
        if (!vdb && !vdb->vcs)
                     ^~~~~~~~
src/shared/vcp.c:494:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
        if (*change_counter != vstate->counter) {
                               ^~~~~~~~~~~~~~~
14 warnings generated.




---
Regards,
Linux Bluetooth


--===============6137940332675989445==--
