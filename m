Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 04:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbiBKEgf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 23:36:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBKEge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 23:36:34 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9ABF4B
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 20:36:33 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m25so7243053qka.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 20:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QkfRC/fdSLJ9OxvFdgRaTtYxS1h4i0bUViXlDOgOD4c=;
        b=GIgHLXLCaaZ3FD0+s0ijcrjjWVPI83Ekd/ppZKRX0Xlb2vbdcXrAdD7WylADUFXXDq
         b+rVq5K4ZV46jAqxmYJjetYdm63h01R96WDq/cZINpkH3MNUfg5qtozZWpiYs8M0FbcI
         y6dYr2lkstYyt55SLI2fqjj+1ofwSenveAjumTAkiZDtYhaFNoF2ytrkZBFYz7MgKu5L
         071kqGO6vtRbJDwIz6BkVIIJs7k1evLRq6Zq411HOrYxL1W6SFDyIBCyVMSnzZFpcH2K
         0RWNLvniZvNxsK/JtBE76Hthb3h0umdF6v2mi77yOSJJWZlR8+PYtZYwU9ZrC1HgPK8u
         kvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QkfRC/fdSLJ9OxvFdgRaTtYxS1h4i0bUViXlDOgOD4c=;
        b=n/h2NQhrMtAYrPeqKkgl/ZjEcJWMJlvKjdiVoMFneE/bqx+ErIUAFkiIoYMD4qoLfA
         8wmIW8TWnIU2HALEavOalLjW/RlcoNd2s8yF8GgkqNtOcb1mdjEWC+D2nPtLfo2j83a6
         5wWLbVbCGIHsuQvHIi4bcZmiN64nrbuenkrPqCTsXm7/H0oxlJJfI3G5tt/QDIf3GgNv
         yIidEqv2h5OdmjUiv+mcOM4L1Erq2hWIpNGeJ287lhhm6s0HEEltS8gK3H3fnYCqvT4o
         yhcIXIwVhMnJPtRJc592Na+NxYEV4XCcxPhtZDZqSMptiXnJ0H1h5aIA21lAOrwJ9279
         nJrw==
X-Gm-Message-State: AOAM5305Bpmm9L/h//tBg2Q28cd+999rqPB5sn2xZBPWuS97rEZmSnuL
        Iev4zxWg++fxKIVD90qG2XG7Qiqssmg=
X-Google-Smtp-Source: ABdhPJxcBFH8T2tUdE/neMp1z0a+k19Af9WV0rpZAKlh4Oz+Fj256XdwS6ncZ1i/KdY16r3WZ5KLaA==
X-Received: by 2002:a05:620a:568:: with SMTP id p8mr5439407qkp.754.1644554192596;
        Thu, 10 Feb 2022 20:36:32 -0800 (PST)
Received: from [172.17.0.2] ([20.186.171.46])
        by smtp.gmail.com with ESMTPSA id f20sm12636763qte.14.2022.02.10.20.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 20:36:32 -0800 (PST)
Message-ID: <6205e7d0.1c69fb81.102b5.64a7@mx.google.com>
Date:   Thu, 10 Feb 2022 20:36:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4038580468313425445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] adapter: Fix the reusing gerror without re-initialization
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220211020054.28534-1-hj.tedd.an@gmail.com>
References: <20220211020054.28534-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4038580468313425445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613299

---Test result---

Test Summary:
CheckPatch                    FAIL      4.50 seconds
GitLint                       PASS      3.01 seconds
Prep - Setup ELL              PASS      50.45 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      10.03 seconds
Build - Make                  PASS      1468.32 seconds
Make Check                    PASS      13.11 seconds
Make Check w/Valgrind         PASS      521.80 seconds
Make Distcheck                PASS      271.79 seconds
Build w/ext ELL - Configure   PASS      10.13 seconds
Build w/ext ELL - Make        PASS      1440.75 seconds
Incremental Build with patchesPASS      4447.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/3] adapter: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '2287c517ca1bd', maybe rebased or not pulled?
#87: 
Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")

/github/workspace/src/12742678.patch total: 0 errors, 1 warnings, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742678.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/3] device: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '6a154cd08000b', maybe rebased or not pulled?
#91: 
Fixes: 6a154cd08000b ("device: Fix unchecked return value")

/github/workspace/src/12742680.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742680.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,3/3] profiles: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '4ad622d592ba5', maybe rebased or not pulled?
#90: 
Fixes: 4ad622d592ba5 ("profiles/a2dp: Fix unchecked return value")

/github/workspace/src/12742679.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742679.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4038580468313425445==--
