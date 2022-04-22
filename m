Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 22:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiDVWQw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiDVWQm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 18:16:42 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A1245457
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 14:07:53 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id s68so4405100vke.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmhGU+keVpShl3ae+AIT3nEQEHAIbES4FNkXMrCOEaY=;
        b=NUXHQyaTPDuOU+X6E7olgGUS5VNlan5034iVSsjdnVQYqKyACL7Q+objJHqnGdjzfL
         XPdYN3eZhmGg9f57hw/RW7RvPS49IyAbDpw3hyxwVTauB5S0fsrMxKsdaAgVtcfJMAeS
         1LwD5n5jDA14FQygOmJWlKYQ67aXkrSmaC+VR4pcWUn3s8TZAmrfmn8Ja/Ri90wAXTrJ
         2YceBH2UHgiynBSx1Jle8fVb40wHQvMaLW88pYE1SNxX0MxWc/A1qclvxOWpne3nqfE3
         DCeR52TrQ6X6YrW7P4pssF7F3EmcvOZa+4Hz0v5QzbbPF2A6QEeZz6Kmf6GVpVliohd0
         wJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmhGU+keVpShl3ae+AIT3nEQEHAIbES4FNkXMrCOEaY=;
        b=jJLeL1rw3zPp7dvhFHKQn45iF+MYBAhhf/7weYJ1vhqu+A7CEUn+LkK5pHBoqQbi9Q
         9qMOKJxXUaDI9aJUd44m8AeoqVP+X/wjvrt4yjaYeZX7paPdFEvAj16BUmIxdQb5ecEY
         FnO/rNtO0f9loOopy8K2G1GghhmIZWH6yXsoH5+REOlJ2dNGG9eftVRN3+m5szj8NM12
         d4mnBgEwE5sQ2RilM8tC/h6fr1Hp/LQBCL24GizuFOIWT60ifuGHB5ErVMbR8u2cnfYY
         JIkR2aWX38KJg/KOnvINf7qi70OXDSYeeyCiHTsJlN6JAo0iA2XJwMhx9FRhMlnpUwTu
         d9sQ==
X-Gm-Message-State: AOAM532o4KgIEiRUqFTD1FLhBN6wS5AqOI3xCxv6ldP48WkeX0Rl4n2+
        GM7tfDKsYZ0pi6mLqGWg9F4h6dcyu9A=
X-Google-Smtp-Source: ABdhPJyp59ur4fgX/0I6CUMOeRwacRmR0tIqAVTUDg55HoKx79LSCc32KcpmBcHkKA46+blQZGFsQw==
X-Received: by 2002:a17:903:1212:b0:156:3ddc:84bd with SMTP id l18-20020a170903121200b001563ddc84bdmr6133979plh.70.1650657499608;
        Fri, 22 Apr 2022 12:58:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a2c4600b001cb78f1e301sm7152116pjm.1.2022.04.22.12.58.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:58:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
Date:   Fri, 22 Apr 2022 12:58:16 -0700
Message-Id: <20220422195818.3640058-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit d5ebaa7c5f6f6 introduces checks for handle range
(e.g HCI_CONN_HANDLE_MAX) but controllers like Intel AX200 don't seem
to respect the valid range int case of error status:

> HCI Event: Connect Complete (0x03) plen 11
        Status: Page Timeout (0x04)
        Handle: 65535
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
[1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
invalid handle

Because of it is impossible to cleanup the connections properly since
the stack would attempt to cancel the connection which is no longer in
progress causing the following trace:

< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
= bluetoothd: src/profile.c:record_cb() Unable to get Hands-Free Voice
	gateway SDP record: Connection timed out
> HCI Event: Command Complete (0x0e) plen 10
      Create Connection Cancel (0x01|0x0008) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)

Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Check if handle is valid just before assigning it to hci_conn object and
in case it is invalid reset the status to HCI_ERROR_INVALID_PARAMETERS(0x12)
so it can be passed to the likes of hci_connect_cfm and then is translated to
EINVAL by bt_to_errno.
v3: Don't overwrite ev->status

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 65 ++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8bb81ea4d286..62a9bb022aed 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -587,6 +587,7 @@ enum {
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
 #define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
+#define HCI_ERROR_INVALID_PARAMETERS	0x12
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
 #define HCI_ERROR_REMOTE_LOW_RESOURCES	0x14
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..3a9071b987f4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3067,13 +3067,9 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_ev_conn_complete *ev = data;
 	struct hci_conn *conn;
+	u8 status = ev->status;
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
-		return;
-	}
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	hci_dev_lock(hdev);
 
@@ -3122,8 +3118,14 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (!ev->status) {
+	if (!status) {
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
+			status = HCI_ERROR_INVALID_PARAMETERS;
+			goto done;
+		}
 
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
@@ -3164,18 +3166,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
 				     &cp);
 		}
-	} else {
-		conn->state = BT_CLOSED;
-		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev, &conn->dst, conn->type,
-					    conn->dst_type, ev->status);
 	}
 
 	if (conn->type == ACL_LINK)
 		hci_sco_setup(conn, ev->status);
 
-	if (ev->status) {
-		hci_connect_cfm(conn, ev->status);
+done:
+	if (status) {
+		conn->state = BT_CLOSED;
+		if (conn->type == ACL_LINK)
+			mgmt_connect_failed(hdev, &conn->dst, conn->type,
+					    conn->dst_type, status);
+		hci_connect_cfm(conn, status);
 		hci_conn_del(conn);
 	} else if (ev->link_type == SCO_LINK) {
 		switch (conn->setting & SCO_AIRMODE_MASK) {
@@ -3185,7 +3187,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			break;
 		}
 
-		hci_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, status);
 	}
 
 unlock:
@@ -4676,6 +4678,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_ev_sync_conn_complete *ev = data;
 	struct hci_conn *conn;
+	u8 status = ev->status;
 
 	switch (ev->link_type) {
 	case SCO_LINK:
@@ -4690,12 +4693,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
-		return;
-	}
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	hci_dev_lock(hdev);
 
@@ -4729,9 +4727,17 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	switch (ev->status) {
+	switch (status) {
 	case 0x00:
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
+			status = HCI_ERROR_INVALID_PARAMETERS;
+			conn->state = BT_CLOSED;
+			break;
+		}
+
 		conn->state  = BT_CONNECTED;
 		conn->type   = ev->link_type;
 
@@ -4775,8 +4781,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		}
 	}
 
-	hci_connect_cfm(conn, ev->status);
-	if (ev->status)
+	hci_connect_cfm(conn, status);
+	if (status)
 		hci_conn_del(conn);
 
 unlock:
@@ -5527,11 +5533,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct smp_irk *irk;
 	u8 addr_type;
 
-	if (handle > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
-		return;
-	}
-
 	hci_dev_lock(hdev);
 
 	/* All controllers implicitly stop advertising in the event of a
@@ -5603,6 +5604,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
 
+	if (handle > HCI_CONN_HANDLE_MAX) {
+		bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x", handle,
+			   HCI_CONN_HANDLE_MAX);
+		status = HCI_ERROR_INVALID_PARAMETERS;
+	}
+
 	if (status) {
 		hci_le_conn_failed(conn, status);
 		goto unlock;
-- 
2.35.1

