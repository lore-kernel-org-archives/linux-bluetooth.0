Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC96C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 21:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiCWVuA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCWVt6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 17:49:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBF74628
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 14:48:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c4so2410809qtx.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FkCINMXZXDTkUOTaTKPw5IaHCmLgRCiYNW+tv2ha4Io=;
        b=klIRqPbmJFToFqvrdyjkmpUHZzPH3cc/iISxgYkmTBclxKCWEE0nvffpG/wPvTwh1D
         L30wLpklCXYCvk8TEklExaEiVthQVysdR7Vv/vgz+jCOk0vSCeSPJBSc+a4lJpCN/JL1
         CLrColFIVI24M6ccBJtVyAPdo3aFb1onDXTZrhwIOK5MBn9qLTlLbOtx+6gTj/jV0GpG
         UDRsw/rCzLEBv3j+myOjK1y2Y1yFIZA+zPWuowDsi6edZdFGcWUi+SOwgXJ6OwR7eCCp
         ChIkMvp7mEPCjyUFYUoTI+Dj5YtDIAQ0gggZGJn40cphx3vZzIKaFiYv51+u/hToYtAE
         voSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FkCINMXZXDTkUOTaTKPw5IaHCmLgRCiYNW+tv2ha4Io=;
        b=MwU530mOZE7EjW3119AV11MFkxSvL6ysl4o54Jq/NASuHaHnmGWF+OIovXvHmQvgDV
         d7uVshWwzIOO3F9awAdhI6JlVj6f33taW1UMB60uc+XtJHV3Ts2lLGtJIfsvSKnm62nE
         rO9pZZnXQpgRe3jlmST+D/rCxyFYaC3gu8z+VRpW5Y5xFEPDc87nWYG1Wc5EPhD96kSo
         qcLLilIkleiYIV50HZ8EyXWTWrc7B+zu+A5vsUW2mIh8EELRUQ3oGFUloC/77bS+Aokw
         UJfYSjLR1yGqfmGYvFNgd1fVXX9PpEWtXrBFixJCGrP+OChIUZP04VIQdkgzJ/hs2c/R
         e4aA==
X-Gm-Message-State: AOAM530TgYTjYLgwUkpxiHUcSOAzybzL3ZXtbgjkb2twMGxYhrrngAvu
        5hO5I0LayPgvT8yuxtEALng5puk9pBIhnw==
X-Google-Smtp-Source: ABdhPJxeuy3R9lUoR2kpq21tVjBhcCWk1Kt2/xjHN1Xiftfd4f8tZEA6SImB47zG5gDiY42xjcZT0g==
X-Received: by 2002:ac8:5b04:0:b0:2e2:24c:779e with SMTP id m4-20020ac85b04000000b002e2024c779emr1794526qtw.211.1648072105523;
        Wed, 23 Mar 2022 14:48:25 -0700 (PDT)
Received: from [172.17.0.2] ([13.92.210.21])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm581709qkm.66.2022.03.23.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:48:25 -0700 (PDT)
Message-ID: <623b95a9.1c69fb81.7328d.4fa9@mx.google.com>
Date:   Wed, 23 Mar 2022 14:48:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3900406685938321461=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3900406685938321461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625844

---Test result---

Test Summary:
CheckPatch                    FAIL      1.48 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      53.03 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      10.48 seconds
Build - Make                  PASS      1791.20 seconds
Make Check                    PASS      13.00 seconds
Make Check w/Valgrind         PASS      544.97 seconds
Make Distcheck                PASS      288.12 seconds
Build w/ext ELL - Configure   PASS      10.67 seconds
Build w/ext ELL - Make        PASS      1772.81 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#109: FILE: src/log.h:60:
+	DBG_IDX(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
 	                                                   ^

/github/workspace/src/12790082.patch total: 1 errors, 0 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12790082.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3900406685938321461==--
