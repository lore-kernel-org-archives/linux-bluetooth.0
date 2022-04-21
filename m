Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB20C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442189AbiDUVtE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376329AbiDUVtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:49:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8A40E7A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x80so6199701pfc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yh3fb2fzkSx1njw7T8JPPMe8W37wMbV9nhVuYomW1yQ=;
        b=aN6kXCMxl1ZBG6Vnu7Q4hbhNU7fQcOKMp2Nj9qdaS/6958N+tR0GTMMKP0HyvKRsnC
         c7KLYsCFCvIpst5qKDYDjuYvxlfrxzLs0ciwdUNI62FNxNJwSm1QmAsnvxqb8eXZbIaA
         A/6P/XZiFllLa1aog9dD516iAfgq2RjYyeXzWk1eXhkETIXf4zhir9svLCvYP5i4mLsh
         +nskg4uvGfTZDPt//AQ/FEo0aYmrpw6l3ClBZ/X9rMVHQzmkKuiGZJEz6BiCgAhqOpC3
         aWWJ7VeNZ9IPLmtWFmAYiua4Emf0f/cm7bXjdHEmZaAz2BBZq05KV1O6BnNrEZTGEAqz
         CMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yh3fb2fzkSx1njw7T8JPPMe8W37wMbV9nhVuYomW1yQ=;
        b=ciMoIxP5Bg5LXniVmR8A3aRXu9uAsZTU/hW+tNw0v/r6gdRDc1tsu+RTAbB8MZx7/U
         iPPXg6Vf9rszmpO43KSoZfHtBfKiZGPx5NdkDg+H+Esg9rHMzrFWql/46DrpecW9ltaY
         NuxBuGU8lsVveKj+9FNqDI2P86JzxHPRbaEUOWz8n1oCc9i1hyH4nhMKRZ3DEks+6l35
         lID1spJljdgRi5I2M33CoWWeE7IAPA1h1DjQNFLvntWmYpQYel9V4bTFW5BnZ4Gs7D46
         l9i9r2JOva6KwCnVw0IDXjK32CB2PZ9jejEwhMj0vP0Tf93yJ17OXeVR7z/ZWmf6R3Vp
         81JA==
X-Gm-Message-State: AOAM5334hRGYZbSq6Z2QhpOFNYPns4pCxZGPLpQFj31X72bNI+N1geqZ
        yohHDitVNHEgk8QH4L2ZjHKomvzwZ0I=
X-Google-Smtp-Source: ABdhPJw1Nl1R+hnNys0bMJ3I1myzKB6qeOVuxokfzbLVoDxb2MMO/ezrbNEduFvWQXfrFAXSMzzQ8Q==
X-Received: by 2002:a63:f718:0:b0:398:f14d:4915 with SMTP id x24-20020a63f718000000b00398f14d4915mr1166740pgh.9.1650577568971;
        Thu, 21 Apr 2022 14:46:08 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mp9-20020a17090b190900b001cd4989feb6sm3812484pjb.2.2022.04.21.14.46.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:46:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
Date:   Thu, 21 Apr 2022 14:46:05 -0700
Message-Id: <20220421214607.3326277-1-luiz.dentz@gmail.com>
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
v3: Rebase changes.

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 45 ++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 20 deletions(-)

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
index abaabfae19cc..9feef7dbde3d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3068,11 +3068,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_conn_complete *ev = data;
 	struct hci_conn *conn;
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
-		return;
-	}
-
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
@@ -3124,6 +3119,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
+			ev->status = HCI_ERROR_INVALID_PARAMETERS;
+			goto done;
+		}
 
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
@@ -3164,17 +3165,17 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
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
 
+done:
 	if (ev->status) {
+		conn->state = BT_CLOSED;
+		if (conn->type == ACL_LINK)
+			mgmt_connect_failed(hdev, &conn->dst, conn->type,
+					    conn->dst_type, ev->status);
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_del(conn);
 	} else if (ev->link_type == SCO_LINK) {
@@ -4690,11 +4691,6 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
-		return;
-	}
-
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
@@ -4732,6 +4728,14 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	switch (ev->status) {
 	case 0x00:
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
+			ev->status = HCI_ERROR_INVALID_PARAMETERS;
+			conn->state = BT_CLOSED;
+			break;
+		}
+
 		conn->state  = BT_CONNECTED;
 		conn->type   = ev->link_type;
 
@@ -5527,11 +5531,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct smp_irk *irk;
 	u8 addr_type;
 
-	if (handle > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
-		return;
-	}
-
 	hci_dev_lock(hdev);
 
 	/* All controllers implicitly stop advertising in the event of a
@@ -5603,6 +5602,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
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

