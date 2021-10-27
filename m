Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F3FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B564610C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhJ0WUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhJ0WUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968AC061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t184so4111490pfd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VnhR5kNuH0dTcJMt94ZEOssw4aW9JZKLXTbRp6RlD4c=;
        b=j/GFkNfTCA412UCw8CZ/ORYoB4YDpPIHll8vODTFTnhq+eglSC2/7/vD5NAVKvAhJ0
         tuyirLi7wxxsP9TrvalJLHt3MTJXbLG4jq9Nsn9y8NosceVsSaiV1YUcwy16L5QWJh2R
         bRgEhxr2TBWJY3QcBbF2B0Ll/s+2zUtwQarsdiFpzKl8sbNZ8m56OY1T880Wpymdx4/q
         GPgYtTp8fgNN6rs8Ltny83tMU/oFwaX8n8I326Vg4fGVNrpGlEBluLrIygR7Up++KlrK
         VEFlByf/NSidrRwE5qshR42+TedeS6YFFlxxGfY9XJTWaJOsul/YF5Q6Uagr+OJIr+Eu
         RtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnhR5kNuH0dTcJMt94ZEOssw4aW9JZKLXTbRp6RlD4c=;
        b=K0YeM4yJ47rVYkiFMO2eX7H7fFqjTmj1zuJUX2S3VQhA+NIaxgALuGLvSbcJe8of8Z
         h4aS5ytdXIE5d16Z7r1yiy0xQ3ajl0hCF4X1pc7k/f3n6Gjs/Kd9KBxKCKD+aKnavzlG
         i5dOp/b4jIKRD6EhHEFhlICNW/nhu/S3gxQ9GPNJhH4I5873udGIqsyHy9FDgiWC4sEb
         k7HYLGWYQDRyH16YbdKuuUmZFUontoScjuFQitAG9zvSR91Hk1MZiAXZC7Hce6AGF+1O
         0StPHQs22iwjjK7aYEH6OXO5f55QdW8FSYHmNKguf8/MPuAKgLjMW7QC3ORJBLHLxkoz
         vpOw==
X-Gm-Message-State: AOAM532VacJPYbtfewoJsQprrbrbJxEK4Xx9RdTFWGCeZqhl0tbxvfpj
        GHPFYsa4rXB7D0+T4M5fdzlhUa5uOds=
X-Google-Smtp-Source: ABdhPJxzOq+Jd0tuVsHl/MDXxfIr/rFj2QVxtj5YncRe2DGG7NbYrBGCJ7n6/pPxxlSxW1FxILRSOA==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr334751pgc.97.1635373086835;
        Wed, 27 Oct 2021 15:18:06 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 02/23] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1
Date:   Wed, 27 Oct 2021 15:17:41 -0700
Message-Id: <20211027221802.1851851-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of hci_cmd_sync_queue for the following MGMT commands:

Set Device Class
Set Device ID
Add UUID
Remove UUID

tools/mgmt-tester -s "Set Device Class"

Test Summary
------------
Set Device Class - Success 1                         Passed
Set Device Class - Success 2                         Passed
Set Device Class - Invalid parameters 1              Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0599 seconds

tools/mgmt-tester -s "Set Device ID"

Test Summary
------------
Set Device ID - Success 1                            Passed
Set Device ID - Success 2                            Passed
Set Device ID - Disable                              Passed
Set Device ID - Power off and Power on               Passed
Set Device ID - SSP off and Power on                 Passed
Set Device ID - Invalid Parameter                    Passed
Total: 6, Passed: 6 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.107 seconds

tools/mgmt-tester -s "Add UUID"

Test Summary
------------
Add UUID - UUID-16 1                                 Passed
Add UUID - UUID-16 multiple 1                        Passed
Add UUID - UUID-16 partial 1                         Passed
Add UUID - UUID-32 1                                 Passed
Add UUID - UUID-32 multiple 1                        Passed
Add UUID - UUID-32 partial 1                         Passed
Add UUID - UUID-128 1                                Passed
Add UUID - UUID-128 multiple 1                       Passed
Add UUID - UUID-128 partial 1                        Passed
Add UUID - UUID mix                                  Passed
Total: 10, Passed: 10 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.198 seconds

