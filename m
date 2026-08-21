Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EA32AAA0
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330728; cv=none; b=V5O7tUMUDpNj2gKzhTaiPqhTdgJSUnC/cckZfl2QslhD1BhcqKBSmUSqWtGKdbDCqA5AnPKtQOTxZg5t9gW3WTUw/5RjrFGypn+Cx78BmkfFP5vSJkO9sl2JYNdCQPX71wsjlLNjfpFoCh5/7UxLMDJbqZajL1xs9MuhS9it/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330728; c=relaxed/simple;
	bh=3yiGSSxr75jqPKJWM5i9rfPilVZvtfY13Sb7WTGgs4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUzMTK8gTfM0mdH4dMEeifUYd/1XUo5p1d6+uROw0+qiTC/gYLbSFYbAoxoWWIngp5ce6qdmjXQXDOx8lSQuokp02L+grtEV92oMsh2jXLe4BUfD4xWqcRWkFjRb4ODwGo38VTDK+74vTOS8lttkMUun/8336Pr/fhdV7kpJ5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5tvSpYJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5tvSpYJ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cb2513ec378so135840a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787330723; x=1787935523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qcL2lFZRj1XJzqg650Z2KW9cdHU6o9SbSQDDe8z5Hg=;
        b=W5tvSpYJSLXqpZZrAf9AoG0eWzgL0cWwlCKqpkNqDG06FHs45jCVbJ5ow7lJz0Zbyo
         3YoQiW7+pB5JW6Zb9w/sxr12OkHc70MMjhJx8v9dgFi9asNu31TzhibaOGxN/metcAl/
         wiQWe289LfgkhgnR+P9p/3BEGehDw61zNj3pjnqWx2TdglK5AJtBu0hOQIP+8Krgx7t/
         aBxKJVgBQbm8wzOXEGovCmBorwjk4jC85FIfoNfIIV0bRuwep90goHDx2qM2THbMvAdv
         DTUq04HinWHkczrBOljc0DWdX4WhbDigmYHlFkrww8GKUAXZEFH5DRCrb4SL8++F8wUE
         pHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787330723; x=1787935523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qcL2lFZRj1XJzqg650Z2KW9cdHU6o9SbSQDDe8z5Hg=;
        b=C9Q3Dh/N4JKX45g7awUy5cvTDZWRq8AApRaOAn7Bg4ZFniEibJJgMo0wN5XTxOwQca
         qTS0yiIHIa2stdPTp34rK1rHYrd7xnVBqK3XiKJnT97hJwlLC6mXdTrDxQKOpqRfo/fD
         qqehrIQ71K9FzH7sB5C4iWqwgo2BxiGELITFMsxB+Tyy9Hn1MrCjnuHrAa4Ghh8TEIo5
         qmsHbfeD8gBA7hrkhmp+OAsrjrfPvOg63czbuHScGqNSpKkGuktCyEtqJScQuKXCbE7n
         8CTvA1sUbB8j83HbKta3MQLJhUrsFmyvt5QaFWl43Yo2MxlYxmTvP2j9vs7t64elOUJo
         h+Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpotCJ4OMSPQzsxQr2pAGhl4Hyqe/vmEqH7JvwP1AHNiFRXzWrqi99jJ3a1yy55zGEfifI7qJM4AHiiM9s/szg=@vger.kernel.org
X-Gm-Message-State: AFuF++l73KaBPGWqQ1IlKEE7KWq5myRfoHbnrcN8EefreP3/e/dlIVzX
	bWKo/ITb4nlG+A+PMDtUXwbZ/tYCfwpPsA3Ft/dzG9xKIruYnKsnZj20
X-Gm-Gg: AR+sD10pSvRih5r4SNt4Q+QVZ8ArG34DJ6hyjY3mW/mHGDcnNOW5zqnWuLev3/sUmL2
	wx4bjGsGdKBB3XVivb6blzmua8zfhCjeFi2gpsnTa3Bvx2zX8F/OCayOU9iNV2rxd5imbWQJAae
	hIQmBYW0Hw4r+/AaRCCyZ3XT1e7iu2Ft4ren1sYpFIpPLmKtsYYoYRPiBiaeU7P8Fd3k6OT6gZh
	hlokHGkm20jtOnklWduz2kJbwhqIv+lSkRtsBsW1kL3kPKbEi69SoH73StMprjE/tRz/qduDtc8
	Yzc4im+zAlRT4Vu4s0Z6U2YuKih0h9adVAVcoc7W2FjrcdkkPo7FKktguASwpeOW+j6DgpvbANP
	9NrVMMkXAym4G2dVsrPS5T7wP4a61hwKck1VTs5MalGe3BXpNf8bm/KGTzbUScXgkfbNDrdxATs
	oAotN+iotDN2CsCY3iGma2A/wluWEHKtNQiThDWP5xj0SzgAwKq9E+9StcXnVDicgQvyDE9Q6y2
	M3nPM5+szsZ5FDA4Cu4Iga7kgu7oK1GF5Ii1JvGGAnaTg==
