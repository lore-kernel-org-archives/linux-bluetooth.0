Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08503C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A9822AED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgLUXmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLUXmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 18:42:43 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E1C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:42:03 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 4so5272965qvh.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ed16FIvb0jNPL1Xpyo7AQSNNI6DK983ulBqliW51yXE=;
        b=Ld0d+dC/WhOLkvoZkFn+wWklkbmTsAKfILT3wc/iez3sDk2eZpMDqm9yqciT+WZ0Mj
         758GuXgv8sobKk0rAb+YZfCogSawBdHE9MaVeaA1t/Y5IJbP8FgLw17LQ+oWBi9bXZ78
         tlS3hs9CGMQZ0edGFWRoiAmcNwV1o0jibjJ7hYn3Kn1gL8E3Zu14N+w/c0RAWFJUe8yK
         IT+Ooo09+QRVyV0cfPxy8e6lSWksjfXsquA2Kp+1a1PmLeX3S5cJ7myxTUz6rN9snT2P
         IcJSctKbcMUtenhcr4X70Rizsv2va0+7lJ+P8SaCu6D35XFW6kQY8LULKYvsgSAnRq0K
         djyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ed16FIvb0jNPL1Xpyo7AQSNNI6DK983ulBqliW51yXE=;
        b=Od2y5AWfQzu4b1KgJbkOZx7bcMd23vyXMya74odlb0GbNiQzU3aNT9WJp/xJ/D4OoC
         WyB7yAZIpFoj6w+I42S8sMQ3ahc1KsHcQTgS3Xt+zKrQzqiifI/4mF63x7vwVtg04LL5
         0Cs+ibW2y54dsNA9jkpt09rouQb3pZmO+H3viYnrr7kuuQS0Hmmla7lqORK3f6cJphDg
         DIANC5t+cBWmWUepEM6GkuAlkeAhwRzp536k83Y3lbkrJM2rlbijKqIuGUH4/gQKRp3s
         kj0aLf/j5XTmRVB3tvbXTLsIdXLwR0yTv5vNbiAWaM+Vv5MyolaPrI2XgyWCpAX3QgYv
         USuw==
X-Gm-Message-State: AOAM531ig8BO+N4zKRLF+6peLz0a2bOhI/ilTsoO+cDdU4u/kSvWjiJC
        qtv66mWg/GtnS2bETXXvE9OFTJ1dusSczw==
X-Google-Smtp-Source: ABdhPJxcG4IqFuM4C/y3xGkTZAGQb5PZ7t3EkF2L2t3V4PDmEPEII286uAMQ5HHzxB6zOpzTvgzeQQ==
X-Received: by 2002:a0c:f991:: with SMTP id t17mr19349357qvn.6.1608594122699;
        Mon, 21 Dec 2020 15:42:02 -0800 (PST)
Received: from [172.17.0.2] ([40.79.66.247])
        by smtp.gmail.com with ESMTPSA id 102sm10838059qtg.45.2020.12.21.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 15:42:02 -0800 (PST)
Message-ID: <5fe132ca.1c69fb81.982f9.47c3@mx.google.com>
Date:   Mon, 21 Dec 2020 15:42:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5940953984446061014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201221230140.2100824-1-luiz.dentz@gmail.com>
References: <20201221230140.2100824-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5940953984446061014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405035

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
lib: Add definitions for ISO socket
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#55: FILE: lib/iso.h:1:
+/*

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#73: FILE: lib/iso.h:19:
+ *  along with this program; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#74: FILE: lib/iso.h:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

- total: 2 errors, 1 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] lib: Add definitions for ISO socket" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

tools: Add isotest tool
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#91: FILE: tools/isotest.c:55:
+static int defer_setup = 0;

ERROR:GLOBAL_INITIALISERS: do not initialise globals to NULL
#93: FILE: tools/isotest.c:57:
+struct bt_iso_qos *iso_qos = NULL;

ERROR:SPACING: space required after that ',' (ctx:VxV)
#271: FILE: tools/isotest.c:235:
+		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
 		              ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#276: FILE: tools/isotest.c:240:
+	syslog(LOG_INFO,"Waiting for connection ...");
 	               ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#284: FILE: tools/isotest.c:248:
+			syslog(LOG_ERR,"Accept failed: %s (%d)",
 			              ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#337: FILE: tools/isotest.c:301:
+	syslog(LOG_INFO,"Receiving ...");
 	               ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#353: FILE: tools/isotest.c:317:
+	struct timeval tv_beg,tv_end,tv_diff;
 	                     ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#353: FILE: tools/isotest.c:317:
+	struct timeval tv_beg,tv_end,tv_diff;
 	                            ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#399: FILE: tools/isotest.c:363:
+		syslog(LOG_INFO,"%ld bytes in %.2f sec speed %.2f kb/s", total,
 		               ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#409: FILE: tools/isotest.c:373:
+	syslog(LOG_INFO,"Opening %s ...", filename);
 	               ^

ERROR:SPACING: space required after that ',' (ctx:VxV)
#455: FILE: tools/isotest.c:419:
+	syslog(LOG_INFO,"Sending ...");
 	               ^

ERROR:SPACING: space required before the open brace '{'
#519: FILE: tools/isotest.c:483:
+		for (i = 0; i < 10; i++){

ERROR:SPACING: space prohibited before that ',' (ctx:WxV)
#661: FILE: tools/isotest.c:625:
+int main(int argc ,char *argv[])
                   ^

ERROR:SPACING: space required after that ',' (ctx:WxV)
#661: FILE: tools/isotest.c:625:
+int main(int argc ,char *argv[])
                   ^

ERROR:SPACING: space required before the open parenthesis '('
#683: FILE: tools/isotest.c:647:
+		switch(opt) {

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#797: FILE: tools/isotest.c:761:
+		/* Fallthrough */

- total: 15 errors, 1 warnings, 862 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools: Add isotest tool" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

btio: Add support for ISO sockets
WARNING:LINE_SPACING: Missing a blank line after declarations
#52: FILE: btio/btio.c:781:
+		int error = -errno;
+		ERROR_FAILED(err, "sco_bind", errno);

- total: 0 errors, 1 warnings, 419 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] btio: Add support for ISO sockets" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
lib: Add definitions for ISO socket
3: B6 Body message is missing


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5940953984446061014==--
