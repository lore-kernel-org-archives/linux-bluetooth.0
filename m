Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C50C00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 03:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiHRDvD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiHRDvC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 23:51:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF01D57
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 20:50:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s11so329218qtx.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=mN1g6zkVn8/Ag9SlB7BHBny0P3P9Q2nY+7uHMPZ/CAY=;
        b=o/ky8Os7K4R3wcXUGkPL+x3PsGC5d6taa3nhIc4T5St+J2C8CmxBwO50BGded7dIpF
         lXRHcCddb20h+U/gyiGAVZ8NCmtbRKudDfx9HxCM7Pbz/EdxL0CzFEWw/S6chuHsPxtr
         N/NZCJDPeyIXbpgLUoKdTF4aJvjB23NXVa2x0U/RsHp+pyCEyq7Kvt1/l+O2X+iAMz/b
         x5JjKmrhANjg0giIS1JrXhQp/dpozNP0nY1rN31VK+B3t3ib2XskdUJTBpvko1qSUSHS
         gaRYZRP1yhGf4fTr1GyuHQ0tkpZAX8Bd6BoGNj/oBT/tVy/tzJzJI1QJHjWv3Hq00ds9
         /4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mN1g6zkVn8/Ag9SlB7BHBny0P3P9Q2nY+7uHMPZ/CAY=;
        b=LanotrjRowz+osMftmBF1f+Bc2Nvsp+cUR0bYEgCDcYZ0jDO/mGF6BdIl2jCZVgD32
         FCs+rYnIWY0RBLRKd+vJNRK1mGz9VDrCj/5jX+jfBBBzvRhBijyo+i5+D7ZzK3qumwpT
         BFUC66PwK/Th6vXMPfnqornZGHlVw1RZ87bdmX1sYHyS3+Z5fzTUnM+KlCtrrgpd+mD9
         xbwiu2H8mHyx58vou/DNZjz2Stp9STqZXJRau+JgZw5xXmMWiitnVssOUzSdNySyOyNZ
         S2iUwqcvj7ANdHiHgJy/IVf6rjutybEA8rcGU2BrEBGgDOI9S4NnOFoy8sW5os0ak6aD
         kvvg==
X-Gm-Message-State: ACgBeo37meVSBVYAY6qLict5RWC+ozBXLAjopu5Eh2pWiO2zLGkwKy3i
        CGPH+qNhftx7aEiJY/zpGCW9j3w9k0w2ug==
X-Google-Smtp-Source: AA6agR6RLH1+QSfgJrF966Bwydda0QxK5GYQBGc+7SKaigUUz61rrjWGc8gd9vSjk0C4bpcSCN/rOA==
X-Received: by 2002:ac8:5e13:0:b0:344:734f:c354 with SMTP id h19-20020ac85e13000000b00344734fc354mr1109453qtx.189.1660794658736;
        Wed, 17 Aug 2022 20:50:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.35.163])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003447ee0a6bfsm256769qtn.17.2022.08.17.20.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:50:58 -0700 (PDT)
Message-ID: <62fdb722.c80a0220.b417b.0692@mx.google.com>
Date:   Wed, 17 Aug 2022 20:50:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2981133124921367987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Initial BAP support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220817234146.224081-2-luiz.dentz@gmail.com>
References: <20220817234146.224081-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2981133124921367987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668569

---Test result---

Test Summary:
CheckPatch                    FAIL      22.27 seconds
GitLint                       PASS      9.44 seconds
Prep - Setup ELL              PASS      32.78 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      11.01 seconds
Build - Make                  PASS      976.97 seconds
Make Check                    PASS      13.21 seconds
Make Check w/Valgrind         PASS      348.16 seconds
Make Distcheck                PASS      303.38 seconds
Build w/ext ELL - Configure   PASS      11.01 seconds
Build w/ext ELL - Make        PASS      100.58 seconds
Incremental Build w/ patches  PASS      1072.20 seconds
Scan Build                    WARNING   1121.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,3/9] shared/bap: Add initial code for handling BAP
ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#331: FILE: src/shared/bap.c:19:
+ *  License along with this library; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#332: FILE: src/shared/bap.c:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1707: FILE: src/shared/bap.c:1395:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1713: FILE: src/shared/bap.c:1401:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1726: FILE: src/shared/bap.c:1414:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1732: FILE: src/shared/bap.c:1420:
+		/* Fallthrough */

WARNING:BRACES: braces {} are not necessary for single statement blocks
#2523: FILE: src/shared/bap.c:2211:
+		for (i = 0; i < hdr->num; i++) {
+			ret = handler->func(ascs, bap, &iov, rsp);
+		}

ERROR:SPACING: space required before the open parenthesis '('
#4434: FILE: src/shared/bap.c:4122:
+			switch(lpac->type) {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#5114: FILE: src/shared/bap.h:16:
+#define __packed __attribute__((packed))

WARNING:SPACING: Unnecessary space before function pointer arguments
#5221: FILE: src/shared/bap.h:123:
+	int (*select) (struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5224: FILE: src/shared/bap.h:126:
+	int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5227: FILE: src/shared/bap.h:129:
+	void (*clear) (struct bt_bap_stream *stream, void *user_data);

/github/workspace/src/12946591.patch total: 3 errors, 9 warnings, 5252 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12946591.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,4/9] profiles: Add initial code for bap plugin
ERROR:SPACING: space prohibited before that close parenthesis ')'
#599: FILE: profiles/audio/bap.c:471:
+						{ "properties", "a{sv}" } ),

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#1406: FILE: profiles/audio/bap.c:1278:
+static unsigned int bap_id = 0;

WARNING:SPACING: Unnecessary space before function pointer arguments
#2332: FILE: profiles/audio/transport.c:116:
+	void			(*set_state) (struct media_transport *transport,

/github/workspace/src/12946588.patch total: 2 errors, 1 warnings, 2814 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12946588.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,8/9] client/player: Add support for PACS endpoints
ERROR:SPACING: space prohibited before that close parenthesis ')'
#631: FILE: client/player.c:1886:
+					GDBUS_ARGS({ "cfg", "ay" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#634: FILE: client/player.c:1889:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#635: FILE: client/player.c:1890:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

/github/workspace/src/12946590.patch total: 3 errors, 0 warnings, 799 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12946590.patch has style problems, please review.

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
client/player.c:1757:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.
profiles/audio/media.c:1450:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2996:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2999:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.
src/shared/bap.c:1217:9: warning: Use of memory after it is freed
        link = queue_find(stream->links, match_stream_io, io);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============2981133124921367987==--