X-Received: by 2002:a17:903:4685:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d64b0b66e5mr70736185ad.4.1787330723221;
        Fri, 21 Aug 2026 09:45:23 -0700 (PDT)
Received: from localhost.localdomain ([14.216.104.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a4490sm21203635ad.60.2026.08.21.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:45:22 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_sync: wait for directed advertising completion
Date: Sat, 22 Aug 2026 00:45:12 +0800
Message-ID: <20260821164512.2842464-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

le_conn_timeout is embedded in struct hci_conn, but queuing the work does
not hold a reference to the connection.  hci_conn_del() uses
cancel_delayed_work() because synchronous cancellation would deadlock when
le_conn_timeout() itself calls hci_conn_del() while holding hdev->lock.

This leaves the following interleaving possible:

  CPU 0                               CPU 1
  le_conn_timeout()
                                      hci_conn_del()
                                        cancel_delayed_work() = false
                                        hci_conn_cleanup()
                                          put_device()
                                            kfree(conn)
  hci_conn_failed(conn, ...)

The callback then dereferences the released connection.  KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
  Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
  Workqueue: hci0 le_conn_timeout
  Call Trace:
   hci_conn_failed+0x232/0x250
   le_conn_timeout+0x23e/0x2c0
   process_one_work+0x61b/0xf50
   worker_thread+0x45b/0xd10

Remove le_conn_timeout instead of adding another connection reference.
Have the legacy and extended directed-advertising enable commands wait for
the appropriate LE Connection Complete event in hci_le_create_conn_sync().
The command-sync entry already holds a connection reference until its
completion callback returns.

Command Status already keeps a command-sync request pending when the
command succeeds and a later event was requested.  Do the same for
Command Complete so controllers that complete LE Set Advertising Enable
with Command Complete do not bypass the requested LE Connection Complete
wait.

Mark directed advertising as an in-flight connection attempt so teardown
can cancel the wait.  Disable advertising synchronously when that wait
fails, and preserve HCI_ERROR_ADVERTISING_TIMEOUT for a software timeout.
Clear the instance-0 extended advertising state when advertising is stopped
or a connection completes so resuming paused advertising does not restart
the directed advertising instance.

There is then no delayed callback that can race with connection deletion.

Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Keep command-sync requests pending on successful Command Complete when
  the caller requested a later event, matching the existing Command Status
  behavior and fixing the first Sashiko/Luiz report.
- Clear HCI_LE_ADV_0 when all extended advertising instances are disabled
  and when LE connection complete implicitly stops advertising, fixing the
  second Sashiko report about resuming stale directed advertising.

Changes in v2:
- Remove le_conn_timeout instead of adding references around delayed work.
- Wait for LE Connection Complete from both directed-advertising enable paths.
- Make the wait cancellable and disable advertising after a failed wait.

Link: https://lore.kernel.org/linux-bluetooth/20260801145430.3560911-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-nicoyip.dev@gmail.com/ [v1]
Link: https://sashiko.dev/#/patchset/20260801145430.3560911-1-nicoyip.dev%40gmail.com

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 45 --------------------------------
 net/bluetooth/hci_event.c        | 44 ++++++++++---------------------
 net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++---------
 4 files changed, 44 insertions(+), 88 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3df59849dcbe..937c9ba1e6b7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,7 +761,6 @@ struct hci_conn {
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
-	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4ad6..74bf0686f428 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -687,48 +687,6 @@ static void hci_conn_auto_accept(struct work_struct *work)
 		     &conn->dst);
 }
 
-static void le_disable_advertising(struct hci_dev *hdev)
-{
-	if (ext_adv_capable(hdev)) {
-		struct hci_cp_le_set_ext_adv_enable cp;
-
-		cp.enable = 0x00;
-		cp.num_of_sets = 0x00;
-
-		hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp),
-			     &cp);
-	} else {
-		u8 enable = 0x00;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			     &enable);
-	}
-}
-
-static void le_conn_timeout(struct work_struct *work)
-{
-	struct hci_conn *conn = container_of(work, struct hci_conn,
-					     le_conn_timeout.work);
-	struct hci_dev *hdev = conn->hdev;
-
-	BT_DBG("");
-
-	/* We could end up here due to having done directed advertising,
-	 * so clean up the state if necessary. This should however only
-	 * happen with broken hardware or if low duty cycle was used
-	 * (which doesn't have a timeout of its own).
-	 */
-	if (conn->role == HCI_ROLE_SLAVE) {
-		/* Disable LE Advertising */
-		le_disable_advertising(hdev);
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
-}
-
 struct iso_list_data {
 	union {
 		u8  cig;
@@ -1121,7 +1079,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
-	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
 	spin_lock_init(&conn->proto_lock);
 
@@ -1269,8 +1226,6 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
-
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
 			    hdev->le_cnt + conn->sent > hdev->le_pkts)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9630..5b16d1d2e934 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1557,22 +1557,10 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	/* If we're doing connection initiation as peripheral. Set a
-	 * timeout in case something goes wrong.
-	 */
-	if (*sent) {
-		struct hci_conn *conn;
-
+	if (*sent)
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
-
-		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
-	} else {
+	else
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
-	}
 
 	hci_dev_unlock(hdev);
 
@@ -1604,8 +1592,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		adv = hci_find_adv_instance(hdev, set->handle);
 
 	if (cp->enable) {
-		struct hci_conn *conn;
-
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		if (adv)
@@ -1613,11 +1599,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		else if (!set->handle)
 			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
 
-		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
 	} else {
 		if (cp->num_of_sets) {
 			if (adv)
@@ -1638,6 +1619,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list)
 				adv->enabled = false;
+			hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 		}
 
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
@@ -4294,13 +4276,16 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
-	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
-			     req_complete_skb);
+	if (*status || !hdev->req_skb || !hci_skb_event(hdev->req_skb)) {
+		hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
+				     req_complete_skb);
 
-	if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
-		bt_dev_err(hdev,
-			   "unexpected event for opcode 0x%4.4x", *opcode);
-		return;
+		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
+			bt_dev_err(hdev,
+				   "unexpected event for opcode 0x%4.4x",
+				   *opcode);
+			return;
+		}
 	}
 
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
@@ -5721,9 +5706,10 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
 
 	/* All controllers implicitly stop advertising in the event of a
-	 * connection, so ensure that the state bit is cleared.
+	 * connection, so ensure that the state bits are cleared.
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+	hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 
 	/* Check for existing connection:
 	 *
@@ -5770,8 +5756,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 							  &conn->init_addr_type);
 			}
 		}
-	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c8d14128c363..714bb1d55926 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1616,7 +1616,9 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	return __hci_set_scan_rsp_data_sync(hdev, instance);
 }
 
-int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+static int hci_enable_ext_advertising_sync_ev(struct hci_dev *hdev,
+					      u8 instance, u8 event,
+					      u32 timeout)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
@@ -1656,10 +1658,16 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 		set->duration = cpu_to_le16(duration / 10);
 	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
-				     sizeof(*cp) +
-				     sizeof(*set) * cp->num_of_sets,
-				     data, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+					sizeof(*cp) +
+					sizeof(*set) * cp->num_of_sets,
+					data, event, timeout, NULL);
+}
+
+int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+{
+	return hci_enable_ext_advertising_sync_ev(hdev, instance, 0,
+						  HCI_CMD_TIMEOUT);
 }
 
 int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
@@ -6605,7 +6613,11 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 			return err;
 	}
 
-	return hci_enable_ext_advertising_sync(hdev, 0x00);
+	return hci_enable_ext_advertising_sync_ev(hdev, 0x00,
+				use_enhanced_conn_complete(hdev) ?
+				HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+				HCI_EV_LE_CONN_COMPLETE,
+				conn->conn_timeout);
 }
 
 static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
@@ -6656,8 +6668,12 @@ static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
 
 	enable = 0x01;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
-				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+					sizeof(enable), &enable,
+					use_enhanced_conn_complete(hdev) ?
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+					HCI_EV_LE_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 static void set_ext_conn_params(struct hci_conn *conn,
@@ -6761,6 +6777,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		/* Pause advertising while doing directed advertising. */
 		hci_pause_advertising_sync(hdev);
 
+		set_bit(HCI_CONN_CREATE, &conn->flags);
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
@@ -6847,7 +6864,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 done:
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
 
-	if (err == -ETIMEDOUT)
+	if (err && conn->role == HCI_ROLE_SLAVE)
+		hci_disable_advertising_sync(hdev);
+	else if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
@@ -7184,9 +7203,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn != hci_lookup_le_connect(hdev))
 		goto unlock;
 
-	/* Flush to make sure we send create conn cancel command if needed */
-	flush_delayed_work(&conn->le_conn_timeout);
-	hci_conn_failed(conn, bt_status(err));
+	hci_conn_failed(conn, conn->role == HCI_ROLE_SLAVE && err == -ETIMEDOUT ?
+			 HCI_ERROR_ADVERTISING_TIMEOUT : bt_status(err));
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.43.0