tools/mgmt-tester -s "Remove UUID"

Test Summary
------------
Remove UUID - Success 1                              Passed
Remove UUID - All UUID - Success 2                   Passed
Remove UUID - Power Off - Success 3                  Passed
Remove UUID - Power Off and On - Success 4           Passed
Remove UUID - Not Exist - Invalid Params 1           Passed
Total: 5, Passed: 5 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0908 seconds

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_request.c      |   4 +-
 net/bluetooth/hci_request.h      |   6 +
 net/bluetooth/hci_sync.c         |  72 ++++++++++++
 net/bluetooth/mgmt.c             | 192 +++++++++++++++----------------
 net/bluetooth/mgmt_util.c        |  15 ++-
 net/bluetooth/mgmt_util.h        |   3 +
 7 files changed, 193 insertions(+), 102 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index fcfdeb3cbd7c..fe77ff97bc8e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -40,3 +40,6 @@ void hci_cmd_sync_clear(struct hci_dev *hdev);
 
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+
+int hci_update_eir_sync(struct hci_dev *hdev);
+int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c98340bba5c7..b1b33432c68d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -97,8 +97,8 @@ int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete)
 	return req_run(req, NULL, complete);
 }
 
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
-				  struct sk_buff *skb)
+void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
+			   struct sk_buff *skb)
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 74c5de5970a7..ba75c2da70f4 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -22,6 +22,10 @@
 
 #include <asm/unaligned.h>
 
+#define HCI_REQ_DONE	  0
+#define HCI_REQ_PEND	  1
+#define HCI_REQ_CANCELED  2
+
 #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
 #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
 
@@ -44,6 +48,8 @@ void hci_req_purge(struct hci_request *req);
 bool hci_req_status_pend(struct hci_dev *hdev);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
 int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete);
+void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
+			   struct sk_buff *skb);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 		 const void *param);
 void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b2048287fe90..8546cbcae10c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -11,6 +11,7 @@
 
 #include "hci_request.h"
 #include "smp.h"
+#include "eir.h"
 
 static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 				  struct sk_buff *skb)
@@ -328,3 +329,74 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 	return 0;
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
+
+int hci_update_eir_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_eir cp;
+
+	bt_dev_dbg(hdev, "");
+
+	if (!hdev_is_powered(hdev))
+		return 0;
+
+	if (!lmp_ext_inq_capable(hdev))
+		return 0;
+
+	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
+		return 0;
+
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	eir_create(hdev, cp.data);
+
+	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
+		return 0;
+
+	memcpy(hdev->eir, cp.data, sizeof(cp.data));
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp,
+				     HCI_CMD_TIMEOUT);
+}
+
+static u8 get_service_classes(struct hci_dev *hdev)
+{
+	struct bt_uuid *uuid;
+	u8 val = 0;
+
+	list_for_each_entry(uuid, &hdev->uuids, list)
+		val |= uuid->svc_hint;
+
+	return val;
+}
+
+int hci_update_class_sync(struct hci_dev *hdev)
+{
+	u8 cod[3];
+
+	bt_dev_dbg(hdev, "");
+
+	if (!hdev_is_powered(hdev))
+		return 0;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		return 0;
+
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
+		return 0;
+
+	cod[0] = hdev->minor_class;
+	cod[1] = hdev->major_class;
+	cod[2] = get_service_classes(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
+		cod[1] |= 0x20;
+
+	if (memcmp(cod, hdev->dev_class, 3) == 0)
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_CLASS_OF_DEV,
+				     sizeof(cod), cod, HCI_CMD_TIMEOUT);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 44683443300c..ec6aa7af482f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -276,10 +276,39 @@ static const u8 mgmt_status_table[] = {
 	MGMT_STATUS_CONNECT_FAILED,	/* MAC Connection Failed */
 };
 
-static u8 mgmt_status(u8 hci_status)
+static u8 mgmt_errno_status(int err)
 {
-	if (hci_status < ARRAY_SIZE(mgmt_status_table))
-		return mgmt_status_table[hci_status];
+	switch (err) {
+	case 0:
+		return MGMT_STATUS_SUCCESS;
+	case -EPERM:
+		return MGMT_STATUS_REJECTED;
+	case -EINVAL:
+		return MGMT_STATUS_INVALID_PARAMS;
+	case -EOPNOTSUPP:
+		return MGMT_STATUS_NOT_SUPPORTED;
+	case -EBUSY:
+		return MGMT_STATUS_BUSY;
+	case -ETIMEDOUT:
+		return MGMT_STATUS_AUTH_FAILED;
+	case -ENOMEM:
+		return MGMT_STATUS_NO_RESOURCES;
+	case -EISCONN:
+		return MGMT_STATUS_ALREADY_CONNECTED;
+	case -ENOTCONN:
+		return MGMT_STATUS_DISCONNECTED;
+	}
+
+	return MGMT_STATUS_FAILED;
+}
+
+static u8 mgmt_status(int err)
+{
+	if (err < 0)
+		return mgmt_errno_status(err);
+
+	if (err < ARRAY_SIZE(mgmt_status_table))
+		return mgmt_status_table[err];
 
 	return MGMT_STATUS_FAILED;
 }
@@ -951,25 +980,23 @@ bool mgmt_get_connectable(struct hci_dev *hdev)
 	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
 }
 
