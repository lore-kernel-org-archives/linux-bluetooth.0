Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AE24BBEB
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056778; cv=none; b=Pl4MhrYs5/vLjEqxSbMbZ4UEttzLBZ22uTe6D5dT8fW/Mh31hqfrM5BLgQP0LraKLcFXDyxnTG4e7sxJEApxaOlM9yanQr8BH0iz3AjdFI3Hq8OCadr7FaqgGenr+PGG/75qus3mn2Z9eDnIGK021V4eMWdS7p5igcc+0L8fguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056778; c=relaxed/simple;
	bh=wewATsmlEkuVbqGiAKwmOqJoWQSAHrIT7BHkcV3R8LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTGlSjH+ss8NW+SbPKgwZAvPlQH9N1L5CkVXwxCf07U2tDJgVdyJR+dwLKBlMwo4WiB22wwrAVbeRyRnsGGleXE0NTDmy0Hc20EtoIlpewgUHPR39EwtVn21kqhChRFvdHClvGPHYWoIJrjOhpmaHnzHaKMk1gR8ZFJxD35ylO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0WM/fgF; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0WM/fgF"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so1468080eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786056775; x=1786661575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/R6OauF0TBGHWFTRS5Cxob0v04sM7ILzJGkAw6LhOs=;
        b=k0WM/fgFQSIy5Lfnt/faa6IT3sA91GhCYPpedeqUkenRvflKBcN0GdZm5f1MIz81iJ
         gZu+KSyVHJ8SGNM2WKc10TAfr7o8/1ZrrCNZ1Jn7ReJv3kRAV26PsLG3Xnlp0nUEdrvQ
         rTMR/yVkGSw0YMk9TO4myflWqv5AcFqL2B8fbVQxKzy5Atpn5NzlHPSnIEljOFRXYKG3
         2H/oST/xDOnNEjU6FJukomWt33sGT7bfKIaUdtHqfLK4cQ0b6GWpgdPGjynJ2hVWdpA6
         KckP8sWHeDcQJdFWV5jznyjdFU5vp4aKewkutpDNTB/QumqTVlz+kE/RhTz0jt42yTyH
         CsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786056775; x=1786661575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/R6OauF0TBGHWFTRS5Cxob0v04sM7ILzJGkAw6LhOs=;
        b=aVO7ramhBNytVroidTfqzlewBcJdD+eJmqsdEQCRI9aEIrdKeUvmNdwgDsw9Fn9aUu
         PJyfkiMor81zKqt4LXioOZePKGAQAfkmlmRS9I041xx82sS8UnWn964DH9ZfgZ8cDWTR
         Q6MI72nrAdEqKMTVXyE7NEVeMJBA+8ZuQZkQR+NSeiQVpqL0GwGdu7SK5csQggI9jpOa
         sF3hAL1yo3jGmyAtXt1+OstCNt4UHobfOaMplzv9AKw9sZfAqh8wAnDmJvRwXBb5Pn4e
         0Nh8WUaQzYoZphPLDM/cSEb4o97j62mjNdwr0ZdSvdXeFBX0SA8jsDNi79obYMlCWYBa
         6yOQ==
X-Gm-Message-State: AOJu0YzHyB9nrO84LXdmatRmbqo6Y4y//HxHOXYL2bhInaLG3A5bZ2xu
	/VwoGDoAXn5aO+F66n+Rb4Mnhp+WesKFrJ02xFCMLxsKfnD0dBPuIGs2umAC4rBLwHw2CQ==
