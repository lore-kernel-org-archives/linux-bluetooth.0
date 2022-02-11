Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42AAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 03:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiBKDy4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 22:54:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBKDyz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 22:54:55 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBD1125
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 19:54:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id k9so7305505qvv.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 19:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VYCsTA22EDnMfLFs/3Qu5lmIRRgnjjhMPj9EbQRZBYo=;
        b=XUQZdMCNPP6nIvt6vC7YS7vKbNCrBks7IrTlMoP/zp2aEPA8fX7T31x+XCOgodUnv1
         7AALqBaf1pKd7FLArKmwJjEcpanaRgy98Ivr4wt0rfLUcdXhzkKGvilp3Q+WZfnaRZ6u
         N6Uj4fQzK8qepBJv70r1SLmZyIVVJt7Vwmi7E8ERHVgEKi/+PxkVw9ckfhUSVJampXan
         sCNiRaiSwh3ho2Lkg67XEGOEi0jjgbr4nJjc9OPUyRXYZBNyVeSh1Hv3K/i+sSfh4y96
         PZcnTrWnS7YlRmnNg8Ka0H3xquPXzAJbxfZAvccu713XaNa4Jozfq6o3aRGZz0f8Rt16
         6jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VYCsTA22EDnMfLFs/3Qu5lmIRRgnjjhMPj9EbQRZBYo=;
        b=tU5hDvaFDk9BZzItE4aUqB65yzvzN/mfPfxa36nA+4+1BFpd39Gz3936PcqrTMd+zF
         mnNqrOcxmswifwranXV5t0rLu9kdZGbSZR6qmYw9UrMmHLGeHbvOk7bvnQjUhXojjNyv
         CWgOlRC2pu4Y7hQRVWNb9NxTo6T+/hHS5yGHrgXCME3iicUvC26pa6LcO4N1WAJlc6SX
         e85aa/ES/0LySMb097v2P7eHvPCU2vTUuuDg7N1ZaE8dlJ45wp0swNwYr0azMDRBymww
         b1izSRyuxj/bGBtfzu5yCDZ5YtjeZ0uIWx0KXLwKdaDcwUA622ulI4+sxLkVm7SVBwu/
         P4mw==
X-Gm-Message-State: AOAM530kQ/2hY0gq6byS/hO1dvrLzqZxcFokKcRz+p/66rruj5psMk3N
        3T/32OwYUWjLXq6TCUb2gxIe5SSF3wg=
X-Google-Smtp-Source: ABdhPJwjRv6INh5fIgVZ4a1sclqI0KfwFuyBK12eI2DlfZjrB8D554m+UStynpl8M3u4yYDV/QnKyA==
X-Received: by 2002:a05:6214:f69:: with SMTP id iy9mr4401111qvb.108.1644551693757;
        Thu, 10 Feb 2022 19:54:53 -0800 (PST)
Received: from [172.17.0.2] ([20.110.11.197])
        by smtp.gmail.com with ESMTPSA id p10sm10893459qtx.62.2022.02.10.19.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 19:54:53 -0800 (PST)
Message-ID: <6205de0d.1c69fb81.2da5b.d428@mx.google.com>
Date:   Thu, 10 Feb 2022 19:54:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4494473924747014226=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/4] adapter: Fix the reusing gerror without re-initialization
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220211001840.22566-1-hj.tedd.an@gmail.com>
References: <20220211001840.22566-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4494473924747014226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613281

---Test result---

Test Summary:
CheckPatch                    FAIL      5.88 seconds
GitLint                       PASS      3.93 seconds
Prep - Setup ELL              PASS      42.74 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.53 seconds
Build - Make                  PASS      1372.70 seconds
Make Check                    PASS      11.35 seconds
Make Check w/Valgrind         PASS      438.47 seconds
Make Distcheck                PASS      225.85 seconds
Build w/ext ELL - Configure   PASS      8.50 seconds
Build w/ext ELL - Make        PASS      1361.92 seconds
Incremental Build with patchesPASS      5555.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/4] adapter: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '2287c517ca1bd', maybe rebased or not pulled?
#88: 
Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")

/github/workspace/src/12742616.patch total: 0 errors, 1 warnings, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742616.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/4] device: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '6a154cd08000b', maybe rebased or not pulled?
#90: 
Fixes: 6a154cd08000b ("device: Fix unchecked return value")

/github/workspace/src/12742617.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742617.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,3/4] profiles: Fix the reusing gerror without re-initialization
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '4ad622d592ba5', maybe rebased or not pulled?
#90: 
Fixes: 4ad622d592ba5 ("profiles/a2dp: Fix unchecked return value")

/github/workspace/src/12742618.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742618.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,4/4] device: Fix crash when removing device
WARNING:TYPO_SPELLING: 'immediatelly' may be misspelled - perhaps 'immediately'?
#81: 
cause a crash, so instead of removing it immediatelly this set a the
                                         ^^^^^^^^^^^^

/github/workspace/src/12742619.patch total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742619.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4494473924747014226==--
