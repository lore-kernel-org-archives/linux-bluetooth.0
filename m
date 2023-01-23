Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98730C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 22:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjAWW52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjAWW51 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 17:57:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306F13D6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 14:57:25 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b6so10154363pgi.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4xIhocaFyekmjCOgom05bhyJB7Bb/ISNv2jRZf7dGGs=;
        b=HAv5JIfzzhKbtNDJ77drDV0G3iqH1eNLUeDnMj1rbPXb7+OxNga+OB9EvF3rFKVg1m
         Q78Y9xtnaumo8Mtqt/NxkTZ0QVBuP7Yn176AvLsNRQWdGnf/fGSGwAxyyjm6ogBhr3lK
         NZKjUROSD1W9EvUsUqhfIqXSCfk+qx1VicM0NDPJiEmIAZfPxdXORh/fIN0dL1ax3drJ
         f21LSY1oBDom9zpvwDravYoYhN5DaPfm4foe2+tT4rwX/l2RX57sfQA/WRZgtCa/EVRX
         A/baPIj/HjpOY3G5zillXt5rOIKAsPEF5AQ6Tmb7g58xrFi+XabYfpufXTGfBn2RpUDK
         TBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xIhocaFyekmjCOgom05bhyJB7Bb/ISNv2jRZf7dGGs=;
        b=QUpp2GkvWl8rt79WKe1ru1aF4lxpN2HPAkQ6YHD23omLABe8eiF7MZFhR+OywNJ0w4
         dD39ebiIQvt3kKbdeWS+ynEsOUf5D6rYYC+vmsc3DxIoZ+x4nY5/1sbJrSqHbbpliT1D
         PjoaByQfdawlO9nv/5JAHVFJ7ONODo15MqTpnH/mVKkrqIC+veXXTfBtPvBbc6DkVp/X
         tvV0Dg6Ad5my9PC0hs8DqiDV1ELzc2iivXBlOqvsXYgzukYDlxz2aF3h80oG25RNPIkx
         WtNtKlLqXew6H9AkeGg52Tzp9FhX+65TIOwYkpk7ZDCuY1SsL5A1D41fmH/E7d5Y6YDF
         qzbQ==
X-Gm-Message-State: AFqh2kpSCAEoIe/VGA3W5bAuLeyaMMM3Rd+0wBRaMlf3/L+AWk4Ud498
        zCHQSQ8AdG6lmGMP3fafsCgJRMpSQGM=
X-Google-Smtp-Source: AMrXdXumXNFH6INc7shJgdHTyP8qUvac5ylevOxd2RPxN5g/xVX83kPK0bR+impAv+5EKYc3MIfYCQ==
X-Received: by 2002:aa7:85c4:0:b0:58d:bb58:e928 with SMTP id z4-20020aa785c4000000b0058dbb58e928mr24700990pfn.32.1674514644311;
        Mon, 23 Jan 2023 14:57:24 -0800 (PST)
Received: from [172.17.0.2] ([20.172.4.99])
        by smtp.gmail.com with ESMTPSA id t5-20020a62d145000000b0058db8f8bce8sm102796pfl.166.2023.01.23.14.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:57:24 -0800 (PST)
Message-ID: <63cf10d4.620a0220.b1e64.03ec@mx.google.com>
Date:   Mon, 23 Jan 2023 14:57:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3408772546063869143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Mesh v1.1 additions
In-Reply-To: <20230123194824.257351-2-brian.gix@gmail.com>
References: <20230123194824.257351-2-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3408772546063869143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=714870

---Test result---

Test Summary:
CheckPatch                    FAIL      7.76 seconds
GitLint                       FAIL      2.98 seconds
BuildEll                      PASS      27.14 seconds
BluezMake                     PASS      792.42 seconds
MakeCheck                     PASS      11.22 seconds
MakeDistcheck                 PASS      152.63 seconds
CheckValgrind                 PASS      244.88 seconds
CheckSmatch                   WARNING   326.99 seconds
bluezmakeextell               PASS      98.25 seconds
IncrementalBuild              PASS      7015.56 seconds
ScanBuild                     WARNING   995.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,02/11] mesh: Add Remote Provisioning
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3307: FILE: mesh/remprv-server.c:238:
+		/* fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3516: FILE: mesh/remprv-server.c:447:
+		/* fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3520: FILE: mesh/remprv-server.c:451:
+		/* fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3798: FILE: mesh/remprv-server.c:729:
+		/* fallthrough */

/github/workspace/src/src/13112871.patch total: 0 errors, 4 warnings, 3741 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13112871.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,07/11] mesh: Add Mesh Private Beacon server
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#227: FILE: mesh/prvbeac-server.c:74:
+		/* fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#239: FILE: mesh/prvbeac-server.c:86:
+		/* fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#246: FILE: mesh/prvbeac-server.c:93:
+		/* fallthrough */

/github/workspace/src/src/13112872.patch total: 0 errors, 3 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13112872.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,01/11] doc/mesh: Add Remote Provisioning DBus APIs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	* Refresh Device Keys"
12: B3 Line contains hard tab characters (\t): "	* Reassign Node Addresses"
13: B3 Line contains hard tab characters (\t): "	* Refresh Node Composition"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/manager.c:113:35: warning: non-ANSI function declaration of function 'free_pending_add_call'mesh/crypto.c:1023:30: warning: non-ANSI function declaration of function 'mesh_crypto_check_avail'unit/test-mesh-crypto.c: note: in included file:
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from unit/test-mesh-crypto.c:20:
In file included from ./mesh/crypto.c:18:
In file included from ./ell/ell.h:1:
./ell/util.h:187:9: warning: 1st function call argument is an uninitialized value
        return L_BE32_TO_CPU(L_GET_UNALIGNED((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./ell/util.h:89:28: note: expanded from macro 'L_BE32_TO_CPU'
#define L_BE32_TO_CPU(val) bswap_32(val)
                           ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3408772546063869143==--
