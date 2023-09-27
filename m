Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A72E810A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 08:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjI0ICL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjI0ICH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 04:02:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272B191
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 01:02:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27751ac0653so4617017a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695801725; x=1696406525; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eBDIoKGPPdoJfDVIVIQsDD5Jbk5F3yS6zYXq7oZ+AqI=;
        b=Ce4SQ7iHfxkdb5Ipw2oigvf5i0C+bPWDkamgf6AueAplxq/evUyQRegbr75N5gtTEN
         3QDh60n5uosvZMqpNETg6e1kMnD+ekLkTHxiZSFtq185rVRWz6BxDi9BZo0fx4gNzys3
         ub7oMhtjOhnLhHziFi4BxjfW2CQm/1bxojh4NtC7Jp/IwtowXQE79YJ5pb5/L4EqV8Y/
         r2wtArvKu/OIk9Ob4EyM26lwDw745b1dXYh59xEK6MErnoz4t1dW5DFhxDTZbPvc75TR
         SmVVEe7gsgLamX3mM9JjZJKTcBlvznGxFLdGQHEtdKsvIOIc+dPo5xET6F93PU3Z3cJ5
         LY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801725; x=1696406525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBDIoKGPPdoJfDVIVIQsDD5Jbk5F3yS6zYXq7oZ+AqI=;
        b=ai+zhvQjCznXTBf25UjQR6mMOD/MyR9+V7wfzfyEPfU6vwSQVSWrqF3TjUkIJwHuqY
         LxFfom+7SzpESYs4r5jdNEG7BSYLYm9E0jRN7H0JKnMCSg4bgqikLt/PqMEabxecYurl
         qpm/hijKjExcZJLm79L1B6IDXbDsTyinKda3G0e0CWjbJWXS0Uf61taU3EfH0ZX7wfae
         SNcnLX02GrJEQjywsqNwa2IY+sIZrbmvWTUrUgkmM0BLYqDdWFDZV4ZxAT0/Kwyg/dZl
         JoNfisU1FCIJnEcqlJupoXtjU5vsANrg75T/eQK1XeeK+0uHScOKs0Z+JcpuX64v8CtH
         pPng==
X-Gm-Message-State: AOJu0Yw6/S2oB/fAlSy9i4YomgMprOadjaO4BnBA8Yn7y6JgsiwS4oPl
        vAda+VLE5chlqbqelgwtj1lJC7TnLxY=
X-Google-Smtp-Source: AGHT+IHbS/aScMocJ4USQ9mX8oFXnoh+gdixuaCZBEF31s+lB8OQ3gQZP0m8WBFr+3uoafuf/LscpA==
X-Received: by 2002:a17:90b:194f:b0:26b:2538:d717 with SMTP id nk15-20020a17090b194f00b0026b2538d717mr878563pjb.25.1695801725288;
        Wed, 27 Sep 2023 01:02:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.11.208])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b00277724dbfc1sm3406572pjj.53.2023.09.27.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:02:04 -0700 (PDT)
Message-ID: <6513e17c.170a0220.5a61.ccd8@mx.google.com>
Date:   Wed, 27 Sep 2023 01:02:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0331185175356964561=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Memory leaks and memory used after free fixes
In-Reply-To: <20230927062436.6306-2-andrei.istodorescu@nxp.com>
References: <20230927062436.6306-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0331185175356964561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=787894

---Test result---

Test Summary:
CheckPatch                    FAIL      1.11 seconds
GitLint                       FAIL      0.77 seconds
BuildEll                      PASS      31.36 seconds
BluezMake                     PASS      957.44 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      181.99 seconds
CheckValgrind                 PASS      305.45 seconds
CheckSmatch                   PASS      415.94 seconds
bluezmakeextell               PASS      126.55 seconds
IncrementalBuild              PASS      1631.48 seconds
ScanBuild                     PASS      1338.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] bap: Remove memory leaks and buffer usage after free.
WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#216: FILE: profiles/audio/bap.c:387:
+	/* Update caps and meta with received Codec Specific Configuration and Metadata */

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#251: FILE: profiles/audio/bap.c:824:
+	/* Update endpoint with the value received from the peer's (BAP source) BASE */

/github/workspace/src/src/13399999.patch total: 0 errors, 2 warnings, 150 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13399999.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/2] shared/bap: Set stream lpac to NULL after removing the stream.
WARNING:LONG_LINE_COMMENT: line length of 111 exceeds 80 columns
#119: FILE: src/shared/bap.c:2685:
+		stream->lpac = NULL; /* mark stream->lpac to NULL, as it will be freed in bt_bap_remove_pac  */

/github/workspace/src/src/13400000.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13400000.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] bap: Remove memory leaks and buffer usage after free.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,1/2] bap: Remove memory leaks and buffer usage after free."
[BlueZ,2/2] shared/bap: Set stream lpac to NULL after removing the stream.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,2/2] shared/bap: Set stream lpac to NULL after removing the stream."


---
Regards,
Linux Bluetooth


--===============0331185175356964561==--