X-Gm-Gg: AR+sD13mLn1Iale1a8/e6fBgeeyGE4FvBOuP+XXYODlWzxbPwM1kl0V+c7rxNgaogeN
	+MnJeOPJyWRXSpbKI7FiA3/R6rScwQmvl8+6u6FvT6uNkr3Q0o8uY67bNWtjNn0B4NTc7EnC8y9
	deR7SPYEMg1AwiBHlspSsyuK8jdv+noPxhkVOnQyt1w7YTVc1weDg3zHQB3Bm6c4dxylMtKqMDe
	ZUipyFMwAsYH3NQqqVdNTSI/w1FaXWhDff0MmKqv1bCjEBzE5c0JsWMlsUvuLdHzx9UnoERG//A
	9TzCwBzydcUuusozKPZOS1E+DX2VVHYQilyE3cBCBDsmWgUaTav7MpRCD7iU5IJGIJc0GjFSEvD
	pEKYS8JzqiXpVrb523gSqKQllGSnXw3UZbxOKCTn8xNXqdeqw6geqUXtWD4aRh3RRiDX+pFSmL8
	1jKv9t19h8um2o8ILpeY7CLJtze09O1PQ7WGihQoTZITkV0EuSN7GqJuA=
X-Received: by 2002:a4a:ee19:0:b0:6ae:5250:dd1c with SMTP id 006d021491bc7-6ae96fa79f3mr9613970eaf.29.1786056775343;
        Thu, 06 Aug 2026 15:52:55 -0700 (PDT)
