Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B383C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31382610FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhHMMUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhHMMUY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125FAC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q11-20020a05620a05abb02903ca17a8eef8so7025937qkq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HLdivF6sZUXLkJWSP1eMNrG2XucAP7mPn8a9G064n5g=;
        b=bEw600A7hKqgQ5uWL+By1hpC8PYCXVm8Aj0uS5VL9Y3ZlAcR3/eCVBzKACllHYkjPl
         GMO4ksP9at9XPRR2eWJGZao4vjJzaxeTIzp/iOPTBuorCrFlXer4lvAzTW5sdA+OvrMo
         YFpvbXH8mOVTTG8WoHNBLT7QT9BulAlYHcIFKxhaM0JCX7V6A9jhbt7y7uuLuGBRT2LR
         awjIYUp2DdPhCUmSML2aN39skPW3oCiHYfIyXOwuya/+dKQBBP4l3Y5iB7YZZcxduZmP
         aX9dB3iy+dFeUNtaaGEdV8Dw7eSYRLyo75RL3J94THQfPApC1C6SQztNhxnVvCmKG16T
         jwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HLdivF6sZUXLkJWSP1eMNrG2XucAP7mPn8a9G064n5g=;
        b=fa+kZKYfmaREBsPWN0ExquRbL+PoYKeFlEiC3Z1yVaraf3z60f3gB0bHEE8MoNq1XW
         7d0asGou2BOU0ciMgQk1WVEUYTa6UIKgDIIol+W4h/xaIiT/rybDLK1pzZCszVmP0qUa
         4RW5XNEfntQGt2s0lTN0IdIV5BXNuhAu5QG2iqfcj0aY9Z40i9B33GSE00iURlyoXPPt
         iqHt0zNJo4llBPisatI1KK/ZBdZxsjUJfxvoFbDR0GvYDbJltyBlBJfYLRrDCBFHVjtd
         28CL1nn6xSbzSi4il00oVP3TZxmDocFLlhWewB5ZpSHkB5iDHghoxTKo4Zl2eL2C2j/f
         71FQ==
X-Gm-Message-State: AOAM530pYa1EOuFZLv6x7FT4hVOD5y26YGgY3ghXuYicbp3If6ujPDa2
        hvCm9oE0Y4b4kmodKKus+YkngJWsWd7hZG1sk1NP/YNBgMyDKmYSzy0nj+KuRAKIeLOC2Q8zwvr
        UZ6DGuUkrxZFyaIpGkdSjm5QJUqfS1+xJyDOjMjFRanNuAd6tdsqEKsCmnuGwiV7v5mH767ysGQ
        /d
X-Google-Smtp-Source: ABdhPJw5Msi1Z6rvTbge+JbMfeYYaB/ej6nt2mVAdgbOGdycoMu+t/+natjeKFs04wzIi1twzmMSQ5HnlpLM
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:438e:: with SMTP id
 s14mr2293550qvr.26.1628857197254; Fri, 13 Aug 2021 05:19:57 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:51 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.6.I65c31fd642c75050d65646aeefe6d96904f93f66@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 06/62] lib: Inclusive language for filtering devices
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 lib/hci.c          | 36 ++++++++++++++++++------------------
 lib/hci.h          | 20 ++++++++++----------
 lib/hci_lib.h      |  8 ++++----
 tools/hcitool.c    |  8 ++++----
 tools/parser/hci.c |  6 +++---
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 3611d3d360..d2753a934d 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -565,11 +565,11 @@ static hci_map commands_map[] = {
 	{ "LE Set Scan Enable",				211 },
 	{ "LE Create Connection",			212 },
 	{ "LE Create Connection Cancel",		213 },
-	{ "LE Read White List Size",			214 },
-	{ "LE Clear White List",			215 },
+	{ "LE Read Accept List Size",			214 },
+	{ "LE Clear Accept List",			215 },
 
-	{ "LE Add Device To White List",		216 },
-	{ "LE Remove Device From White List",		217 },
+	{ "LE Add Device To Accept List",		216 },
+	{ "LE Remove Device From Accept List",		217 },
 	{ "LE Connection Update",			218 },
 	{ "LE Set Host Channel Classification",		219 },
 	{ "LE Read Channel Map",			220 },
@@ -1322,10 +1322,10 @@ int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to)
 	return 0;
 }
 
