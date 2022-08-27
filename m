Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CDECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiH0AVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0AVB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:21:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CDA0637
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:21:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d1so2311523qvs.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=EY1kA72VqmZgpDK8lELaCl39fjimK3BNpYu5r3zY7V0=;
        b=gwZwdmiiSWRAHbhj+0N7Wg2LHHMfdDajDoy4Z5GoEN15njoILJBgi9PpohvWj1/eWp
         /nXxf5R00DL4T5X/hTtg62tPwcxUhP8ZGorBQRsvwRN8BP/B9HHhxilteyGEdG73L8n3
         Gj6fLyppW74v5qJDpWqRhRunolmk9mFB33CywUS5KKmtlmxS1UKbE50hkj3TyYhK6gCy
         e2MmsbwT93wiC1VTuiBin+Vs1jVa4ja+brkVml9IVwOQNl2rE35HJxmu0WD9UO39VBq1
         /FPXb5V/ofbGJ1feW0bd7lSlaRAKksmoXQGEMrG3HqZYPY1nvBGAE5Pl0poeyVgV/hgT
         FT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=EY1kA72VqmZgpDK8lELaCl39fjimK3BNpYu5r3zY7V0=;
        b=sk5tVJZZb8RGIHmJRcWEoBbPKJHcOJxFlBvjZIQxtfH4LkiTygMBqRjSgMRekuzWy0
         cg0Ca0yMQ9HWyk5QxDiGhYYj5mRou5IqAM14oNNx78dkH+1PzVgJCC+Hf3sbwrEbiqgr
         7e714UMttIpMyHITScsPsXXA7kY6XEz7643UT0x90QxENqgOOQxmojRVxIeIPQS5wdxr
         C4+Q+EQtXD1gPD6we6Jz2OIyHKd/cXxVyirJUgu38aN3GrqElrBoV72ALv4HEHFLrjUD
         DeEUrIJonNDOlRdp3fHhvzkzcg2FBwVORdOJ/rOnqzACBAd7vHJ9zQXqanW0FzM76qYn
         WJqA==
X-Gm-Message-State: ACgBeo2KJmtQls1ZCC1jpNlAl04RVn4FQkXD1Lo4OQiB6mM91Yord7Wk
        yE9mMKdKORaI5HusP88CH/G6T2sevF4=
X-Google-Smtp-Source: AA6agR4J87/c4RCGsTdWjEQwDwbTQlPPOCQRwf5SE+ynKfFIR8VI/MB0K7nBqgoCXEJXoJeVjMUFlw==
X-Received: by 2002:a05:6214:e4d:b0:496:ccc1:12b8 with SMTP id o13-20020a0562140e4d00b00496ccc112b8mr1795846qvc.66.1661559659745;
        Fri, 26 Aug 2022 17:20:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.231.188])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a29c600b006bb82221013sm876028qkp.0.2022.08.26.17.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:20:59 -0700 (PDT)
Message-ID: <6309636b.050a0220.be2b3.3abf@mx.google.com>
Date:   Fri, 26 Aug 2022 17:20:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3400194759984494987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Initial BAP support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220826232031.20391-2-luiz.dentz@gmail.com>
References: <20220826232031.20391-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3400194759984494987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671660

---Test result---

Test Summary:
CheckPatch                    FAIL      20.82 seconds
GitLint                       PASS      10.08 seconds
Prep - Setup ELL              PASS      24.04 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      7.74 seconds
Build - Make                  PASS      900.80 seconds
Make Check                    PASS      11.63 seconds
Make Check w/Valgrind         PASS      257.30 seconds
Make Distcheck                PASS      217.27 seconds
Build w/ext ELL - Configure   PASS      7.88 seconds
Build w/ext ELL - Make        PASS      78.54 seconds
Incremental Build w/ patches  PASS      810.07 seconds
Scan Build                    WARNING   824.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,3/9] shared/bap: Add initial code for handling BAP
ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#370: FILE: src/shared/bap.c:19:
+ *  License along with this library; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#371: FILE: src/shared/bap.c:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1743: FILE: src/shared/bap.c:1392:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1749: FILE: src/shared/bap.c:1398:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1762: FILE: src/shared/bap.c:1411:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1768: FILE: src/shared/bap.c:1417:
+		/* Fallthrough */

ERROR:SPACING: space required before the open parenthesis '('
#4469: FILE: src/shared/bap.c:4118:
+			switch(lpac->type) {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#5149: FILE: src/shared/bap.h:16:
+#define __packed __attribute__((packed))

WARNING:SPACING: Unnecessary space before function pointer arguments
#5256: FILE: src/shared/bap.h:123:
+	int (*select) (struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5259: FILE: src/shared/bap.h:126:
+	int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5262: FILE: src/shared/bap.h:129:
+	void (*clear) (struct bt_bap_stream *stream, void *user_data);

/github/workspace/src/12956713.patch total: 3 errors, 8 warnings, 5278 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956713.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,4/9] profiles: Add initial code for bap plugin
ERROR:SPACING: space prohibited before that close parenthesis ')'
#618: FILE: profiles/audio/bap.c:490:
+						{ "properties", "a{sv}" } ),

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#1428: FILE: profiles/audio/bap.c:1300:
+static unsigned int bap_id = 0;

WARNING:SPACING: Unnecessary space before function pointer arguments
#2354: FILE: profiles/audio/transport.c:116:
+	void			(*set_state) (struct media_transport *transport,

/github/workspace/src/12956709.patch total: 2 errors, 1 warnings, 2836 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956709.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,8/9] client/player: Add support for PACS endpoints
ERROR:SPACING: space prohibited before that close parenthesis ')'
#631: FILE: client/player.c:1886:
+					GDBUS_ARGS({ "cfg", "ay" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#634: FILE: client/player.c:1889:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#635: FILE: client/player.c:1890:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

/github/workspace/src/12956714.patch total: 3 errors, 0 warnings, 799 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956714.patch has style problems, please review.

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




---
Regards,
Linux Bluetooth


--===============3400194759984494987==--