Received: from en1.. ([204.144.167.9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1ece1fbsm739914fac.17.2026.08.06.15.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 15:52:54 -0700 (PDT)
From: Amir Abudubai <amirabudubai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Amir Abudubai <amirabudubai@gmail.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH v3] Bluetooth: l2cap: Create temporary hcon for inbound LE connections
Date: Thu,  6 Aug 2026 17:51:35 -0500
Message-ID: <20260806225237.51411-1-amirabudubai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKF8LQ-TzTnNkChHBiwLpRbbmi6pZQJ2yF1dNJWTKNqjw@mail.gmail.com>
References: <CAEzAHR-7LQak12o_Xt7QrvLHRw3GSLDgco6o7Fru-wVXyBW7mQ@mail.gmail.com> <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com> <CABBYNZKF8LQ-TzTnNkChHBiwLpRbbmi6pZQJ2yF1dNJWTKNqjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some adapters, ACL data for an inbound LE connection can arrive
before the Connection Complete event registers its handle with the host
stack, causing the packet to be dropped as an unrecognized handle.

To resolve this, create a temporary hcon for ACL traffic arriving with an
unrecognized handle while advertising. If a matching LE peripheral
connection event arrives within the grace period, the temporary connection
is adopted. Otherwise, a timeout armed at creation removes the temporary
connection and emits an unknown handle error.

This issue was observed and the fix verified on:
  - 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
  - 7392:c611 Edimax Technology Co., Ltd Edimax Bluetooth Adapter

Assisted-by: OpenCode:openai/gpt-5.6-sol
Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
---
I limited it to only inbound LE connections. I think it can
happen to any connection creation event in theory, so I started
there. However when I tried testing it, no other connections
came close. The nearest was classic inbound, but it was still
20ms away. If it does ever need to be expanded to other types,
just remove the advertising check and let other creation events
check for the temp hcon and copy over its pending rx.

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  9 ++++++
 net/bluetooth/hci_event.c        | 49 +++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c       | 20 +++++++++++--
 5 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda..27757588c115 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -486,6 +486,7 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
+#define HCI_EARLY_ACL_TIMEOUT	msecs_to_jiffies(4)
 #define HCI_ISO_TX_TIMEOUT	usecs_to_jiffies(0x7fffff) /* 8388607 usecs */
 
 /* HCI data types */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e07418a5adce..834bf0586ab4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1009,6 +1009,7 @@ enum {
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
 	HCI_CONN_CREATE_PA_SYNC,
+	HCI_CONN_EARLY_ACL,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
 };
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 19b7629b1cc1..b7d4a8db4eb4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -638,6 +638,15 @@ static void hci_conn_timeout(struct work_struct *work)
 
 	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
 
+	if (test_bit(HCI_CONN_EARLY_ACL, &conn->flags)) {
+		bt_dev_err(conn->hdev,
+			   "ACL packet for unknown connection handle %d",
+			   conn->handle);
+		conn->state = BT_CLOSED;
+		hci_abort_conn(conn, HCI_ERROR_UNKNOWN_CONN_ID);
+		return;
+	}
+
 	WARN_ON(refcnt < 0);
 
 	/* FIXME: It was observed that in pairing failed scenario, refcnt
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 371ca8236bc5..e277df667ff1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5695,6 +5695,44 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
+static struct hci_conn *hci_early_acl_lookup(struct hci_dev *hdev, u16 handle)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn || !test_bit(HCI_CONN_EARLY_ACL, &conn->flags))
+		return NULL;
+
+	return conn;
+}
+
+static void hci_early_acl_discard(struct hci_conn *conn)
+{
+	cancel_delayed_work(&conn->disc_work);
+	if (conn->state == BT_OPEN)
+		bt_dev_err(conn->hdev,
+			   "ACL packet for unknown connection handle %d",
+			   conn->handle);
+
+	clear_bit(HCI_CONN_EARLY_ACL, &conn->flags);
+	hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
+	hci_conn_del(conn);
+}
+
+static struct hci_conn *hci_early_acl_adopt(struct hci_conn *conn, u8 role,
+					    bdaddr_t *bdaddr, u8 bdaddr_type)
+{
+	if (conn->state != BT_OPEN || role != HCI_ROLE_SLAVE)
+		return NULL;
+
+	cancel_delayed_work(&conn->disc_work);
+	clear_bit(HCI_CONN_EARLY_ACL, &conn->flags);
+	bacpy(&conn->dst, bdaddr);
+	conn->dst_type = bdaddr_type;
+
+	return conn;
+}
+
 static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 				u8 bdaddr_type, bdaddr_t *local_rpa)
 {
@@ -5755,6 +5793,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 				 u16 supervision_timeout)
 {
 	struct hci_conn_params *params;
+	struct hci_conn *early = NULL;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
 	u8 addr_type;
@@ -5762,6 +5801,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	hci_dev_lock(hdev);
 	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
+	if (!status)
+		early = hci_early_acl_lookup(hdev, handle);
 
 	/* All controllers implicitly stop advertising in the event of a
 	 * connection, so ensure that the state bit is cleared.
@@ -5778,6 +5819,9 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
 	 */
 	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (early && (!conn || conn == early))
+		conn = hci_early_acl_adopt(early, role, bdaddr, bdaddr_type);
+
 	if (!conn ||
 	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
@@ -5823,11 +5867,14 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 * As the connection handle is set here for the first time, it indicates
 	 * whether the connection is already set up.
 	 */
-	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
+	if (conn != early && !HCI_CONN_HANDLE_UNSET(conn->handle)) {
 		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for existing connection");
 		goto unlock;
 	}
 
+	if (early && conn != early)
+		hci_early_acl_discard(early);
+
 	le_conn_update_addr(conn, bdaddr, bdaddr_type, local_rpa);
 
 	/* Lookup the identity address from the stored connection
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee459dd411f5..600cc0bf31b6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7816,9 +7816,23 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 
 	hcon = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!hcon) {
-		hci_dev_unlock(hdev);
-		kfree_skb(skb);
-		return -ENOENT;
+		if (!hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+			hci_dev_unlock(hdev);
+			kfree_skb(skb);
+			return -ENOENT;
+		}
+
+		hcon = hci_conn_add(hdev, LE_LINK, BDADDR_ANY, 0,
+				    HCI_ROLE_SLAVE, handle);
+		if (IS_ERR(hcon)) {
+			hci_dev_unlock(hdev);
+			kfree_skb(skb);
+			return PTR_ERR(hcon);
+		}
+
+		set_bit(HCI_CONN_EARLY_ACL, &hcon->flags);
+		queue_delayed_work(hdev->workqueue, &hcon->disc_work,
+				   HCI_EARLY_ACL_TIMEOUT);
 	}
 
 	lockdep_assert_held(&hcon->hdev->lock);
-- 
2.43.0

