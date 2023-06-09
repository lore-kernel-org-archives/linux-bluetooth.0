Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D2C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjFILdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFILdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 07:33:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193C2D68
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 04:33:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b24b34b59fso6868325ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686310430; x=1688902430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kpcy2K+kpp02wYkbn+Vc2BP3gkrPUcGoVnE8mqdBOI=;
        b=gMGclU+DcKzqXAqgfPX2/yyCOFAxIX3mA909tBFRGrYaARPqSQO88+S6kFzmqTnySf
         dgsmsG3SSDKVsolnzkNs7Aom9So/Hs3EljYA+TdCgb0yflJk1ldf2uagmlRWy649F/BM
         5phmeO58XRrJmq0PnCNb2qpchGjpAxT9hg2zTP9jUNR1NCkIEaC1F9ZX5Gra9ZGDkI8i
         gMJM3+yrG1zHkrw4eMXZbjFEpFZFWOURJGpaFru73TEQGp6hckVzPjy1r/aAD8CXsdcB
         5iRd54S/hssAWRd8D4Xno/eA7Hb1vAK+iP6qoKr1oF8Qr9gmJy+7CBsoM3A/SaVIthhi
         W7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310430; x=1688902430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Kpcy2K+kpp02wYkbn+Vc2BP3gkrPUcGoVnE8mqdBOI=;
        b=mAUpX36W4IlDY9lyXdwFbh6vnXAhaOXaMaZDXsz77Sr7jJ/e5dB9qYb0mf1nJbOkQ0
         wzSw0Y3RVQysMRFMmqIEamDzoX0CxOPnZlN4PssrC5OTFUhnjNYib1iQouid2DBRBAKb
         LxbthAuRE9r6PGPny6gt5oiVYb77iazvTU8q62CIR4TtRFDRiFINK9e1EkBiFwzedFIm
         a59BiDwceNqYXKSxaqXZ0rsdexb3Crfu/sZcABiPLoBBchwtpObTD2DUPbW49IsoWEen
         UvNBvKndBWRY0BSKToXqJ9+W32quXF46spkbgduIkgu6jlFjeyYU1uvEI9AKUUJW+pN8
         bFhQ==
X-Gm-Message-State: AC+VfDwKUBY+U1xBWuDlxPDuiaPYKEtWyoR8VtHv5Op1kqcbWdUwxKIF
        whP54Y+R5gcI5F4N2GbKE1gaS+6jf+Y=
X-Google-Smtp-Source: ACHHUZ7E5UAEaIXDFsu7cyGeZoMhUO24fFSCzmXzL8dGb96oR4dgGRxsasin2odqd23TGGgXVhL4Ew==
X-Received: by 2002:a17:903:10a:b0:1af:e8cf:7004 with SMTP id y10-20020a170903010a00b001afe8cf7004mr801729plc.15.1686310430145;
        Fri, 09 Jun 2023 04:33:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.134.176])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001ab09f5ca61sm3084712plg.55.2023.06.09.04.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:33:47 -0700 (PDT)
Message-ID: <64830e1b.170a0220.4f53a.6075@mx.google.com>
Date:   Fri, 09 Jun 2023 04:33:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1370918619152158563=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Code handling for VOCS service
In-Reply-To: <20230609094222.1877-2-nitin.jadhav@nxp.com>
References: <20230609094222.1877-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1370918619152158563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755637

---Test result---

Test Summary:
CheckPatch                    FAIL      1.80 seconds
GitLint                       FAIL      1.07 seconds
BuildEll                      PASS      26.82 seconds
BluezMake                     PASS      800.72 seconds
MakeCheck                     PASS      11.56 seconds
MakeDistcheck                 PASS      156.44 seconds
CheckValgrind                 PASS      251.76 seconds
CheckSmatch                   PASS      338.54 seconds
bluezmakeextell               PASS      102.96 seconds
IncrementalBuild              PASS      1994.60 seconds
ScanBuild                     WARNING   1038.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,2/3] shared/vcp: Add initial code for handling VOCS
WARNING:ONE_SEMICOLON: Statements terminations use 1 semicolon
#577: FILE: src/shared/vcp.c:1259:
+	uint32_t *vocs_audio_loc_n = malloc(sizeof(uint32_t));;

/github/workspace/src/src/13273599.patch total: 0 errors, 1 warnings, 677 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13273599.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,3/3] shared/vcp.c: Make VOCS (Secondary) as an included service of VCS (Primary)

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (90>80): "[BlueZ,v4,3/3] shared/vcp.c: Make VOCS (Secondary) as an included service of VCS (Primary)"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/vcp.c:1275:2: warning: 5th function call argument is an uninitialized value
        DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/vcp.c:31:2: note: expanded from macro 'DBG'
        vcp_debug(_vcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1370918619152158563==--
