Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C086155397
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711347568; cv=none; b=ktfTBpyhmdNoGVgGOGUQWUM2FgCQDrYzASE5E+VD5DdZL4+ikXGjbsiX4J50X3p5ENm9Bl9SjCJgOm18PvzgP5lmWdI630vAqescw95eRhuUDCI8jlUu8WB7Ww/y++xVhxpYe17qmjP1ODmS84hVgyjJ8p/QXapAv+xMJ2nKlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711347568; c=relaxed/simple;
	bh=8aJAQTQbIyKL/euP/RmNjqmDZxOeB+RtT3g2oXBTYS8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lxfJ36ceYxs37eGAOZ6WIHCKGwBqFKY+WXRyd3EaCP7Lu49LQpQln5ttnJ+d8ZiZlt7qyet7M2v25egDwuXwpDZtYvA0zi/hecDeUXXT2xAETdeZTi8DBoqRkLRKJ7IlNPWqzO6kTUEVJshA192cJYsPxFyClZSIzn3oaC+dXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DwD6j643; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DwD6j643"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.66.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 69E013F2AE;
	Mon, 25 Mar 2024 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711347557;
	bh=/XfgtjibyARS5nJRafQ1ktx5gaZeNUQBlANLlHqMT28=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DwD6j6437+iGl0eBWdWsSEvS8soHKgU7/P4n2tIlua8DQaw81p2YYvIZ6OjicC7wi
	 0TTWNaRdEHetFMOqZahuqUkhCEakHjVO7P8x5685VibMmGOQZFzliY337QPIXOGg53
	 jeXnTDpJ6QwkrWJwdod3TcPGOX1zFCJD6YAx2pl2gAtNC1HCuo8SdEtXcXdEJYlsCD
	 JH3eLX1VtpsBW5B2OalNyavTGIadw3X+48F9InurBQnc0uNk2zjOj5Dz9MMsoKjGaP
	 p8iS4hiRYuCXETnthnVFihvisp0K9xBQKBTsV7s7ngFT6sVk80JiLfbELIfImSkxWo
	 kjxWJQcrnO0WA==
From: Hui Wang <hui.wang@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth: hci_event: conn is already encryped before conn establishes
Date: Mon, 25 Mar 2024 14:18:41 +0800
Message-Id: <20240325061841.22387-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a BT headset (Lenovo Thinkplus XT99), the pairing and
connecting has no problem, once this headset is paired, bluez will
remember this device and will auto re-connect it whenever the device
is power on. The auto re-connecting works well with Windows and
Android, but with Linux, it always fails. Through debugging, we found
at the rfcomm connection stage, the bluetooth stack reports
"Connection refused - security block (0x0003)".

For this device, the re-connecting negotiation process is different
from other BT headsets, it sends the Link_KEY_REQUEST command before
the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
command during the negotiation. When the device sends the "connect
complete" to hci, the ev->encr_mode is 1.

So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
this conn, and update conn->enc_key_size accordingly.

After this change, this BT headset could re-connect with Linux
successfully.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
This is the btmon log for auto re-connecting negotiation:
Before applying this patch:
https://pastebin.com/NUa9RJv8

After applying the patch:
https://pastebin.com/GqviChTC

net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ae224824012..0c45beb08cb2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3208,6 +3208,32 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_ENCRYPT, &hdev->flags))
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
+		/* "Link key request" completed ahead of "connect request" completes */
+		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+		    ev->link_type == ACL_LINK) {
+			struct link_key *key;
+			struct hci_cp_read_enc_key_size cp;
+
+			key = hci_find_link_key(hdev, &ev->bdaddr);
+			if (key) {
+				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+
+				if (!(hdev->commands[20] & 0x10)) {
+					conn->enc_key_size = HCI_LINK_KEY_SIZE;
+					goto notify;
+				}
+
+				cp.handle = cpu_to_le16(conn->handle);
+				if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
+						 sizeof(cp), &cp)) {
+					bt_dev_err(hdev, "sending read key size failed");
+					conn->enc_key_size = HCI_LINK_KEY_SIZE;
+				}
+notify:
+				hci_encrypt_cfm(conn, ev->status);
+			}
+		}
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
-- 
2.34.1

