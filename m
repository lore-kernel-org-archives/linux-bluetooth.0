Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C33BB24
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLALYHwB"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59502aa878aso1769160eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822578; x=1705427378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyRlMyk1oGQnCsO+7EPfkXmXJnStecgFHMtT45h68x4=;
        b=YLALYHwBo48cuuW+gjpGNwZ4Tu5WshuG6RDXpNFdtY7e0/GmGup8Rku12ZfxgzyS26
         D7PET18Jo/33S/WUKv+TTdA6RqRhYw6pwxCjROVOmXHAkYxLvAVXqy5IYKmNjQqAHjAk
         ZGmw+4CV7zG50NDvQNVC+VsB5Dj4UalsohtwfaoocciJCe0kfJIdjUmpFMgQuEHZ1CKx
         TPXknBz1P8hakZ6lKeqAXQpD7WyxaWvVhtT2WQNJwErJ2kl2wZPplV53+hgZERXlTO/3
         ++ebDYYulA5lH5ADYiw3UpGluVsVed2IuBRcR9BbsBup+00TFXBqHrvEZRmLwnX4y0mC
         xNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822578; x=1705427378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyRlMyk1oGQnCsO+7EPfkXmXJnStecgFHMtT45h68x4=;
        b=oWHL3s131f3G8Ry+oVmDybojyU8lZ/jn2ytTYs8DnuLkYDsjWGIH6RdPDrb4AQf77y
         X340hnanLDPPRbqaMzLsmFK3hLyzfpuGo2g52f7ZSXtd3XzOWlFQc7J9YbJNs2uh2LDQ
         H7vpQZzjuz0vymqpSQpGtmmskblVIuJ1TtH5EFCJ9ujjeMFYg/F/KhjYaWOdwzyVS6QN
         YrWdS4N+2+efF7sEkUNpyPTaORyMCftLD2MgdgS0ObziyGZrEZaor2UAwtliQuCqsZ/I
         u+40rAFw14fP6bVyExDVGH0uzKkLh4RLkBO0RVhCVOGRA9TmVrrB7RWwyKF5+idV/zE0
         oCCw==
X-Gm-Message-State: AOJu0YzHx8IbM0Jl8v5EAZu1e0BkZNc0AOQ9nEA/zMkPF673YOr0Ghvx
	oZyD6vjidJd32pwZWWNBuiqBmiyfDmw=
X-Google-Smtp-Source: AGHT+IEd+jtyxMJiIEo1d7tdYQuw6scN23N2N+6dbkkiDwGwJpzHRTtpYDihdRpUSHxrolUnU2ruaA==
X-Received: by 2002:a05:6820:1627:b0:58d:974b:5056 with SMTP id bb39-20020a056820162700b0058d974b5056mr3923465oob.1.1704822577725;
        Tue, 09 Jan 2024 09:49:37 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id o184-20020a4a44c1000000b00595e66557e6sm476814ooa.6.2024.01.09.09.49.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:49:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: Remove pending ACL connection attempts
Date: Tue,  9 Jan 2024 12:49:28 -0500
Message-ID: <20240109174928.488595-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109174928.488595-1-luiz.dentz@gmail.com>
References: <20240109174928.488595-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

With the last commit we moved to using the hci_sync queue for "Create
Connection" requests, removing the need for retrying the paging after
finished/failed "Create Connection" requests and after the end of
inquiries.

hci_conn_check_pending() was used to trigger this retry, we can remove it
now.

Note that we can also remove the special handling for COMMAND_DISALLOWED
errors in the completion handler of "Create Connection", because "Create
Connection" requests are now always serialized.

This is somewhat reverting commit 4c67bc74f016 ("[Bluetooth] Support
concurrent connect requests").

With this, the BT_CONNECT2 state of ACL hci_conn objects should now be
back to meaning only one thing: That we received a "Connection Request"
from another device (see hci_conn_request_evt), but the response to that
is going to be deferred.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 16 ----------------
 net/bluetooth/hci_event.c        | 21 ++++-----------------
 3 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f8dd9173714..34aa9d0290fe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1480,7 +1480,6 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 				    bdaddr_t *dst, u8 role);
 void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
-void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8d2c2751455e..451004e70ca4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2596,22 +2596,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	}
 }
 
-/* Check pending connect attempts */
-void hci_conn_check_pending(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-
-	BT_DBG("hdev %s", hdev->name);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
-	if (conn)
-		hci_acl_create_conn(hdev, conn);
-
-	hci_dev_unlock(hdev);
-}
-
 static u32 get_link_mode(struct hci_conn *conn)
 {
 	u32 link_mode = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6130c969f361..cd3fcd2aeb64 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -120,8 +120,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
-	hci_conn_check_pending(hdev);
-
 	return rp->status;
 }
 
@@ -152,8 +150,6 @@ static u8 hci_cc_exit_periodic_inq(struct hci_dev *hdev, void *data,
 
 	hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
 
-	hci_conn_check_pending(hdev);
-
 	return rp->status;
 }
 
@@ -2314,10 +2310,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
-	if (status) {
-		hci_conn_check_pending(hdev);
+	if (status)
 		return;
-	}
 
 	if (hci_sent_cmd_data(hdev, HCI_OP_INQUIRY))
 		set_bit(HCI_INQUIRY, &hdev->flags);
@@ -2342,12 +2336,9 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			if (status != HCI_ERROR_COMMAND_DISALLOWED || conn->attempt > 2) {
-				conn->state = BT_CLOSED;
-				hci_connect_cfm(conn, status);
-				hci_conn_del(conn);
-			} else
-				conn->state = BT_CONNECT2;
+			conn->state = BT_CLOSED;
+			hci_connect_cfm(conn, status);
+			hci_conn_del(conn);
 		}
 	} else {
 		if (!conn) {
@@ -3039,8 +3030,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	hci_conn_check_pending(hdev);
-
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
@@ -3262,8 +3251,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 unlock:
 	hci_dev_unlock(hdev);
-
-	hci_conn_check_pending(hdev);
 }
 
 static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
-- 
2.43.0

