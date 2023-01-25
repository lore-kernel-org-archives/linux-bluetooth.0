Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C4C54EED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Jan 2023 00:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjAYA0Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 19:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjAYA0Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 19:26:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D133518ED
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 16:25:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s67so12402930pgs.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 16:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prt0VWuEhkMQ0B2e2pqhMCpEYoRt0GET+8mj1GKpzyA=;
        b=OcfTeUGDGWhpZca6EuXYNnm0xEas6yteBthiv19dGK8fYnaU41Ld2MBqy9OtLBeUfJ
         OPE9pOlPLB7oYmtoQ6Q7598lWiFSMVU81FQ8dtOb7Rp4DFh2npA1QaN/nzr8Or9y/qMX
         suXZbtAfbwku6uD158m5w6PMJziapEgtnf4dDBObsVy5ju9MxX+liwtEjD8Sy3pGQnt6
         eZkowXEG7H+3txSxRXmkTNYqB/aboiX9wZjao35csgBJRxHLYVSmU8LuFUdoVbYAQIax
         qYtGcDHyrBTiOvWa/fqrQlpqBhx8Ut65RPVHscHi+rxnQXOFbdPfbDPKkOvU4gwvkvqZ
         Sg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prt0VWuEhkMQ0B2e2pqhMCpEYoRt0GET+8mj1GKpzyA=;
        b=Frwl/PNkZALP0LZXm7zWLM9HyKm08WhRCRwoccEm4dc/q65Ev0bmMdmcWOd4ADWCk3
         gNFIhx1nTaSdc3l7SPDFCSLud1zhWaaNCnd/ubACIjBpIjQfli3y+qXwQ6D1IgO1UVFF
         2rAzGWBxXVPcQZsGNeRKLCgQQxE23ON62l8Z/ASqhpbIYMNCAf2wCR3FR7E4YacsiJPF
         13ZERFcKsOJk5TOn/2HBH+mXaw+vjwgF050reBRHdfP4WZbCVs+7m9IXO5qF5mM1FilJ
         ZR6zp3VlXBRHZeVANj6g27iO/DPGOjS4SL3BvDh83SOOMnFTrXnyu+/w51W3JiE9/JeK
         dt4A==
X-Gm-Message-State: AFqh2kozHIjWeB7rJ31EAt1LGFAdsIcehUk4oB/WwZYGP1803I83b28v
        WNpFjI6q0v1iyc3Wv06TsjLxAczkVj4=
X-Google-Smtp-Source: AMrXdXvAaHZutBFA/h9NEFyM6p11q2IvnHXybGVt2zmeZMybpaWef4DrQ2JhmDCK5fhrZavSpEVhWg==
X-Received: by 2002:a62:5214:0:b0:578:5e94:22d0 with SMTP id g20-20020a625214000000b005785e9422d0mr30487944pfb.19.1674606337854;
        Tue, 24 Jan 2023 16:25:37 -0800 (PST)
Received: from [172.17.0.2] ([13.88.61.225])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b0056283e2bdbdsm2172276pfm.138.2023.01.24.16.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:25:37 -0800 (PST)
Message-ID: <63d07701.a70a0220.e5965.3f27@mx.google.com>
Date:   Tue, 24 Jan 2023 16:25:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1398792255742366895=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Mesh v1.1 additions
In-Reply-To: <20230124202616.310544-2-brian.gix@gmail.com>
References: <20230124202616.310544-2-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1398792255742366895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715272

---Test result---

Test Summary:
CheckPatch                    FAIL      9.03 seconds
GitLint                       FAIL      3.65 seconds
BuildEll                      PASS      32.94 seconds
BluezMake                     PASS      997.15 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      180.02 seconds
CheckValgrind                 PASS      293.68 seconds
CheckSmatch                   PASS      388.11 seconds
bluezmakeextell               PASS      117.27 seconds
IncrementalBuild              PASS      10456.45 seconds
ScanBuild                     WARNING   1194.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,02/13] mesh: Add Remote Provisioning
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3307: FILE: mesh/remprv-server.c:238:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3516: FILE: mesh/remprv-server.c:447:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3520: FILE: mesh/remprv-server.c:451:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3798: FILE: mesh/remprv-server.c:729:
+		/* fall through */

/github/workspace/src/src/13114772.patch total: 0 errors, 4 warnings, 3742 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13114772.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,07/13] mesh: Add Mesh Private Beacon server
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#228: FILE: mesh/prvbeac-server.c:74:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#240: FILE: mesh/prvbeac-server.c:86:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#247: FILE: mesh/prvbeac-server.c:93:
+		/* fall through */

/github/workspace/src/src/13114768.patch total: 0 errors, 3 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13114768.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,01/13] doc/mesh: Add Remote Provisioning DBus APIs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	* Refresh Device Keys"
12: B3 Line contains hard tab characters (\t): "	* Reassign Node Addresses"
13: B3 Line contains hard tab characters (\t): "	* Refresh Node Composition"
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


--===============1398792255742366895==--
