Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1757333
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084862; cv=none; b=CbhwygQ6jauxNAahiF7Qk5l9L1wSnYIDYoWsjaIfKH0IWAWZLJglaDguHaQwcw3DfL+FoW/WNphuLL6RllRPTYXU8xtf+SjdPKddnpGGeXMaLW85m/aZin1gEIkiozR7B8ZdhBendgc8SrCaPVKQPcBTR9csAlzofyM7bhitrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084862; c=relaxed/simple;
	bh=K+Vx22ry3yF4Dv5tr8n39v9QHEZ5GQqZkCP4W74I7g4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mUJUXbue2VZe1iqaes0eM41eyrRlhA5Xnu2esz4GGX1xdUDmMZTulF+d9Lkb48TSPcgeaq+6W6sImAd2U+G/xYM7rOTKXPcZo04N835z2UvAGHKLOf1EFkgy6WYNFN4aMpnlX12mAbgzkkhKHMnRYif5ATambgFY2s/+sERJfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5HcBgVg; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5HcBgVg"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bd2b37fe9so90232137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726084859; x=1726689659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWqOHUw5Aizij260SrxCSfdqSVx+ECrTOtieJYaOuPY=;
        b=e5HcBgVgB9z2IWUIZvZUewA3eXEZs+gOvG3wPo97ZxVfqNubajrdXlQDS0DaEAZz15
         kL3aKKmhIYKRJV1q2N8u33VW2telaxhOlcn7iD/sWIZwsXPzUZH0CTCFqh2RyW13++54
         FDhkWiRh2QVy1rivatGMJ7SJIihTmQfbwraOw7Czejys6kBIo3f49+YGsoLNO8inklvg
         xa5Zj33JSjx0uhJ32G4NQFV2IkMVDVRAYWRV0j0V3bEijt2Pq2b9d3JXdM9SaJtrDibX
         0cUhLD93xuuJttyfcNcTDZS7qsXpld4kbTZLe9ZT+1MkaKySSrsjwdG73gOyHKcD5aSb
         G0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084859; x=1726689659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWqOHUw5Aizij260SrxCSfdqSVx+ECrTOtieJYaOuPY=;
        b=TMXrDfYLIxW5khOfV+uCPnnjCuhWPOnf5lb3OMJxLz23BmrVG2PQzXQNUq+t6ddPog
         buM6g5WOh6QPpGA4xpKsWJrM7wYQRA/aUW81mi/PPxsITEtcE5/wthj3tVQQxk2g9iWZ
         7DeyASOjBU4zx2DcX0nbm/42IkHPqQ9U0EJFqZtH7WgR1J7PHx7tYvpIOAS4iOGQQmH8
         1rBhBTJhN8s9pH4w0dmMmD5o6i/lr1BNPkPfaHo2KxE/GaU1w9fmbpGZDJ5OadkDlboO
         LHe3acY95ErceYM6YuzYHU8CMJDEVXZdVrBcf/A4oiDUZFq9J43yhi340nb5IBbHIhMA
         G0Ug==
X-Gm-Message-State: AOJu0YxoA1b8zjpUa92MYEwGXIkMjGih82PBdFwoNgZ/2rYQg+JwTDQf
	otZgKxVLdjecIeeDiC4bXfpR6mM3pQ4AuSitpM4u3Y8oPqNaivjjWg1CNcG1
X-Google-Smtp-Source: AGHT+IEa2JQ0YZjzFeSNzfHgUtxRtkUaMNCovsj4JeGv7L9IunqaE9WyKqYEatHasEukNOOY2BK8Gw==
X-Received: by 2002:a05:6102:54ab:b0:49b:e505:15f7 with SMTP id ada2fe7eead31-49d414773e0mr1074359137.7.1726084856732;
        Wed, 11 Sep 2024 13:00:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84906ececa5sm68000241.35.2024.09.11.13.00.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 13:00:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Wed, 11 Sep 2024 16:00:54 -0400
Message-ID: <20240911200054.2884562-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
("Bluetooth: Always request for user confirmation for Just Works")
always request user confirmation with confirm_hint set since the
likes of bluetoothd have dedicated policy around JUST_WORKS method
(e.g. main.conf:JustWorksRepairing).

Cc: stable@vger.kernel.org
Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c   |  2 ++
 net/bluetooth/hci_event.c  | 18 ++++++------------
 net/bluetooth/l2cap_core.c |  8 --------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..b2f8f9c5b610 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..fd5752240ba7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3706,7 +3706,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
@@ -5324,19 +5324,17 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
 		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		 * proceed from user space and the local IO capability is
+		 * NoInputNoOutput, use JUST_WORKS method (mgmt_user_confirm
+		 * with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			bt_dev_dbg(hdev, "Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
@@ -5361,10 +5359,6 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 					   &conn->auto_accept_work, delay);
 			goto unlock;
 		}
-
-		hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY,
-			     sizeof(ev->bdaddr), &ev->bdaddr);
-		goto unlock;
 	}
 
 confirm:
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..6544c1ed7143 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;
 }
-- 
2.46.0

