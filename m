Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BF47F2D6;
	Tue, 13 Oct 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862530; cv=none; b=hQYWUFiF/f5WeNt/Nf6VHfrJ0k2VbqaiMBiuD9Iwb4LQDEXqmWJtrttFUhN4PFpMOxvjU99C6UZMQT1I5q6vrsKvH0LkYRlVmBmF7JfpsQb49CRypmHk2etzKl2T1bYcUEllfql5FYFHOBxaZRRytE8Ip0ijINqsRwG0wGHnXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862530; c=relaxed/simple;
	bh=L0CmOLzhEVZkAmovFu48aO1CJgyIUR1itwOkk+4JmYY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZGKIA7uAvxHOtVgezTyUNvKk8TzYVMg3KVV9vcCsZ6cWEvhK33bOMQIw0v0KvcbCXWflAEyxF7lBJZm15MZHwOM7NP2QFGmRXhvCnftCLBD31YsXniKRCy2BjwP8FulXclVU/zHLqhhfkT6/5L5KWPxjrFpPH2sBPlRXGS57ub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=pwIrqbvF; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="pwIrqbvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=73qcnm4bcva5xlomlaotnvt57i.protonmail2; t=1791862513;
	x=1792121713; bh=czucG6/gefShWABLoyCoPYi9u23tHXRXHZure9Zps0s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pwIrqbvFvvpyHgIZy0JGwXhV1o2aZv9Eu3+UNh/loSrNWHxmeYJPaOtV3naDCWYSH
	 Ujv0iGJglxg6ewdRgGS1/ZNziOfh4r0k10ePow+tj1B8cUOKTiFa6wKSUX55LgMBiK
	 hJdY5NEr+O0rri5idTYOIG5SNOVRshe38tuTxMchg/2K99DQLO439enofPXLwIifJ9
	 pPjPnv4TSH5B4nBhOshHidZr0UifK9QhIhfXg3dpiWy6i/t9cNWgAyZdb0byvCnkjs
	 ZMYxnbcwHNuEj3dNlZZDf0IrLzgm7UdNo02rh5yMJUOwkD1mFLhowy+5mPI2LbWxqP
	 jcPcxoKRHx6MQ==
Date: Tue, 13 Oct 2026 03:35:09 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: hci_event: negotiate LE Data Length after features
Message-ID: <20261013033452.505349-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 7d3226e35ef6399e5338b354278e0e0364c6bf68
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Request the controller transmit limits once both peers support DLE.
Queue the connection with a reference so pending requests coalesce and
connection deletion cancels them. Check the connection under the device
lock before constructing the command.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Submission review notes (not part of the commit message):
The user reports that retaining the explicit DLE request enables the N8
to disconnect automatically after audio stops, whereas removing it
leaves the device connected. This idle-transition behavior is the
reported reason for retaining the topic, not an in-stream timeout.
October 9 no-DLE trials already negotiate TX 251 octets / 2120 us and
stream successfully; startup throughput alone does not test idle behavior.
The supplied captures do not establish a controlled post-STOP comparison
or the causal mechanism. This patch requests data length during setup;
it does not itself implement STOP or issue a disconnect command.
The claimed ASHA idle-disconnect requirement needs a protocol citation.
The corrected ownership implementation is included in the working kernel.
Native disconnect/handle reuse, LL ordering and post-snapshot races remain
unproved. Submit as an independent RFC with these limitations disclosed.

 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        | 10 +++++++
 net/bluetooth/hci_sync.c         | 47 ++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_s=
ync.h
index 59cb918d1..5a37d3e50 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -194,3 +194,4 @@ int hci_le_read_remote_features(struct hci_conn *conn);
=20
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
+int hci_le_set_data_len(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c055d16cf..4035f2659 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6846,6 +6846,16 @@ static void hci_le_remote_feat_complete_evt(struct h=
ci_dev *hdev, void *data,
 =09=09=09=09conn->le_tx_def_phys &=3D ~HCI_LE_SET_PHY_CODED;
 =09=09=09=09conn->le_rx_def_phys &=3D ~HCI_LE_SET_PHY_CODED;
 =09=09=09}
+
+=09=09=09/* Request the controller maximum when both sides support
+=09=09=09 * LL Data Length Extension. The Link Layer negotiates
+=09=09=09 * the remote limits (Core v5.4, Vol 6, Part B,
+=09=09=09 * Sec. 4.5.10).
+=09=09=09 */
+=09=09=09if ((hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) &&
+=09=09=09    (conn->le_features[0] & HCI_LE_DATA_LEN_EXT) &&
+=09=09=09    hdev->le_max_tx_len > 0x001b)
+=09=09=09=09hci_le_set_data_len(conn);
 =09=09}
=20
 =09=09if (conn->state =3D=3D BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e538..20c690007 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8123,3 +8123,50 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys=
, u8 rx_phys)
=20
 =09return (err =3D=3D -EEXIST) ? 0 : err;
 }
+
+static void le_set_data_len_complete(struct hci_dev *hdev, void *data,
+=09=09=09=09     int err)
+{
+=09struct hci_conn *conn =3D data;
+
+=09bt_dev_dbg(hdev, "err %d", err);
+
+=09hci_conn_put(conn);
+}
+
+static int hci_le_set_data_len_sync(struct hci_dev *hdev, void *data)
+{
+=09struct hci_conn *conn =3D data;
+=09struct hci_cp_le_set_data_len cp;
+
+=09hci_dev_lock(hdev);
+
+=09if (!hci_conn_valid(hdev, conn) || conn->type !=3D LE_LINK ||
+=09    (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CONFIG)) {
+=09=09hci_dev_unlock(hdev);
+=09=09return -ECANCELED;
+=09}
+
+=09cp.handle =3D cpu_to_le16(conn->handle);
+=09cp.tx_len =3D cpu_to_le16(hdev->le_max_tx_len);
+=09cp.tx_time =3D cpu_to_le16(hdev->le_max_tx_time);
+
+=09hci_dev_unlock(hdev);
+
+=09return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DATA_LEN,
+=09=09=09=09     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_le_set_data_len(struct hci_conn *conn)
+{
+=09struct hci_dev *hdev =3D conn->hdev;
+=09int err;
+
+=09err =3D hci_cmd_sync_queue_once(hdev, hci_le_set_data_len_sync,
+=09=09=09=09      hci_conn_get(conn),
+=09=09=09=09      le_set_data_len_complete);
+=09if (err)
+=09=09hci_conn_put(conn);
+
+=09return (err =3D=3D -EEXIST) ? 0 : err;
+}

base-commit: 964430c038967fd06643e866f68115664e1a1bd1

