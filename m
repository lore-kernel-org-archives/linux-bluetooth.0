Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F36C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 23:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhLGXmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhLGXmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 18:42:43 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667FBC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 15:39:12 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id b11so835935qvm.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 15:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=krQ/8pRa866HvqDvnCOFrQY3IaIlZAkJSH8bMwV8qI8=;
        b=ezACwGgVCfeS85fCZteNQK6kG8JzRVK1Y4esqMdDQgy0jEPERdbc9OZkPm8y0NBmVl
         kE6j3htm/5j3a1RPyeqoy3h7F7v55lvI8nsneclsENOqmofz/xzQXD63f5BqAjqtevXc
         oE06/gs8Yc5ImozE/l1RWFkPzReWl4cGADkCNBGzg0EXazEodMcWuS04yv5gUn2AoaiQ
         UII8UONQi6w7IIJ2MRRvn/CeK1VNNAyy0oAFr+TRJePKjwqH1N9mcS+MSs5tQEjZ65Ng
         Zs875mZcP0p1Nk6EsmzVY0yMw5hmukVFRAml7lBViqI6DwrsJSE7cO6gQejr7eyYFw0f
         BXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=krQ/8pRa866HvqDvnCOFrQY3IaIlZAkJSH8bMwV8qI8=;
        b=6pOg72/Z5YtnVOBoKiL42DOsRIWMRo/f2uaYZQtkkckHN50jXPfJiX/mLm2BFF8Wyn
         CWapculg1LnO6cnxSqpykEedXjn5Qr9FumKq1Q1iU22xtmykr4t0vid8DCAYyctsfYkR
         XXqvea8mAXml8wv+/7myxeIyPjOtcj6AdFnisBe4FRfSUgg6SpjCwNV58cZdT1Ad0NPG
         p76CdiTv7fo0mLLTvIn3DyMPNBDYYigGP5dq8ZNGdquod/DtlLrWn2yOFJtBKB388WKY
         ZKSHtS+YgC+z2/1SaNUZTURYCWd1/Lz6k/v/bADx1YqDc9USJ7zneajFfjjbNdMNiTFe
         BxLg==
X-Gm-Message-State: AOAM531+Fxc8n7XDy9z90tOBRgDw14XVxmplEirlCuvD482041oP/lWE
        wO2GusdJNmNAx6lolCv+x7fpC6/iHPHUSg==
X-Google-Smtp-Source: ABdhPJzUtRdV6D+n+HUberGZM/8N9+3zNctWic1udiRbVVbK9JoVN/F9mKHk3pl16Aa43oapRQra9A==
X-Received: by 2002:a05:6214:2a8d:: with SMTP id jr13mr3029417qvb.85.1638920349977;
        Tue, 07 Dec 2021 15:39:09 -0800 (PST)
Received: from [172.17.0.2] ([20.119.214.78])
        by smtp.gmail.com with ESMTPSA id y6sm644263qtn.23.2021.12.07.15.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 15:39:09 -0800 (PST)
Message-ID: <61aff09d.1c69fb81.9440a.42ae@mx.google.com>
Date:   Tue, 07 Dec 2021 15:39:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1770561061006161030=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dbiagio79@gmail.com
Subject: RE: tools/mesh-gatt meshctl tool improvements
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211207225604.35156-2-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-2-daniele.biagetti@cblelectronics.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1770561061006161030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=591917

---Test result---

Test Summary:
CheckPatch                    FAIL      10.19 seconds
GitLint                       FAIL      6.00 seconds
Prep - Setup ELL              PASS      50.55 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      9.60 seconds
Build - Make                  PASS      216.26 seconds
Make Check                    PASS      9.63 seconds
Make Distcheck                PASS      254.73 seconds
Build w/ext ELL - Configure   PASS      9.70 seconds
Build w/ext ELL - Make        PASS      202.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/6] tools/mesh-gatt: Add onoff set unack message to onoff client model
WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 8)
#108: FILE: tools/mesh-gatt/onoff-model.c:243:
+	if ((np != 1) && (np != 2) &&
[...]
+	bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" "

ERROR:SPACING: spaces required around that '==' (ctx:VxV)
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){
 	       ^

ERROR:SPACING: space required before the open brace '{'
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){

ERROR:SPACING: space prohibited after that open parenthesis '('
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){

ERROR:SPACING: space prohibited before that close parenthesis ')'
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){

ERROR:SPACING: space required before the open parenthesis '('
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){

WARNING:BRACES: braces {} are not necessary for any arm of this statement
#116: FILE: tools/mesh-gatt/onoff-model.c:251:
+	if( (np==2) && parms[1] ){
[...]
+	}else{
[...]

ERROR:SPACING: space required before the open brace '{'
#118: FILE: tools/mesh-gatt/onoff-model.c:253:
+	}else{

ERROR:SPACING: space required after that close brace '}'
#118: FILE: tools/mesh-gatt/onoff-model.c:253:
+	}else{

/github/workspace/src/12662883.patch total: 7 errors, 2 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12662883.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/6] tools/mesh-gatt: Fix status messages processing
ERROR:SPACING: space required after that ',' (ctx:VxV)
#112: FILE: tools/mesh-gatt/node.c:494:
+	print_byte_array("\t",data, len);
 	                     ^

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#142: FILE: tools/mesh-gatt/onoff-model.c:115:
+		bt_shell_printf("On Off Model Message received (%d) opcode %x\n",

ERROR:SPACING: space required after that ',' (ctx:VxV)
#144: FILE: tools/mesh-gatt/onoff-model.c:117:
+		print_byte_array("\t",data, len);
 		                     ^

ERROR:SPACING: space required after that close brace '}'
#162: FILE: tools/mesh-gatt/onoff-model.c:128:
+		}else

/github/workspace/src/12662885.patch total: 3 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12662885.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,3/6] tools/mesh-gatt: Fix unwanted return in onoff client model
ERROR:SPACING: space required before the open brace '{'
#99: FILE: tools/mesh-gatt/onoff-model.c:212:
+	if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#99: FILE: tools/mesh-gatt/onoff-model.c:212:
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#100: FILE: tools/mesh-gatt/onoff-model.c:213:
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:SPACING: space required after that ',' (ctx:VxV)
#100: FILE: tools/mesh-gatt/onoff-model.c:213:
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
 		                                                             ^

ERROR:SPACING: space required before the open brace '{'
#111: FILE: tools/mesh-gatt/onoff-model.c:241:
+	if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#111: FILE: tools/mesh-gatt/onoff-model.c:241:
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#112: FILE: tools/mesh-gatt/onoff-model.c:242:
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:SPACING: space required after that ',' (ctx:VxV)
#112: FILE: tools/mesh-gatt/onoff-model.c:242:
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
 		                                                             ^