+static int service_cache_sync(struct hci_dev *hdev, void *data)
+{
+	hci_update_eir_sync(hdev);
+	hci_update_class_sync(hdev);
+
+	return 0;
+}
+
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    service_cache.work);
-	struct hci_request req;
 
 	if (!hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE))
 		return;
 
-	hci_req_init(&req, hdev);
-
-	hci_dev_lock(hdev);
-
-	__hci_req_update_eir(&req);
-	__hci_req_update_class(&req);
-
-	hci_dev_unlock(hdev);
-
-	hci_req_run(&req, NULL);
+	hci_cmd_sync_queue(hdev, service_cache_sync, NULL, NULL);
 }
 
 static void rpa_expired(struct work_struct *work)
@@ -2075,37 +2102,33 @@ static u8 get_uuid_size(const u8 *uuid)
 	return 16;
 }
 
-static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
+static void mgmt_class_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd;
-
-	hci_dev_lock(hdev);
+	struct mgmt_pending_cmd *cmd = data;
 
-	cmd = pending_find(mgmt_op, hdev);
-	if (!cmd)
-		goto unlock;
+	bt_dev_dbg(hdev, "err %d", err);
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
-			  mgmt_status(status), hdev->dev_class, 3);
+			  mgmt_status(err), hdev->dev_class, 3);
 
-	mgmt_pending_remove(cmd);
-
-unlock:
-	hci_dev_unlock(hdev);
+	mgmt_pending_free(cmd);
 }
 
-static void add_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static int add_uuid_sync(struct hci_dev *hdev, void *data)
 {
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	int err;
 
-	mgmt_class_complete(hdev, MGMT_OP_ADD_UUID, status);
+	err = hci_update_class_sync(hdev);
+	if (err)
+		return err;
+
+	return hci_update_eir_sync(hdev);
 }
 
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	struct bt_uuid *uuid;
 	int err;
 
@@ -2131,28 +2154,17 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-	hci_req_init(&req, hdev);
-
-	__hci_req_update_class(&req);
-	__hci_req_update_eir(&req);
-
-	err = hci_req_run(&req, add_uuid_complete);
-	if (err < 0) {
-		if (err != -ENODATA)
-			goto failed;
-
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
-					hdev->dev_class, 3);
-		goto failed;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_UUID, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_UUID, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	err = 0;
+	err = hci_cmd_sync_queue(hdev, add_uuid_sync, cmd, mgmt_class_complete);
+	if (err < 0) {
+		mgmt_pending_free(cmd);
+		goto failed;
+	}
 
 failed:
 	hci_dev_unlock(hdev);