-int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
+int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 {
 	struct hci_request rq;
-	le_add_device_to_white_list_cp cp;
+	le_add_device_to_accept_list_cp cp;
 	uint8_t status;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1334,9 +1334,9 @@ int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_ADD_DEVICE_TO_WHITE_LIST;
+	rq.ocf = OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST;
 	rq.cparam = &cp;
-	rq.clen = LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE;
+	rq.clen = LE_ADD_DEVICE_TO_ACCEPT_LIST_CP_SIZE;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
@@ -1351,10 +1351,10 @@ int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
-int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
+int hci_le_rm_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 {
 	struct hci_request rq;
-	le_remove_device_from_white_list_cp cp;
+	le_remove_device_from_accept_list_cp cp;
 	uint8_t status;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1363,9 +1363,9 @@ int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST;
+	rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST;
 	rq.cparam = &cp;
-	rq.clen = LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE;
+	rq.clen = LE_REMOVE_DEVICE_FROM_ACCEPT_LIST_CP_SIZE;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
@@ -1380,18 +1380,18 @@ int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
-int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
+int hci_le_read_accept_list_size(int dd, uint8_t *size, int to)
 {
 	struct hci_request rq;
-	le_read_white_list_size_rp rp;
+	le_read_accept_list_size_rp rp;
 
 	memset(&rp, 0, sizeof(rp));
 	memset(&rq, 0, sizeof(rq));
 
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_READ_WHITE_LIST_SIZE;
+	rq.ocf = OCF_LE_READ_ACCEPT_LIST_SIZE;
 	rq.rparam = &rp;
-	rq.rlen = LE_READ_WHITE_LIST_SIZE_RP_SIZE;
+	rq.rlen = LE_READ_ACCEPT_LIST_SIZE_RP_SIZE;
 
 	if (hci_send_req(dd, &rq, to) < 0)
 		return -1;
@@ -1407,14 +1407,14 @@ int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
 	return 0;
 }
 
-int hci_le_clear_white_list(int dd, int to)
+int hci_le_clear_accept_list(int dd, int to)
 {
 	struct hci_request rq;
 	uint8_t status;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_CLEAR_WHITE_LIST;
+	rq.ocf = OCF_LE_CLEAR_ACCEPT_LIST;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
diff --git a/lib/hci.h b/lib/hci.h
index 4c039830d5..e31685b644 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1561,28 +1561,28 @@ typedef struct {
 
 #define OCF_LE_CREATE_CONN_CANCEL		0x000E
 
-#define OCF_LE_READ_WHITE_LIST_SIZE		0x000F
+#define OCF_LE_READ_ACCEPT_LIST_SIZE		0x000F
 typedef struct {
 	uint8_t		status;
 	uint8_t		size;
-} __attribute__ ((packed)) le_read_white_list_size_rp;
-#define LE_READ_WHITE_LIST_SIZE_RP_SIZE 2
+} __attribute__ ((packed)) le_read_accept_list_size_rp;
+#define LE_READ_ACCEPT_LIST_SIZE_RP_SIZE 2
 
-#define OCF_LE_CLEAR_WHITE_LIST			0x0010
+#define OCF_LE_CLEAR_ACCEPT_LIST		0x0010
 
-#define OCF_LE_ADD_DEVICE_TO_WHITE_LIST		0x0011
+#define OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST	0x0011
 typedef struct {
 	uint8_t		bdaddr_type;
 	bdaddr_t	bdaddr;
-} __attribute__ ((packed)) le_add_device_to_white_list_cp;
-#define LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE 7
+} __attribute__ ((packed)) le_add_device_to_accept_list_cp;
+#define LE_ADD_DEVICE_TO_ACCEPT_LIST_CP_SIZE 7
 
-#define OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST	0x0012
+#define OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST	0x0012
 typedef struct {
 	uint8_t		bdaddr_type;
 	bdaddr_t	bdaddr;
-} __attribute__ ((packed)) le_remove_device_from_white_list_cp;
-#define LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE 7
+} __attribute__ ((packed)) le_remove_device_from_accept_list_cp;
+#define LE_REMOVE_DEVICE_FROM_ACCEPT_LIST_CP_SIZE 7
 
 #define OCF_LE_CONN_UPDATE			0x0013
 typedef struct {
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 6b1a548b55..a0dfed615f 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -117,10 +117,10 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t max_interval, uint16_t latency,
 			uint16_t supervision_timeout, int to);
-int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
-int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
-int hci_le_read_white_list_size(int dd, uint8_t *size, int to);
-int hci_le_clear_white_list(int dd, int to);
+int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_rm_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_read_accept_list_size(int dd, uint8_t *size, int to);
+int hci_le_clear_accept_list(int dd, int to);
 int hci_le_add_resolving_list(int dd, const bdaddr_t *bdaddr, uint8_t type,
 				uint8_t *peer_irk, uint8_t *local_irk, int to);
 int hci_le_rm_resolving_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index c6a9093733..f7fca5216c 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2793,7 +2793,7 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
-	err = hci_le_add_white_list(dd, &bdaddr, bdaddr_type, 1000);
+	err = hci_le_add_accept_list(dd, &bdaddr, bdaddr_type, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2839,7 +2839,7 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
-	err = hci_le_rm_white_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
+	err = hci_le_rm_accept_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2883,7 +2883,7 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_read_white_list_size(dd, &size, 1000);
+	err = hci_le_read_accept_list_size(dd, &size, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2928,7 +2928,7 @@ static void cmd_lewlclr(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_clear_white_list(dd, 1000);
+	err = hci_le_clear_accept_list(dd, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index a1253acdf7..02ebcfc442 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -2969,9 +2969,9 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_LE_SET_SCAN_PARAMETERS:
 		case OCF_LE_SET_SCAN_ENABLE:
 		case OCF_LE_CREATE_CONN:
-		case OCF_LE_CLEAR_WHITE_LIST:
-		case OCF_LE_ADD_DEVICE_TO_WHITE_LIST:
-		case OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST:
+		case OCF_LE_CLEAR_ACCEPT_LIST:
+		case OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST:
+		case OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST:
 		case OCF_LE_SET_HOST_CHANNEL_CLASSIFICATION:
 		case OCF_LE_RECEIVER_TEST:
 		case OCF_LE_TRANSMITTER_TEST:
-- 
2.33.0.rc1.237.g0d66db33f3-goog