/github/workspace/src/12662887.patch total: 4 errors, 4 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12662887.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,4/6] tools/mesh-gatt: Add subscription delete message to config client model
ERROR:CODE_INDENT: code indent should use tabs where possible
#96: FILE: tools/mesh-gatt/config-client.c:1042:
+        uint16_t n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#96: FILE: tools/mesh-gatt/config-client.c:1042:
+        uint16_t n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#97: FILE: tools/mesh-gatt/config-client.c:1043:
+        uint8_t msg[32];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#97: FILE: tools/mesh-gatt/config-client.c:1043:
+        uint8_t msg[32];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#98: FILE: tools/mesh-gatt/config-client.c:1044:
+        int parm_cnt;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#98: FILE: tools/mesh-gatt/config-client.c:1044:
+        int parm_cnt;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#100: FILE: tools/mesh-gatt/config-client.c:1046:
+        if (IS_UNASSIGNED(target)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#100: FILE: tools/mesh-gatt/config-client.c:1046:
+        if (IS_UNASSIGNED(target)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#101: FILE: tools/mesh-gatt/config-client.c:1047:
+                bt_shell_printf("Destination not set\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#101: FILE: tools/mesh-gatt/config-client.c:1047:
+                bt_shell_printf("Destination not set\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#102: FILE: tools/mesh-gatt/config-client.c:1048:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#102: FILE: tools/mesh-gatt/config-client.c:1048:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#103: FILE: tools/mesh-gatt/config-client.c:1049:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#103: FILE: tools/mesh-gatt/config-client.c:1049:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#105: FILE: tools/mesh-gatt/config-client.c:1051:
+        n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#105: FILE: tools/mesh-gatt/config-client.c:1051:
+        n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#107: FILE: tools/mesh-gatt/config-client.c:1053:
+        parm_cnt = read_input_parameters(argc, argv);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#107: FILE: tools/mesh-gatt/config-client.c:1053:
+        parm_cnt = read_input_parameters(argc, argv);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#108: FILE: tools/mesh-gatt/config-client.c:1054:
+        if (parm_cnt != 3) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#108: FILE: tools/mesh-gatt/config-client.c:1054:
+        if (parm_cnt != 3) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#109: FILE: tools/mesh-gatt/config-client.c:1055:
+                bt_shell_printf("Bad arguments: %s\n", argv[1]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#109: FILE: tools/mesh-gatt/config-client.c:1055:
+                bt_shell_printf("Bad arguments: %s\n", argv[1]);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#110: FILE: tools/mesh-gatt/config-client.c:1056:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#110: FILE: tools/mesh-gatt/config-client.c:1056:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#111: FILE: tools/mesh-gatt/config-client.c:1057:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#111: FILE: tools/mesh-gatt/config-client.c:1057:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#113: FILE: tools/mesh-gatt/config-client.c:1059:
+        /* Per Mesh Profile 4.3.2.19 */$

ERROR:CODE_INDENT: code indent should use tabs where possible
#114: FILE: tools/mesh-gatt/config-client.c:1060:
+        /* Element Address */$

ERROR:CODE_INDENT: code indent should use tabs where possible
#115: FILE: tools/mesh-gatt/config-client.c:1061:
+        put_le16(parms[0], msg + n);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#115: FILE: tools/mesh-gatt/config-client.c:1061:
+        put_le16(parms[0], msg + n);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#116: FILE: tools/mesh-gatt/config-client.c:1062:
+        n += 2;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#116: FILE: tools/mesh-gatt/config-client.c:1062:
+        n += 2;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#117: FILE: tools/mesh-gatt/config-client.c:1063:
+        /* Subscription Address */$

ERROR:CODE_INDENT: code indent should use tabs where possible
#118: FILE: tools/mesh-gatt/config-client.c:1064:
+        put_le16(parms[1], msg + n);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#118: FILE: tools/mesh-gatt/config-client.c:1064:
+        put_le16(parms[1], msg + n);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#119: FILE: tools/mesh-gatt/config-client.c:1065:
+        n += 2;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#119: FILE: tools/mesh-gatt/config-client.c:1065:
+        n += 2;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#120: FILE: tools/mesh-gatt/config-client.c:1066:
+        /* SIG Model ID */$

ERROR:CODE_INDENT: code indent should use tabs where possible
#121: FILE: tools/mesh-gatt/config-client.c:1067:
+        put_le16(parms[2], msg + n);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#121: FILE: tools/mesh-gatt/config-client.c:1067:
+        put_le16(parms[2], msg + n);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#122: FILE: tools/mesh-gatt/config-client.c:1068:
+        n += 2;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#122: FILE: tools/mesh-gatt/config-client.c:1068:
+        n += 2;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#124: FILE: tools/mesh-gatt/config-client.c:1070:
+        if (!config_send(msg, n)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#124: FILE: tools/mesh-gatt/config-client.c:1070:
+        if (!config_send(msg, n)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#125: FILE: tools/mesh-gatt/config-client.c:1071:
+                bt_shell_printf("Failed to send \"DELETE SUBSCRIPTION\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#125: FILE: tools/mesh-gatt/config-client.c:1071:
+                bt_shell_printf("Failed to send \"DELETE SUBSCRIPTION\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#126: FILE: tools/mesh-gatt/config-client.c:1072:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#126: FILE: tools/mesh-gatt/config-client.c:1072:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#127: FILE: tools/mesh-gatt/config-client.c:1073:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#127: FILE: tools/mesh-gatt/config-client.c:1073:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#129: FILE: tools/mesh-gatt/config-client.c:1075:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#129: FILE: tools/mesh-gatt/config-client.c:1075:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

/github/workspace/src/12662889.patch total: 28 errors, 24 warnings, 52 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12662889.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,5/6] tools/mesh-gatt: Add generic level model support
ERROR:CODE_INDENT: code indent should use tabs where possible
#154: FILE: tools/mesh-gatt/level-model.c:43:
+        if (action == ACTION_ADD) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#154: FILE: tools/mesh-gatt/level-model.c:43:
+        if (action == ACTION_ADD) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#155: FILE: tools/mesh-gatt/level-model.c:44:
+                if (level_app_idx != APP_IDX_INVALID) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#155: FILE: tools/mesh-gatt/level-model.c:44:
+                if (level_app_idx != APP_IDX_INVALID) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#156: FILE: tools/mesh-gatt/level-model.c:45:
+                        return MESH_STATUS_INSUFF_RESOURCES;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#156: FILE: tools/mesh-gatt/level-model.c:45:
+                        return MESH_STATUS_INSUFF_RESOURCES;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#157: FILE: tools/mesh-gatt/level-model.c:46:
+                } else {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#157: FILE: tools/mesh-gatt/level-model.c:46:
+                } else {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#158: FILE: tools/mesh-gatt/level-model.c:47:
+                        level_app_idx = app_idx;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#158: FILE: tools/mesh-gatt/level-model.c:47:
+                        level_app_idx = app_idx;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#159: FILE: tools/mesh-gatt/level-model.c:48:
+                        bt_shell_printf("Level client model: new binding"$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#159: FILE: tools/mesh-gatt/level-model.c:48:
+                        bt_shell_printf("Level client model: new binding"$

ERROR:CODE_INDENT: code indent should use tabs where possible
#160: FILE: tools/mesh-gatt/level-model.c:49:
+                                        " %4.4x\n", app_idx);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#160: FILE: tools/mesh-gatt/level-model.c:49:
+                                        " %4.4x\n", app_idx);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#161: FILE: tools/mesh-gatt/level-model.c:50:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#161: FILE: tools/mesh-gatt/level-model.c:50:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#162: FILE: tools/mesh-gatt/level-model.c:51:
+        } else {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#162: FILE: tools/mesh-gatt/level-model.c:51:
+        } else {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#163: FILE: tools/mesh-gatt/level-model.c:52:
+                if (level_app_idx == app_idx)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#163: FILE: tools/mesh-gatt/level-model.c:52:
+                if (level_app_idx == app_idx)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#164: FILE: tools/mesh-gatt/level-model.c:53:
+                        level_app_idx = APP_IDX_INVALID;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#164: FILE: tools/mesh-gatt/level-model.c:53:
+                        level_app_idx = APP_IDX_INVALID;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#165: FILE: tools/mesh-gatt/level-model.c:54:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#165: FILE: tools/mesh-gatt/level-model.c:54:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#166: FILE: tools/mesh-gatt/level-model.c:55:
+        return MESH_STATUS_SUCCESS;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#166: FILE: tools/mesh-gatt/level-model.c:55:
+        return MESH_STATUS_SUCCESS;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#170: FILE: tools/mesh-gatt/level-model.c:59:
+        uint8_t step = (remaining_time & 0xc0) >> 6;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#170: FILE: tools/mesh-gatt/level-model.c:59:
+        uint8_t step = (remaining_time & 0xc0) >> 6;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#171: FILE: tools/mesh-gatt/level-model.c:60:
+        uint8_t count = remaining_time & 0x3f;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#171: FILE: tools/mesh-gatt/level-model.c:60:
+        uint8_t count = remaining_time & 0x3f;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#172: FILE: tools/mesh-gatt/level-model.c:61:
+        int secs = 0, msecs = 0, minutes = 0, hours = 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#172: FILE: tools/mesh-gatt/level-model.c:61:
+        int secs = 0, msecs = 0, minutes = 0, hours = 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#173: FILE: tools/mesh-gatt/level-model.c:62:
+        switch (step) {$

WARNING:LINE_SPACING: Missing a blank line after declarations
#173: FILE: tools/mesh-gatt/level-model.c:62:
+        int secs = 0, msecs = 0, minutes = 0, hours = 0;
+        switch (step) {

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#173: FILE: tools/mesh-gatt/level-model.c:62:
+        switch (step) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#174: FILE: tools/mesh-gatt/level-model.c:63:
+        case 0:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#174: FILE: tools/mesh-gatt/level-model.c:63:
+        case 0:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#175: FILE: tools/mesh-gatt/level-model.c:64:
+                msecs = 100 * count;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#175: FILE: tools/mesh-gatt/level-model.c:64:
+                msecs = 100 * count;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#176: FILE: tools/mesh-gatt/level-model.c:65:
+                secs = msecs / 1000;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#176: FILE: tools/mesh-gatt/level-model.c:65:
+                secs = msecs / 1000;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#177: FILE: tools/mesh-gatt/level-model.c:66:
+                msecs -= (secs * 1000);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#177: FILE: tools/mesh-gatt/level-model.c:66:
+                msecs -= (secs * 1000);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#178: FILE: tools/mesh-gatt/level-model.c:67:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#178: FILE: tools/mesh-gatt/level-model.c:67:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#179: FILE: tools/mesh-gatt/level-model.c:68:
+        case 1:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#179: FILE: tools/mesh-gatt/level-model.c:68:
+        case 1:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#180: FILE: tools/mesh-gatt/level-model.c:69:
+                secs = 1 * count;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#180: FILE: tools/mesh-gatt/level-model.c:69:
+                secs = 1 * count;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#181: FILE: tools/mesh-gatt/level-model.c:70:
+                minutes = secs / 60;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#181: FILE: tools/mesh-gatt/level-model.c:70:
+                minutes = secs / 60;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#182: FILE: tools/mesh-gatt/level-model.c:71:
+                secs -= (minutes * 60);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#182: FILE: tools/mesh-gatt/level-model.c:71:
+                secs -= (minutes * 60);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#183: FILE: tools/mesh-gatt/level-model.c:72:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#183: FILE: tools/mesh-gatt/level-model.c:72:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#184: FILE: tools/mesh-gatt/level-model.c:73:
+        case 2:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#184: FILE: tools/mesh-gatt/level-model.c:73:
+        case 2:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#185: FILE: tools/mesh-gatt/level-model.c:74:
+                secs = 10 * count;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#185: FILE: tools/mesh-gatt/level-model.c:74:
+                secs = 10 * count;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#186: FILE: tools/mesh-gatt/level-model.c:75:
+                minutes = secs / 60;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#186: FILE: tools/mesh-gatt/level-model.c:75:
+                minutes = secs / 60;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#187: FILE: tools/mesh-gatt/level-model.c:76:
+                secs -= (minutes * 60);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#187: FILE: tools/mesh-gatt/level-model.c:76:
+                secs -= (minutes * 60);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#188: FILE: tools/mesh-gatt/level-model.c:77:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#188: FILE: tools/mesh-gatt/level-model.c:77:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#189: FILE: tools/mesh-gatt/level-model.c:78:
+        case 3:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#189: FILE: tools/mesh-gatt/level-model.c:78:
+        case 3:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#190: FILE: tools/mesh-gatt/level-model.c:79:
+                minutes = 10 * count;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#190: FILE: tools/mesh-gatt/level-model.c:79:
+                minutes = 10 * count;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#191: FILE: tools/mesh-gatt/level-model.c:80:
+                hours = minutes / 60;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#191: FILE: tools/mesh-gatt/level-model.c:80:
+                hours = minutes / 60;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#192: FILE: tools/mesh-gatt/level-model.c:81:
+                minutes -= (hours * 60);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#192: FILE: tools/mesh-gatt/level-model.c:81:
+                minutes -= (hours * 60);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#193: FILE: tools/mesh-gatt/level-model.c:82:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#193: FILE: tools/mesh-gatt/level-model.c:82:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#194: FILE: tools/mesh-gatt/level-model.c:83:
+        default:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#195: FILE: tools/mesh-gatt/level-model.c:84:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#195: FILE: tools/mesh-gatt/level-model.c:84:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#196: FILE: tools/mesh-gatt/level-model.c:85:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#196: FILE: tools/mesh-gatt/level-model.c:85:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#197: FILE: tools/mesh-gatt/level-model.c:86:
+        bt_shell_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d"$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#197: FILE: tools/mesh-gatt/level-model.c:86:
+        bt_shell_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d"$

ERROR:CODE_INDENT: code indent should use tabs where possible
#198: FILE: tools/mesh-gatt/level-model.c:87:
+                        " msecs\n", hours, minutes, secs, msecs);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#198: FILE: tools/mesh-gatt/level-model.c:87:
+                        " msecs\n", hours, minutes, secs, msecs);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#201: FILE: tools/mesh-gatt/level-model.c:90:
+                             uint16_t len, void *user_data)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#201: FILE: tools/mesh-gatt/level-model.c:90:
+                             uint16_t len, void *user_data)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#203: FILE: tools/mesh-gatt/level-model.c:92:
+        uint32_t opcode;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#203: FILE: tools/mesh-gatt/level-model.c:92:
+        uint32_t opcode;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#204: FILE: tools/mesh-gatt/level-model.c:93:
+        int n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#204: FILE: tools/mesh-gatt/level-model.c:93:
+        int n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#205: FILE: tools/mesh-gatt/level-model.c:94:
+        uint8_t *p;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#205: FILE: tools/mesh-gatt/level-model.c:94:
+        uint8_t *p;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#206: FILE: tools/mesh-gatt/level-model.c:95:
+        int16_t lev;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#206: FILE: tools/mesh-gatt/level-model.c:95:
+        int16_t lev;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#207: FILE: tools/mesh-gatt/level-model.c:96:
+        char s[128];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#207: FILE: tools/mesh-gatt/level-model.c:96:
+        char s[128];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#209: FILE: tools/mesh-gatt/level-model.c:98:
+        if (mesh_opcode_get(data, len, &opcode, &n)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#209: FILE: tools/mesh-gatt/level-model.c:98:
+        if (mesh_opcode_get(data, len, &opcode, &n)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#210: FILE: tools/mesh-gatt/level-model.c:99:
+                len -= n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#210: FILE: tools/mesh-gatt/level-model.c:99:
+                len -= n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#211: FILE: tools/mesh-gatt/level-model.c:100:
+                data += n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#211: FILE: tools/mesh-gatt/level-model.c:100:
+                data += n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#212: FILE: tools/mesh-gatt/level-model.c:101:
+        } else$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#212: FILE: tools/mesh-gatt/level-model.c:101:
+        } else$

ERROR:CODE_INDENT: code indent should use tabs where possible
#213: FILE: tools/mesh-gatt/level-model.c:102:
+                return false;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#213: FILE: tools/mesh-gatt/level-model.c:102:
+                return false;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#215: FILE: tools/mesh-gatt/level-model.c:104:
+        switch (opcode) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#215: FILE: tools/mesh-gatt/level-model.c:104:
+        switch (opcode) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#216: FILE: tools/mesh-gatt/level-model.c:105:
+        default:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#217: FILE: tools/mesh-gatt/level-model.c:106:
+                return false;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#217: FILE: tools/mesh-gatt/level-model.c:106:
+                return false;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#218: FILE: tools/mesh-gatt/level-model.c:107:
+        case OP_GENERIC_LEVEL_STATUS:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#218: FILE: tools/mesh-gatt/level-model.c:107:
+        case OP_GENERIC_LEVEL_STATUS:$

ERROR:CODE_INDENT: code indent should use tabs where possible
#219: FILE: tools/mesh-gatt/level-model.c:108:
+                bt_shell_printf("Level Model Message received (%d) opcode %x\n",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#219: FILE: tools/mesh-gatt/level-model.c:108:
+                bt_shell_printf("Level Model Message received (%d) opcode %x\n",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#220: FILE: tools/mesh-gatt/level-model.c:109:
+                                len, opcode);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#220: FILE: tools/mesh-gatt/level-model.c:109:
+                                len, opcode);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#221: FILE: tools/mesh-gatt/level-model.c:110:
+                print_byte_array("\t",data, len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#221: FILE: tools/mesh-gatt/level-model.c:110:
+                print_byte_array("\t",data, len);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#221: FILE: tools/mesh-gatt/level-model.c:110:
+                print_byte_array("\t",data, len);
                                      ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#223: FILE: tools/mesh-gatt/level-model.c:112:
+                if (len != 2 && len != 4 && len != 5)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#223: FILE: tools/mesh-gatt/level-model.c:112:
+                if (len != 2 && len != 4 && len != 5)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#224: FILE: tools/mesh-gatt/level-model.c:113:
+                        break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#224: FILE: tools/mesh-gatt/level-model.c:113:
+                        break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#225: FILE: tools/mesh-gatt/level-model.c:114:
+                lev = 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#225: FILE: tools/mesh-gatt/level-model.c:114:
+                lev = 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#226: FILE: tools/mesh-gatt/level-model.c:115:
+                p = (uint8_t *)&lev;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#226: FILE: tools/mesh-gatt/level-model.c:115:
+                p = (uint8_t *)&lev;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#228: FILE: tools/mesh-gatt/level-model.c:117:
+                p[0] = data[0];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#228: FILE: tools/mesh-gatt/level-model.c:117:
+                p[0] = data[0];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#229: FILE: tools/mesh-gatt/level-model.c:118:
+                p[1] = data[1];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#229: FILE: tools/mesh-gatt/level-model.c:118:
+                p[1] = data[1];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#231: FILE: tools/mesh-gatt/level-model.c:120:
+                p[1] = data[0];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#231: FILE: tools/mesh-gatt/level-model.c:120:
+                p[1] = data[0];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#232: FILE: tools/mesh-gatt/level-model.c:121:
+                p[0] = data[1];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#232: FILE: tools/mesh-gatt/level-model.c:121:
+                p[0] = data[1];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#237: FILE: tools/mesh-gatt/level-model.c:126:
+                sprintf(s, "Node %4.4x: Level Status present = %d",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#237: FILE: tools/mesh-gatt/level-model.c:126:
+                sprintf(s, "Node %4.4x: Level Status present = %d",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#238: FILE: tools/mesh-gatt/level-model.c:127:
+                                src, lev);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#238: FILE: tools/mesh-gatt/level-model.c:127:
+                                src, lev);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#239: FILE: tools/mesh-gatt/level-model.c:128:
+                if (len >= 4) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#239: FILE: tools/mesh-gatt/level-model.c:128:
+                if (len >= 4) {$

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#240: FILE: tools/mesh-gatt/level-model.c:129:
+                        lev = (int16_t)(((uint16_t)data[3] << 8) |  (uint16_t)data[2]);

ERROR:CODE_INDENT: code indent should use tabs where possible
#240: FILE: tools/mesh-gatt/level-model.c:129:
+                        lev = (int16_t)(((uint16_t)data[3] << 8) |  (uint16_t)data[2]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#240: FILE: tools/mesh-gatt/level-model.c:129:
+                        lev = (int16_t)(((uint16_t)data[3] << 8) |  (uint16_t)data[2]);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#241: FILE: tools/mesh-gatt/level-model.c:130:
+                        sprintf(s, ", target = %d",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#241: FILE: tools/mesh-gatt/level-model.c:130:
+                        sprintf(s, ", target = %d",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#242: FILE: tools/mesh-gatt/level-model.c:131:
+                                        lev);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#242: FILE: tools/mesh-gatt/level-model.c:131:
+                                        lev);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#243: FILE: tools/mesh-gatt/level-model.c:132:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#243: FILE: tools/mesh-gatt/level-model.c:132:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#244: FILE: tools/mesh-gatt/level-model.c:133:
+                bt_shell_printf("%s\n", s);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#244: FILE: tools/mesh-gatt/level-model.c:133:
+                bt_shell_printf("%s\n", s);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#245: FILE: tools/mesh-gatt/level-model.c:134:
+                if(len == 5){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#245: FILE: tools/mesh-gatt/level-model.c:134:
+                if(len == 5){$

ERROR:SPACING: space required before the open brace '{'
#245: FILE: tools/mesh-gatt/level-model.c:134:
+                if(len == 5){

ERROR:SPACING: space required before the open parenthesis '('
#245: FILE: tools/mesh-gatt/level-model.c:134:
+                if(len == 5){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#245: FILE: tools/mesh-gatt/level-model.c:134:
+                if(len == 5){
+                        print_remaining_time(data[4]);
+                }

ERROR:CODE_INDENT: code indent should use tabs where possible
#246: FILE: tools/mesh-gatt/level-model.c:135:
+                        print_remaining_time(data[4]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#246: FILE: tools/mesh-gatt/level-model.c:135:
+                        print_remaining_time(data[4]);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#247: FILE: tools/mesh-gatt/level-model.c:136:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#247: FILE: tools/mesh-gatt/level-model.c:136:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#248: FILE: tools/mesh-gatt/level-model.c:137:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#248: FILE: tools/mesh-gatt/level-model.c:137:
+                break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#249: FILE: tools/mesh-gatt/level-model.c:138:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#249: FILE: tools/mesh-gatt/level-model.c:138:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#250: FILE: tools/mesh-gatt/level-model.c:139:
+        return true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#250: FILE: tools/mesh-gatt/level-model.c:139:
+        return true;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#256: FILE: tools/mesh-gatt/level-model.c:145:
+        uint32_t i;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#256: FILE: tools/mesh-gatt/level-model.c:145:
+        uint32_t i;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#257: FILE: tools/mesh-gatt/level-model.c:146:
+        if (!argc)$

WARNING:LINE_SPACING: Missing a blank line after declarations
#257: FILE: tools/mesh-gatt/level-model.c:146:
+        uint32_t i;
+        if (!argc)

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#257: FILE: tools/mesh-gatt/level-model.c:146:
+        if (!argc)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#258: FILE: tools/mesh-gatt/level-model.c:147:
+                return 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#258: FILE: tools/mesh-gatt/level-model.c:147:
+                return 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#259: FILE: tools/mesh-gatt/level-model.c:148:
+        --argc;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#259: FILE: tools/mesh-gatt/level-model.c:148:
+        --argc;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#260: FILE: tools/mesh-gatt/level-model.c:149:
+        ++argv;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#260: FILE: tools/mesh-gatt/level-model.c:149:
+        ++argv;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#261: FILE: tools/mesh-gatt/level-model.c:150:
+        if (!argc || argv[0][0] == '\0')$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#261: FILE: tools/mesh-gatt/level-model.c:150:
+        if (!argc || argv[0][0] == '\0')$

ERROR:CODE_INDENT: code indent should use tabs where possible
#262: FILE: tools/mesh-gatt/level-model.c:151:
+                return 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#262: FILE: tools/mesh-gatt/level-model.c:151:
+                return 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#263: FILE: tools/mesh-gatt/level-model.c:152:
+        for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#263: FILE: tools/mesh-gatt/level-model.c:152:
+        for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;$

WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'
#263: FILE: tools/mesh-gatt/level-model.c:152:
+        for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;

WARNING:ARRAY_SIZE: Prefer ARRAY_SIZE(parms)
#263: FILE: tools/mesh-gatt/level-model.c:152:
+        for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;

ERROR:CODE_INDENT: code indent should use tabs where possible
#264: FILE: tools/mesh-gatt/level-model.c:153:
+             i++) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#264: FILE: tools/mesh-gatt/level-model.c:153:
+             i++) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#265: FILE: tools/mesh-gatt/level-model.c:154:
+                if(sscanf(argv[i], "%d", &parms[i]) <= 0)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#265: FILE: tools/mesh-gatt/level-model.c:154:
+                if(sscanf(argv[i], "%d", &parms[i]) <= 0)$

ERROR:SPACING: space required before the open parenthesis '('
#265: FILE: tools/mesh-gatt/level-model.c:154:
+                if(sscanf(argv[i], "%d", &parms[i]) <= 0)

ERROR:CODE_INDENT: code indent should use tabs where possible
#266: FILE: tools/mesh-gatt/level-model.c:155:
+                        break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#266: FILE: tools/mesh-gatt/level-model.c:155:
+                        break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#267: FILE: tools/mesh-gatt/level-model.c:156:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#267: FILE: tools/mesh-gatt/level-model.c:156:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#268: FILE: tools/mesh-gatt/level-model.c:157:
+        return i;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#268: FILE: tools/mesh-gatt/level-model.c:157:
+        return i;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#272: FILE: tools/mesh-gatt/level-model.c:161:
+        uint32_t dst;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#272: FILE: tools/mesh-gatt/level-model.c:161:
+        uint32_t dst;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#273: FILE: tools/mesh-gatt/level-model.c:162:
+        char *end;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#273: FILE: tools/mesh-gatt/level-model.c:162:
+        char *end;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#274: FILE: tools/mesh-gatt/level-model.c:163:
+        dst = strtol(argv[1], &end, 16);$

WARNING:LINE_SPACING: Missing a blank line after declarations
#274: FILE: tools/mesh-gatt/level-model.c:163:
+        char *end;
+        dst = strtol(argv[1], &end, 16);

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#274: FILE: tools/mesh-gatt/level-model.c:163:
+        dst = strtol(argv[1], &end, 16);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#275: FILE: tools/mesh-gatt/level-model.c:164:
+        if (end != (argv[1] + 4)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#275: FILE: tools/mesh-gatt/level-model.c:164:
+        if (end != (argv[1] + 4)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#276: FILE: tools/mesh-gatt/level-model.c:165:
+                bt_shell_printf("Bad unicast address %s: "$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#276: FILE: tools/mesh-gatt/level-model.c:165:
+                bt_shell_printf("Bad unicast address %s: "$

ERROR:CODE_INDENT: code indent should use tabs where possible
#277: FILE: tools/mesh-gatt/level-model.c:166:
+                                "expected format 4 digit hex\n", argv[1]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#277: FILE: tools/mesh-gatt/level-model.c:166:
+                                "expected format 4 digit hex\n", argv[1]);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#278: FILE: tools/mesh-gatt/level-model.c:167:
+                target = UNASSIGNED_ADDRESS;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#278: FILE: tools/mesh-gatt/level-model.c:167:
+                target = UNASSIGNED_ADDRESS;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#279: FILE: tools/mesh-gatt/level-model.c:168:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#279: FILE: tools/mesh-gatt/level-model.c:168:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#280: FILE: tools/mesh-gatt/level-model.c:169:
+        } else {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#280: FILE: tools/mesh-gatt/level-model.c:169:
+        } else {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#281: FILE: tools/mesh-gatt/level-model.c:170:
+                bt_shell_printf("Controlling Level for node %4.4x\n", dst);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#281: FILE: tools/mesh-gatt/level-model.c:170:
+                bt_shell_printf("Controlling Level for node %4.4x\n", dst);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#282: FILE: tools/mesh-gatt/level-model.c:171:
+                target = dst;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#282: FILE: tools/mesh-gatt/level-model.c:171:
+                target = dst;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#283: FILE: tools/mesh-gatt/level-model.c:172:
+                set_menu_prompt("Level", argv[1]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#283: FILE: tools/mesh-gatt/level-model.c:172:
+                set_menu_prompt("Level", argv[1]);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#284: FILE: tools/mesh-gatt/level-model.c:173:
+                return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#284: FILE: tools/mesh-gatt/level-model.c:173:
+                return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#285: FILE: tools/mesh-gatt/level-model.c:174:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#285: FILE: tools/mesh-gatt/level-model.c:174:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#289: FILE: tools/mesh-gatt/level-model.c:178:
+        struct mesh_node *node = node_get_local_node();$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#289: FILE: tools/mesh-gatt/level-model.c:178:
+        struct mesh_node *node = node_get_local_node();$

ERROR:CODE_INDENT: code indent should use tabs where possible
#290: FILE: tools/mesh-gatt/level-model.c:179:
+        uint8_t ttl;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#290: FILE: tools/mesh-gatt/level-model.c:179:
+        uint8_t ttl;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#291: FILE: tools/mesh-gatt/level-model.c:180:
+        if(!node)$

WARNING:LINE_SPACING: Missing a blank line after declarations
#291: FILE: tools/mesh-gatt/level-model.c:180:
+        uint8_t ttl;
+        if(!node)

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#291: FILE: tools/mesh-gatt/level-model.c:180:
+        if(!node)$

ERROR:SPACING: space required before the open parenthesis '('
#291: FILE: tools/mesh-gatt/level-model.c:180:
+        if(!node)

ERROR:CODE_INDENT: code indent should use tabs where possible
#292: FILE: tools/mesh-gatt/level-model.c:181:
+                return false;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#292: FILE: tools/mesh-gatt/level-model.c:181:
+                return false;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#293: FILE: tools/mesh-gatt/level-model.c:182:
+        ttl = node_get_default_ttl(node);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#293: FILE: tools/mesh-gatt/level-model.c:182:
+        ttl = node_get_default_ttl(node);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#294: FILE: tools/mesh-gatt/level-model.c:183:
+        return net_access_layer_send(ttl, node_get_primary(node),$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#294: FILE: tools/mesh-gatt/level-model.c:183:
+        return net_access_layer_send(ttl, node_get_primary(node),$

ERROR:CODE_INDENT: code indent should use tabs where possible
#295: FILE: tools/mesh-gatt/level-model.c:184:
+                                     target, level_app_idx, buf, len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#295: FILE: tools/mesh-gatt/level-model.c:184:
+                                     target, level_app_idx, buf, len);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#299: FILE: tools/mesh-gatt/level-model.c:188:
+        uint16_t n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#299: FILE: tools/mesh-gatt/level-model.c:188:
+        uint16_t n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#300: FILE: tools/mesh-gatt/level-model.c:189:
+        uint8_t msg[32];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#300: FILE: tools/mesh-gatt/level-model.c:189:
+        uint8_t msg[32];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#301: FILE: tools/mesh-gatt/level-model.c:190:
+        struct mesh_node *node;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#301: FILE: tools/mesh-gatt/level-model.c:190:
+        struct mesh_node *node;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#302: FILE: tools/mesh-gatt/level-model.c:191:
+        if (IS_UNASSIGNED(target)) {$

WARNING:LINE_SPACING: Missing a blank line after declarations
#302: FILE: tools/mesh-gatt/level-model.c:191:
+        struct mesh_node *node;
+        if (IS_UNASSIGNED(target)) {

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#302: FILE: tools/mesh-gatt/level-model.c:191:
+        if (IS_UNASSIGNED(target)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#303: FILE: tools/mesh-gatt/level-model.c:192:
+                bt_shell_printf("Destination not set\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#303: FILE: tools/mesh-gatt/level-model.c:192:
+                bt_shell_printf("Destination not set\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#304: FILE: tools/mesh-gatt/level-model.c:193:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#304: FILE: tools/mesh-gatt/level-model.c:193:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#305: FILE: tools/mesh-gatt/level-model.c:194:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#305: FILE: tools/mesh-gatt/level-model.c:194:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#306: FILE: tools/mesh-gatt/level-model.c:195:
+        node = node_find_by_addr(target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#306: FILE: tools/mesh-gatt/level-model.c:195:
+        node = node_find_by_addr(target);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#308: FILE: tools/mesh-gatt/level-model.c:197:
+        if (!node){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#308: FILE: tools/mesh-gatt/level-model.c:197:
+        if (!node){$

ERROR:SPACING: space required before the open brace '{'
#308: FILE: tools/mesh-gatt/level-model.c:197:
+        if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#308: FILE: tools/mesh-gatt/level-model.c:197:
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#309: FILE: tools/mesh-gatt/level-model.c:198:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:CODE_INDENT: code indent should use tabs where possible
#309: FILE: tools/mesh-gatt/level-model.c:198:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#309: FILE: tools/mesh-gatt/level-model.c:198:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#309: FILE: tools/mesh-gatt/level-model.c:198:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
                                                                              ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#310: FILE: tools/mesh-gatt/level-model.c:199:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#310: FILE: tools/mesh-gatt/level-model.c:199:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#312: FILE: tools/mesh-gatt/level-model.c:201:
+        n = mesh_opcode_set(OP_GENERIC_LEVEL_GET, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#312: FILE: tools/mesh-gatt/level-model.c:201:
+        n = mesh_opcode_set(OP_GENERIC_LEVEL_GET, msg);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#313: FILE: tools/mesh-gatt/level-model.c:202:
+        if (!send_cmd(msg, n)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#313: FILE: tools/mesh-gatt/level-model.c:202:
+        if (!send_cmd(msg, n)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#314: FILE: tools/mesh-gatt/level-model.c:203:
+                bt_shell_printf("Failed to send \"GENERIC LEVEL GET\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#314: FILE: tools/mesh-gatt/level-model.c:203:
+                bt_shell_printf("Failed to send \"GENERIC LEVEL GET\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#315: FILE: tools/mesh-gatt/level-model.c:204:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#315: FILE: tools/mesh-gatt/level-model.c:204:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#316: FILE: tools/mesh-gatt/level-model.c:205:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#316: FILE: tools/mesh-gatt/level-model.c:205:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#317: FILE: tools/mesh-gatt/level-model.c:206:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#317: FILE: tools/mesh-gatt/level-model.c:206:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#321: FILE: tools/mesh-gatt/level-model.c:210:
+        uint16_t n;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#321: FILE: tools/mesh-gatt/level-model.c:210:
+        uint16_t n;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#322: FILE: tools/mesh-gatt/level-model.c:211:
+        uint8_t msg[32];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#322: FILE: tools/mesh-gatt/level-model.c:211:
+        uint8_t msg[32];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#323: FILE: tools/mesh-gatt/level-model.c:212:
+        struct mesh_node *node;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#323: FILE: tools/mesh-gatt/level-model.c:212:
+        struct mesh_node *node;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#324: FILE: tools/mesh-gatt/level-model.c:213:
+        uint8_t *p;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#324: FILE: tools/mesh-gatt/level-model.c:213:
+        uint8_t *p;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#325: FILE: tools/mesh-gatt/level-model.c:214:
+        int np;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#325: FILE: tools/mesh-gatt/level-model.c:214:
+        int np;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#326: FILE: tools/mesh-gatt/level-model.c:215:
+        uint32_t opcode;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#326: FILE: tools/mesh-gatt/level-model.c:215:
+        uint32_t opcode;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#327: FILE: tools/mesh-gatt/level-model.c:216:
+        int16_t level;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#327: FILE: tools/mesh-gatt/level-model.c:216:
+        int16_t level;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#329: FILE: tools/mesh-gatt/level-model.c:218:
+        if (IS_UNASSIGNED(target)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#329: FILE: tools/mesh-gatt/level-model.c:218:
+        if (IS_UNASSIGNED(target)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#330: FILE: tools/mesh-gatt/level-model.c:219:
+                bt_shell_printf("Destination not set\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#330: FILE: tools/mesh-gatt/level-model.c:219:
+                bt_shell_printf("Destination not set\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#331: FILE: tools/mesh-gatt/level-model.c:220:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#331: FILE: tools/mesh-gatt/level-model.c:220:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#332: FILE: tools/mesh-gatt/level-model.c:221:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#332: FILE: tools/mesh-gatt/level-model.c:221:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#333: FILE: tools/mesh-gatt/level-model.c:222:
+        node = node_find_by_addr(target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#333: FILE: tools/mesh-gatt/level-model.c:222:
+        node = node_find_by_addr(target);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#335: FILE: tools/mesh-gatt/level-model.c:224:
+        if (!node){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#335: FILE: tools/mesh-gatt/level-model.c:224:
+        if (!node){$

ERROR:SPACING: space required before the open brace '{'
#335: FILE: tools/mesh-gatt/level-model.c:224:
+        if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#335: FILE: tools/mesh-gatt/level-model.c:224:
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#336: FILE: tools/mesh-gatt/level-model.c:225:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:CODE_INDENT: code indent should use tabs where possible
#336: FILE: tools/mesh-gatt/level-model.c:225:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#336: FILE: tools/mesh-gatt/level-model.c:225:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#336: FILE: tools/mesh-gatt/level-model.c:225:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
                                                                              ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#337: FILE: tools/mesh-gatt/level-model.c:226:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#337: FILE: tools/mesh-gatt/level-model.c:226:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#339: FILE: tools/mesh-gatt/level-model.c:228:
+        np = read_input_parameters(argc, argv);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#339: FILE: tools/mesh-gatt/level-model.c:228:
+        np = read_input_parameters(argc, argv);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#340: FILE: tools/mesh-gatt/level-model.c:229:
+        if ((np != 1) && (np != 2) &&$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#340: FILE: tools/mesh-gatt/level-model.c:229:
+        if ((np != 1) && (np != 2) &&$

ERROR:CODE_INDENT: code indent should use tabs where possible
#341: FILE: tools/mesh-gatt/level-model.c:230:
+                        parms[0] < -32768 && parms[0] > 32767 &&$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#341: FILE: tools/mesh-gatt/level-model.c:230:
+                        parms[0] < -32768 && parms[0] > 32767 &&$

ERROR:CODE_INDENT: code indent should use tabs where possible
#342: FILE: tools/mesh-gatt/level-model.c:231:
+                        parms[1] != 0 && parms[1] != 1) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#342: FILE: tools/mesh-gatt/level-model.c:231:
+                        parms[1] != 0 && parms[1] != 1) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#343: FILE: tools/mesh-gatt/level-model.c:232:
+                bt_shell_printf("Bad arguments: Expecting an integer "$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#343: FILE: tools/mesh-gatt/level-model.c:232:
+                bt_shell_printf("Bad arguments: Expecting an integer "$

ERROR:CODE_INDENT: code indent should use tabs where possible
#344: FILE: tools/mesh-gatt/level-model.c:233:
+                                "-32768 to 32767 and an optional 0 or 1 as unack\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#344: FILE: tools/mesh-gatt/level-model.c:233:
+                                "-32768 to 32767 and an optional 0 or 1 as unack\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#345: FILE: tools/mesh-gatt/level-model.c:234:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#345: FILE: tools/mesh-gatt/level-model.c:234:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#346: FILE: tools/mesh-gatt/level-model.c:235:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#346: FILE: tools/mesh-gatt/level-model.c:235:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){$

ERROR:SPACING: spaces required around that '==' (ctx:VxV)
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){
                ^

ERROR:SPACING: space required before the open brace '{'
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){

ERROR:SPACING: space prohibited after that open parenthesis '('
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){

ERROR:SPACING: space prohibited before that close parenthesis ')'
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){

ERROR:SPACING: space required before the open parenthesis '('
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){

WARNING:BRACES: braces {} are not necessary for any arm of this statement
#348: FILE: tools/mesh-gatt/level-model.c:237:
+        if( (np==2) && parms[1] ){
[...]
+        }else{
[...]

ERROR:CODE_INDENT: code indent should use tabs where possible
#349: FILE: tools/mesh-gatt/level-model.c:238:
+                opcode = OP_GENERIC_LEVEL_SET_UNACK;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#349: FILE: tools/mesh-gatt/level-model.c:238:
+                opcode = OP_GENERIC_LEVEL_SET_UNACK;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#350: FILE: tools/mesh-gatt/level-model.c:239:
+        }else{$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#350: FILE: tools/mesh-gatt/level-model.c:239:
+        }else{$

ERROR:SPACING: space required before the open brace '{'
#350: FILE: tools/mesh-gatt/level-model.c:239:
+        }else{

ERROR:SPACING: space required after that close brace '}'
#350: FILE: tools/mesh-gatt/level-model.c:239:
+        }else{

ERROR:CODE_INDENT: code indent should use tabs where possible
#351: FILE: tools/mesh-gatt/level-model.c:240:
+                opcode = OP_GENERIC_LEVEL_SET;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#351: FILE: tools/mesh-gatt/level-model.c:240:
+                opcode = OP_GENERIC_LEVEL_SET;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#352: FILE: tools/mesh-gatt/level-model.c:241:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#352: FILE: tools/mesh-gatt/level-model.c:241:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#354: FILE: tools/mesh-gatt/level-model.c:243:
+        n = mesh_opcode_set(opcode, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#354: FILE: tools/mesh-gatt/level-model.c:243:
+        n = mesh_opcode_set(opcode, msg);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#355: FILE: tools/mesh-gatt/level-model.c:244:
+        level = (int16_t)parms[0];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#355: FILE: tools/mesh-gatt/level-model.c:244:
+        level = (int16_t)parms[0];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#356: FILE: tools/mesh-gatt/level-model.c:245:
+        p = (uint8_t *)&level;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#356: FILE: tools/mesh-gatt/level-model.c:245:
+        p = (uint8_t *)&level;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#358: FILE: tools/mesh-gatt/level-model.c:247:
+        msg[n++] = p[0];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#358: FILE: tools/mesh-gatt/level-model.c:247:
+        msg[n++] = p[0];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#359: FILE: tools/mesh-gatt/level-model.c:248:
+        msg[n++] = p[1];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#359: FILE: tools/mesh-gatt/level-model.c:248:
+        msg[n++] = p[1];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#361: FILE: tools/mesh-gatt/level-model.c:250:
+        msg[n++] = p[1];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#361: FILE: tools/mesh-gatt/level-model.c:250:
+        msg[n++] = p[1];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#362: FILE: tools/mesh-gatt/level-model.c:251:
+        msg[n++] = p[0];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#362: FILE: tools/mesh-gatt/level-model.c:251:
+        msg[n++] = p[0];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#367: FILE: tools/mesh-gatt/level-model.c:256:
+        msg[n++] = trans_id++;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#367: FILE: tools/mesh-gatt/level-model.c:256:
+        msg[n++] = trans_id++;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#368: FILE: tools/mesh-gatt/level-model.c:257:
+        if (!send_cmd(msg, n)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#368: FILE: tools/mesh-gatt/level-model.c:257:
+        if (!send_cmd(msg, n)) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#369: FILE: tools/mesh-gatt/level-model.c:258:
+                bt_shell_printf("Failed to send \"GENERIC LEVEL SET\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#369: FILE: tools/mesh-gatt/level-model.c:258:
+                bt_shell_printf("Failed to send \"GENERIC LEVEL SET\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#370: FILE: tools/mesh-gatt/level-model.c:259:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#370: FILE: tools/mesh-gatt/level-model.c:259:
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#371: FILE: tools/mesh-gatt/level-model.c:260:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#371: FILE: tools/mesh-gatt/level-model.c:260:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#372: FILE: tools/mesh-gatt/level-model.c:261:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#372: FILE: tools/mesh-gatt/level-model.c:261:
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#375: FILE: tools/mesh-gatt/level-model.c:264:
+        .name = "level",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#375: FILE: tools/mesh-gatt/level-model.c:264:
+        .name = "level",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#376: FILE: tools/mesh-gatt/level-model.c:265:
+        .desc = "Level Model Submenu",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#376: FILE: tools/mesh-gatt/level-model.c:265:
+        .desc = "Level Model Submenu",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#377: FILE: tools/mesh-gatt/level-model.c:266:
+        .entries = {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#377: FILE: tools/mesh-gatt/level-model.c:266:
+        .entries = {$

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#378: FILE: tools/mesh-gatt/level-model.c:267:
+                {"target",		"<unicast>",			cmd_set_node,

ERROR:CODE_INDENT: code indent should use tabs where possible
#378: FILE: tools/mesh-gatt/level-model.c:267:
+                {"target",^I^I"<unicast>",^I^I^Icmd_set_node,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#378: FILE: tools/mesh-gatt/level-model.c:267:
+                {"target",^I^I"<unicast>",^I^I^Icmd_set_node,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#379: FILE: tools/mesh-gatt/level-model.c:268:
+                 "Set node to configure"},$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#379: FILE: tools/mesh-gatt/level-model.c:268:
+                 "Set node to configure"},$

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#380: FILE: tools/mesh-gatt/level-model.c:269:
+                {"get",			NULL,				cmd_get_status,

ERROR:CODE_INDENT: code indent should use tabs where possible
#380: FILE: tools/mesh-gatt/level-model.c:269:
+                {"get",^I^I^INULL,^I^I^I^Icmd_get_status,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#380: FILE: tools/mesh-gatt/level-model.c:269:
+                {"get",^I^I^INULL,^I^I^I^Icmd_get_status,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#381: FILE: tools/mesh-gatt/level-model.c:270:
+                 "Get Level status"},$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#381: FILE: tools/mesh-gatt/level-model.c:270:
+                 "Get Level status"},$

ERROR:CODE_INDENT: code indent should use tabs where possible
#382: FILE: tools/mesh-gatt/level-model.c:271:
+                {"level",^I^I"<-32768/+32767> [unack]",^Icmd_set,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#382: FILE: tools/mesh-gatt/level-model.c:271:
+                {"level",^I^I"<-32768/+32767> [unack]",^Icmd_set,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#383: FILE: tools/mesh-gatt/level-model.c:272:
+                 "Send \"SET Level\" command"},$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#383: FILE: tools/mesh-gatt/level-model.c:272:
+                 "Send \"SET Level\" command"},$

ERROR:CODE_INDENT: code indent should use tabs where possible
#384: FILE: tools/mesh-gatt/level-model.c:273:
+                {} },$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#384: FILE: tools/mesh-gatt/level-model.c:273:
+                {} },$

ERROR:CODE_INDENT: code indent should use tabs where possible
#387: FILE: tools/mesh-gatt/level-model.c:276:
+        client_msg_recvd,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#387: FILE: tools/mesh-gatt/level-model.c:276:
+        client_msg_recvd,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#388: FILE: tools/mesh-gatt/level-model.c:277:
+        client_bind,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#388: FILE: tools/mesh-gatt/level-model.c:277:
+        client_bind,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#389: FILE: tools/mesh-gatt/level-model.c:278:
+        NULL,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#389: FILE: tools/mesh-gatt/level-model.c:278:
+        NULL,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#390: FILE: tools/mesh-gatt/level-model.c:279:
+        NULL$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#390: FILE: tools/mesh-gatt/level-model.c:279:
+        NULL$

ERROR:CODE_INDENT: code indent should use tabs where possible
#394: FILE: tools/mesh-gatt/level-model.c:283:
+        if (!node_local_model_register(ele, GENERIC_LEVEL_CLIENT_MODEL_ID,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#394: FILE: tools/mesh-gatt/level-model.c:283:
+        if (!node_local_model_register(ele, GENERIC_LEVEL_CLIENT_MODEL_ID,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#395: FILE: tools/mesh-gatt/level-model.c:284:
+                                       &client_cbs, NULL))$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#395: FILE: tools/mesh-gatt/level-model.c:284:
+                                       &client_cbs, NULL))$

ERROR:CODE_INDENT: code indent should use tabs where possible
#396: FILE: tools/mesh-gatt/level-model.c:285:
+                return false;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#396: FILE: tools/mesh-gatt/level-model.c:285:
+                return false;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#397: FILE: tools/mesh-gatt/level-model.c:286:
+        bt_shell_add_submenu(&level_menu);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#397: FILE: tools/mesh-gatt/level-model.c:286:
+        bt_shell_add_submenu(&level_menu);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#398: FILE: tools/mesh-gatt/level-model.c:287:
+        return true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#398: FILE: tools/mesh-gatt/level-model.c:287:
+        return true;$

/github/workspace/src/12662891.patch total: 209 errors, 207 warnings, 353 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12662891.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,6/6] tools/mesh-gatt: Add generic power onoff client model
ERROR:CODE_INDENT: code indent should use tabs where possible
#181: FILE: tools/mesh-gatt/onpowerup-model.c:45:
+                if (power_onoff_app_idx != APP_IDX_INVALID) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#181: FILE: tools/mesh-gatt/onpowerup-model.c:45:
+                if (power_onoff_app_idx != APP_IDX_INVALID) {$

WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
#183: FILE: tools/mesh-gatt/onpowerup-model.c:47:
+			return MESH_STATUS_INSUFF_RESOURCES;
+		} else {

ERROR:CODE_INDENT: code indent should use tabs where possible
#184: FILE: tools/mesh-gatt/onpowerup-model.c:48:
+                        power_onoff_app_idx = app_idx;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#184: FILE: tools/mesh-gatt/onpowerup-model.c:48:
+                        power_onoff_app_idx = app_idx;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#185: FILE: tools/mesh-gatt/onpowerup-model.c:49:
+                        bt_shell_printf("OnPowerUp client model: new binding"$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#185: FILE: tools/mesh-gatt/onpowerup-model.c:49:
+                        bt_shell_printf("OnPowerUp client model: new binding"$

ERROR:CODE_INDENT: code indent should use tabs where possible
#189: FILE: tools/mesh-gatt/onpowerup-model.c:53:
+                if (power_onoff_app_idx == app_idx)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#189: FILE: tools/mesh-gatt/onpowerup-model.c:53:
+                if (power_onoff_app_idx == app_idx)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#190: FILE: tools/mesh-gatt/onpowerup-model.c:54:
+                        power_onoff_app_idx = APP_IDX_INVALID;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#190: FILE: tools/mesh-gatt/onpowerup-model.c:54:
+                        power_onoff_app_idx = APP_IDX_INVALID;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#200: FILE: tools/mesh-gatt/onpowerup-model.c:64:
+        char s[10];$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#200: FILE: tools/mesh-gatt/onpowerup-model.c:64:
+        char s[10];$

ERROR:CODE_INDENT: code indent should use tabs where possible
#212: FILE: tools/mesh-gatt/onpowerup-model.c:76:
+        case OP_GENERIC_POWER_ONOFF_STATUS:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#212: FILE: tools/mesh-gatt/onpowerup-model.c:76:
+        case OP_GENERIC_POWER_ONOFF_STATUS:$

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#213: FILE: tools/mesh-gatt/onpowerup-model.c:77:
+                bt_shell_printf("OnPowerUp Model Message received (%d) opcode %x\n",

ERROR:CODE_INDENT: code indent should use tabs where possible
#213: FILE: tools/mesh-gatt/onpowerup-model.c:77:
+                bt_shell_printf("OnPowerUp Model Message received (%d) opcode %x\n",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#213: FILE: tools/mesh-gatt/onpowerup-model.c:77:
+                bt_shell_printf("OnPowerUp Model Message received (%d) opcode %x\n",$

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#214: FILE: tools/mesh-gatt/onpowerup-model.c:78:
+                                                                        len, opcode);

ERROR:CODE_INDENT: code indent should use tabs where possible
#214: FILE: tools/mesh-gatt/onpowerup-model.c:78:
+                                                                        len, opcode);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#214: FILE: tools/mesh-gatt/onpowerup-model.c:78:
+                                                                        len, opcode);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#215: FILE: tools/mesh-gatt/onpowerup-model.c:79:
+                print_byte_array("\t",data, len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#215: FILE: tools/mesh-gatt/onpowerup-model.c:79:
+                print_byte_array("\t",data, len);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#215: FILE: tools/mesh-gatt/onpowerup-model.c:79:
+                print_byte_array("\t",data, len);
                                      ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#216: FILE: tools/mesh-gatt/onpowerup-model.c:80:
+                if (len != 1)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#216: FILE: tools/mesh-gatt/onpowerup-model.c:80:
+                if (len != 1)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#217: FILE: tools/mesh-gatt/onpowerup-model.c:81:
+                        break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#217: FILE: tools/mesh-gatt/onpowerup-model.c:81:
+                        break;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 20)
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){
+                    sprintf(s, "%s", "OFF");

ERROR:SPACING: space required before the open brace '{'
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){

ERROR:SPACING: space required before the open parenthesis '('
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){

WARNING:BRACES: braces {} are not necessary for any arm of this statement
#218: FILE: tools/mesh-gatt/onpowerup-model.c:82:
+                if(data[0] == 0){
[...]
+                }else if(data[0] == 1){
[...]
+                }else if(data[0] == 2){
[...]
+                }else{
[...]

ERROR:CODE_INDENT: code indent should use tabs where possible
#219: FILE: tools/mesh-gatt/onpowerup-model.c:83:
+                    sprintf(s, "%s", "OFF");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#219: FILE: tools/mesh-gatt/onpowerup-model.c:83:
+                    sprintf(s, "%s", "OFF");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 20)
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){
+                    sprintf(s, "%s", "ON");

ERROR:SPACING: space required before the open brace '{'
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){

ERROR:SPACING: space required after that close brace '}'
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){

ERROR:SPACING: space required before the open parenthesis '('
#220: FILE: tools/mesh-gatt/onpowerup-model.c:84:
+                }else if(data[0] == 1){

ERROR:CODE_INDENT: code indent should use tabs where possible
#221: FILE: tools/mesh-gatt/onpowerup-model.c:85:
+                    sprintf(s, "%s", "ON");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#221: FILE: tools/mesh-gatt/onpowerup-model.c:85:
+                    sprintf(s, "%s", "ON");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 20)
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){
+                    sprintf(s, "%s", "RESUME");

ERROR:SPACING: space required before the open brace '{'
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){

ERROR:SPACING: space required after that close brace '}'
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){

ERROR:SPACING: space required before the open parenthesis '('
#222: FILE: tools/mesh-gatt/onpowerup-model.c:86:
+                }else if(data[0] == 2){

ERROR:CODE_INDENT: code indent should use tabs where possible
#223: FILE: tools/mesh-gatt/onpowerup-model.c:87:
+                    sprintf(s, "%s", "RESUME");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#223: FILE: tools/mesh-gatt/onpowerup-model.c:87:
+                    sprintf(s, "%s", "RESUME");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#224: FILE: tools/mesh-gatt/onpowerup-model.c:88:
+                }else{$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#224: FILE: tools/mesh-gatt/onpowerup-model.c:88:
+                }else{$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 20)
#224: FILE: tools/mesh-gatt/onpowerup-model.c:88:
+                }else{
+                    sprintf(s, "%s", "?UNKNOWN");

ERROR:SPACING: space required before the open brace '{'
#224: FILE: tools/mesh-gatt/onpowerup-model.c:88:
+                }else{

ERROR:SPACING: space required after that close brace '}'
#224: FILE: tools/mesh-gatt/onpowerup-model.c:88:
+                }else{

ERROR:CODE_INDENT: code indent should use tabs where possible
#225: FILE: tools/mesh-gatt/onpowerup-model.c:89:
+                    sprintf(s, "%s", "?UNKNOWN");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#225: FILE: tools/mesh-gatt/onpowerup-model.c:89:
+                    sprintf(s, "%s", "?UNKNOWN");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#226: FILE: tools/mesh-gatt/onpowerup-model.c:90:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#226: FILE: tools/mesh-gatt/onpowerup-model.c:90:
+                }$

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#227: FILE: tools/mesh-gatt/onpowerup-model.c:91:
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present = %s\n", src, s);

ERROR:CODE_INDENT: code indent should use tabs where possible
#227: FILE: tools/mesh-gatt/onpowerup-model.c:91:
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present = %s\n", src, s);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#227: FILE: tools/mesh-gatt/onpowerup-model.c:91:
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present = %s\n", src, s);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#228: FILE: tools/mesh-gatt/onpowerup-model.c:92:
+                break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#228: FILE: tools/mesh-gatt/onpowerup-model.c:92:
+                break;$

WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'
#252: FILE: tools/mesh-gatt/onpowerup-model.c:116:
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;

WARNING:ARRAY_SIZE: Prefer ARRAY_SIZE(parms)
#252: FILE: tools/mesh-gatt/onpowerup-model.c:116:
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;

WARNING:NAKED_SSCANF: unchecked sscanf return value
#254: FILE: tools/mesh-gatt/onpowerup-model.c:118:
+		sscanf(argv[i], "%x", &parms[i]);

WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
#273: FILE: tools/mesh-gatt/onpowerup-model.c:137:
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {

ERROR:CODE_INDENT: code indent should use tabs where possible
#274: FILE: tools/mesh-gatt/onpowerup-model.c:138:
+                bt_shell_printf("Controlling OnPowerUp for node %4.4x\n", dst);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#274: FILE: tools/mesh-gatt/onpowerup-model.c:138:
+                bt_shell_printf("Controlling OnPowerUp for node %4.4x\n", dst);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#276: FILE: tools/mesh-gatt/onpowerup-model.c:140:
+                set_menu_prompt("OnPowerUp", argv[1]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#276: FILE: tools/mesh-gatt/onpowerup-model.c:140:
+                set_menu_prompt("OnPowerUp", argv[1]);$

ERROR:SPACING: space required before the open parenthesis '('
#286: FILE: tools/mesh-gatt/onpowerup-model.c:150:
+	if(!node)

ERROR:CODE_INDENT: code indent should use tabs where possible
#292: FILE: tools/mesh-gatt/onpowerup-model.c:156:
+                                        target, power_onoff_app_idx, buf, len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#292: FILE: tools/mesh-gatt/onpowerup-model.c:156:
+                                        target, power_onoff_app_idx, buf, len);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#308: FILE: tools/mesh-gatt/onpowerup-model.c:172:
+        if (!node){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#308: FILE: tools/mesh-gatt/onpowerup-model.c:172:
+        if (!node){$

ERROR:SPACING: space required before the open brace '{'
#308: FILE: tools/mesh-gatt/onpowerup-model.c:172:
+        if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#308: FILE: tools/mesh-gatt/onpowerup-model.c:172:
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#309: FILE: tools/mesh-gatt/onpowerup-model.c:173:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:CODE_INDENT: code indent should use tabs where possible
#309: FILE: tools/mesh-gatt/onpowerup-model.c:173:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#309: FILE: tools/mesh-gatt/onpowerup-model.c:173:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#309: FILE: tools/mesh-gatt/onpowerup-model.c:173:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
                                                                              ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#310: FILE: tools/mesh-gatt/onpowerup-model.c:174:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#310: FILE: tools/mesh-gatt/onpowerup-model.c:174:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#312: FILE: tools/mesh-gatt/onpowerup-model.c:176:
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_GET, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#312: FILE: tools/mesh-gatt/onpowerup-model.c:176:
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_GET, msg);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#315: FILE: tools/mesh-gatt/onpowerup-model.c:179:
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF GET\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#315: FILE: tools/mesh-gatt/onpowerup-model.c:179:
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF GET\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#335: FILE: tools/mesh-gatt/onpowerup-model.c:199:
+        if (!node){$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#335: FILE: tools/mesh-gatt/onpowerup-model.c:199:
+        if (!node){$

ERROR:SPACING: space required before the open brace '{'
#335: FILE: tools/mesh-gatt/onpowerup-model.c:199:
+        if (!node){

WARNING:BRACES: braces {} are not necessary for single statement blocks
#335: FILE: tools/mesh-gatt/onpowerup-model.c:199:
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#336: FILE: tools/mesh-gatt/onpowerup-model.c:200:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);

ERROR:CODE_INDENT: code indent should use tabs where possible
#336: FILE: tools/mesh-gatt/onpowerup-model.c:200:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#336: FILE: tools/mesh-gatt/onpowerup-model.c:200:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);$

ERROR:SPACING: space required after that ',' (ctx:VxV)
#336: FILE: tools/mesh-gatt/onpowerup-model.c:200:
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
                                                                              ^

ERROR:CODE_INDENT: code indent should use tabs where possible
#337: FILE: tools/mesh-gatt/onpowerup-model.c:201:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#337: FILE: tools/mesh-gatt/onpowerup-model.c:201:
+        }$

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#340: FILE: tools/mesh-gatt/onpowerup-model.c:204:
+                                        parms[0] != 0 && parms[0] != 1 && parms[0] != 2) {

ERROR:CODE_INDENT: code indent should use tabs where possible
#340: FILE: tools/mesh-gatt/onpowerup-model.c:204:
+                                        parms[0] != 0 && parms[0] != 1 && parms[0] != 2) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#340: FILE: tools/mesh-gatt/onpowerup-model.c:204:
+                                        parms[0] != 0 && parms[0] != 1 && parms[0] != 2) {$

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#341: FILE: tools/mesh-gatt/onpowerup-model.c:205:
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" or \"2\"\n");

ERROR:CODE_INDENT: code indent should use tabs where possible
#341: FILE: tools/mesh-gatt/onpowerup-model.c:205:
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" or \"2\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#341: FILE: tools/mesh-gatt/onpowerup-model.c:205:
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" or \"2\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#345: FILE: tools/mesh-gatt/onpowerup-model.c:209:
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_SET, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#345: FILE: tools/mesh-gatt/onpowerup-model.c:209:
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_SET, msg);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#350: FILE: tools/mesh-gatt/onpowerup-model.c:214:
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF SET\"\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#350: FILE: tools/mesh-gatt/onpowerup-model.c:214:
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF SET\"\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#358: FILE: tools/mesh-gatt/onpowerup-model.c:222:
+        .name = "power_onoff",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#358: FILE: tools/mesh-gatt/onpowerup-model.c:222:
+        .name = "power_onoff",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#359: FILE: tools/mesh-gatt/onpowerup-model.c:223:
+        .desc = "Power OnOff (OnPowerUp) Model Submenu",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#359: FILE: tools/mesh-gatt/onpowerup-model.c:223:
+        .desc = "Power OnOff (OnPowerUp) Model Submenu",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#364: FILE: tools/mesh-gatt/onpowerup-model.c:228:
+                                                "Get OnPowerUp status"},$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#364: FILE: tools/mesh-gatt/onpowerup-model.c:228:
+                                                "Get OnPowerUp status"},$

ERROR:CODE_INDENT: code indent should use tabs where possible
#365: FILE: tools/mesh-gatt/onpowerup-model.c:229:
+        {"set",                 "<0/1/2>",^I^I^Icmd_set,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#365: FILE: tools/mesh-gatt/onpowerup-model.c:229:
+        {"set",                 "<0/1/2>",^I^I^Icmd_set,$

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#366: FILE: tools/mesh-gatt/onpowerup-model.c:230:
+                                                "Set OnPowerUp status (OFF/ON/RESTORE)"},

ERROR:CODE_INDENT: code indent should use tabs where possible
#366: FILE: tools/mesh-gatt/onpowerup-model.c:230:
+                                                "Set OnPowerUp status (OFF/ON/RESTORE)"},$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#366: FILE: tools/mesh-gatt/onpowerup-model.c:230:
+                                                "Set OnPowerUp status (OFF/ON/RESTORE)"},$

ERROR:CODE_INDENT: code indent should use tabs where possible
#379: FILE: tools/mesh-gatt/onpowerup-model.c:243:
+        if (!node_local_model_register(ele, GENERIC_POWER_ONOFF_CLIENT_MODEL_ID,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#379: FILE: tools/mesh-gatt/onpowerup-model.c:243:
+        if (!node_local_model_register(ele, GENERIC_POWER_ONOFF_CLIENT_MODEL_ID,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#383: FILE: tools/mesh-gatt/onpowerup-model.c:247:
+        bt_shell_add_submenu(&power_onoff_menu);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#383: FILE: tools/mesh-gatt/onpowerup-model.c:247:
+        bt_shell_add_submenu(&power_onoff_menu);$

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#431: FILE: tools/meshctl.c:2008:
+		g_printerr("Failed to initialize mesh generic power On/Off client\n");

/github/workspace/src/12662893.patch total: 61 errors, 66 warnings, 315 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12662893.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,4/6] tools/mesh-gatt: Add subscription delete message to config client model
1: T1 Title exceeds max length (83>80): "[BlueZ,4/6] tools/mesh-gatt: Add subscription delete message to config client model"




---
Regards,
Linux Bluetooth


--===============1770561061006161030==--
