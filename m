Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26608C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 14:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355107AbiBNO1D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:27:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbiBNO1D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 09:27:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C92D50
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 06:26:55 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h9so14899005qvm.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sB/gwTkpOjeWnPndDcdrRGT41c4uvF+55wgbKFrSHoU=;
        b=cvUVi0ZdpCXteMLLAyhcPUePq8AigQlw5xMf8H19WtgZsbCtkmr19+AywxR6wcfnX+
         mH44guRazrrJrtWd7NFHiPDlCo6sOkrPdDqTfTttQ6ackMYAMabUWlFiD/ZcNMM91+Or
         Qtxvtdfx8laIXqY3UnT/71GP+t1ZRHo4lasIhY9R6XIhtl1YhFlvw/2icJTzfow2dqCe
         UPqNHPNux11owD79mg59/MNYNdd8mpjwnpjRnHo74gEhf83IcU5Kbn83ISKKLyld6zhH
         5cPzg7Nt/D5hQL7/a6S2dEKkgJNHusNuVlMING6Yn+VQce6OzIYhtcuKJjsYJo5MgD1Z
         aLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sB/gwTkpOjeWnPndDcdrRGT41c4uvF+55wgbKFrSHoU=;
        b=IFLmN7Ij39iRQEVHewQShbTWgMRNctCtDekX7cSrm2fcIS414+XrIdKSGxEe0z8LVI
         7dvlW2rD69XVtjcKe9gBK2Y+4auGQf6KsLMatgcNXRjGhVjNVsQPJ17C4cRQ5qKl9GAW
         8rR7yeSjPVbEgVoGmDjw4WqY7K5Pzekk/tZQmVBeSZ0Dh/eJ18lrOEEybknlqDnWuCPB
         EvhtcYHqxOuIcPooj5UXNCmYi0Sxx0FGbIZDCU8FyGcyrYgGuVugQHETVW+FFgZCdrPj
         J93jCawtgiPOLFs4fcJxCdQt4eg4SKcQbYZ5tvmXDolh7CBdRafJD6MBSoMCqLJOiiNf
         6Myw==
X-Gm-Message-State: AOAM532eorQDpes3nlB9GYAgBEFjxDuXg5nkwSZOP15rMpbT2Fyr1VA/
        l1g1x9bVW4X4NciTwW/EwtKeZm9GqylLig==
X-Google-Smtp-Source: ABdhPJx+JoNKudyq3Fg6sf4rcNEMFWuFTFDGgJDCo4vmPCYWmA7Ah0YnxehJB2ypFwe0oEqCHkFN8Q==
X-Received: by 2002:a05:6214:4006:: with SMTP id kd6mr9589874qvb.70.1644848814182;
        Mon, 14 Feb 2022 06:26:54 -0800 (PST)
Received: from [172.17.0.2] ([52.167.121.185])
        by smtp.gmail.com with ESMTPSA id d15sm10974881qtx.30.2022.02.14.06.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:26:53 -0800 (PST)
Message-ID: <620a66ad.1c69fb81.48cc6.c40b@mx.google.com>
Date:   Mon, 14 Feb 2022 06:26:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1844719363374713076=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: [BlueZ] fix build with glibc < 2.25
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214131451.2397549-1-fontaine.fabrice@gmail.com>
References: <20220214131451.2397549-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1844719363374713076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614113

---Test result---

Test Summary:
CheckPatch                    FAIL      1.52 seconds
GitLint                       FAIL      1.09 seconds
Prep - Setup ELL              PASS      42.43 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.54 seconds
Build - Make                  PASS      1374.98 seconds
Make Check                    PASS      11.33 seconds
Make Check w/Valgrind         PASS      440.73 seconds
Make Distcheck                PASS      228.35 seconds
Build w/ext ELL - Configure   PASS      9.06 seconds
Build w/ext ELL - Make        PASS      1360.65 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] fix build with glibc < 2.25
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html

ERROR:SPACING: space required before the open parenthesis '('
#276: FILE: profiles/health/hdp.c:1505:
+	for(i = 0; i < HDP_ECHO_LEN; i++)

/github/workspace/src/12745617.patch total: 1 errors, 1 warnings, 201 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12745617.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] fix build with glibc < 2.25
14: B1 Line exceeds max length (82>80): " - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2"




---
Regards,
Linux Bluetooth


--===============1844719363374713076==--