@@ -2173,11 +2185,15 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
-static void remove_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static int remove_uuid_sync(struct hci_dev *hdev, void *data)
 {
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	int err;
 
-	mgmt_class_complete(hdev, MGMT_OP_REMOVE_UUID, status);
+	err = hci_update_class_sync(hdev);
+	if (err)
+		return err;
+
+	return hci_update_eir_sync(hdev);
 }
 
 static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -2187,7 +2203,6 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_pending_cmd *cmd;
 	struct bt_uuid *match, *tmp;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
-	struct hci_request req;
 	int err, found;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -2231,39 +2246,35 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 update_class:
-	hci_req_init(&req, hdev);
-
-	__hci_req_update_class(&req);
-	__hci_req_update_eir(&req);
-
-	err = hci_req_run(&req, remove_uuid_complete);
-	if (err < 0) {
-		if (err != -ENODATA)
-			goto unlock;
-
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
-					hdev->dev_class, 3);
-		goto unlock;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
-	err = 0;
+	err = hci_cmd_sync_queue(hdev, remove_uuid_sync, cmd,
+				 mgmt_class_complete);
+	if (err < 0)
+		mgmt_pending_free(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
 }
 
-static void set_class_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static int set_class_sync(struct hci_dev *hdev, void *data)
 {
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	int err = 0;
+
+	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE)) {
+		cancel_delayed_work_sync(&hdev->service_cache);
+		err = hci_update_eir_sync(hdev);
+	}
+
+	if (err)
+		return err;
 
-	mgmt_class_complete(hdev, MGMT_OP_SET_DEV_CLASS, status);
+	return hci_update_class_sync(hdev);
 }
 
 static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -2271,7 +2282,6 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_dev_class *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -2303,34 +2313,16 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
-
-	if (hci_dev_test_and_clear_flag(hdev, HCI_SERVICE_CACHE)) {
-		hci_dev_unlock(hdev);
-		cancel_delayed_work_sync(&hdev->service_cache);
-		hci_dev_lock(hdev);
-		__hci_req_update_eir(&req);
-	}
-
-	__hci_req_update_class(&req);
-
-	err = hci_req_run(&req, set_class_complete);
-	if (err < 0) {
-		if (err != -ENODATA)
-			goto unlock;
-
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
-					hdev->dev_class, 3);
-		goto unlock;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
-	err = 0;
+	err = hci_cmd_sync_queue(hdev, set_class_sync, cmd,
+				 mgmt_class_complete);
+	if (err < 0)
+		mgmt_pending_free(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5494,11 +5486,15 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static int set_device_id_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_update_eir_sync(hdev);
+}
+
 static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_device_id *cp = data;
-	struct hci_request req;
 	int err;
 	__u16 source;
 
@@ -5520,9 +5516,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0,
 				NULL, 0);
 
-	hci_req_init(&req, hdev);
-	__hci_req_update_eir(&req);
-	hci_req_run(&req, NULL);
+	hci_cmd_sync_queue(hdev, set_device_id_sync, NULL, NULL);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 0d0a6d77b9e8..83875f2a0604 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -227,7 +227,7 @@ void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 	}
 }
 
-struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  struct hci_dev *hdev,
 					  void *data, u16 len)
 {
@@ -251,6 +251,19 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	cmd->sk = sk;
 	sock_hold(sk);
 
+	return cmd;
+}
+
+struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+					  struct hci_dev *hdev,
+					  void *data, u16 len)
+{
+	struct mgmt_pending_cmd *cmd;
+
+	cmd = mgmt_pending_new(sk, opcode, hdev, data, len);
+	if (!cmd)
+		return NULL;
+
 	list_add(&cmd->list, &hdev->mgmt_pending);
 
 	return cmd;
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 6559f189213c..9dc24ba0d51a 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -49,5 +49,8 @@ void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 					  struct hci_dev *hdev,
 					  void *data, u16 len);
+struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
+					  struct hci_dev *hdev,
+					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
-- 
2.31.1

