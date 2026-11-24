Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529025;
	b=FYqFv7gHAZvsX59on8GR3N7ZjlIeoU+o1Gp0NPKI7c397AkM7PkbMnvU9EGvXhKLRk8r
	 SBk0siNhSPE8b+kVIWPnrjkq9bHfkhskPCEvpx+5rMJqIwbH52mROMNDU1L29scXf85QH
	 HOxwPOy4uBv9Qqk/r1HpKvfblMe9T3LJn4zosELd0SeZCPrhhRGBBWfzetOp2CqispKWl
	 fd7hJVkv0rFGvhacMRUzX2i1RvYA34jPBXczUTnqutmQib/TBoqcsqXXmVdNuYYPy77hm
	 GgKXcZA9o8GFonWEG7/kFkX26pwdDrdoBSANRHz0cLNKLSy4GAvfODX5upLu4wCx1eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529025;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=B9yYCG51wZGY5VYaruOeK8f+eJvxe9cZ0rtbqxcryBU=;
	b=Gk4o7S3nK6Rl1w7AtouK2y4fySLra65i3agZkqnIZ/BKXAEiN+E+eaBaF9+WBbzoh/fr
	 sGK70auk03ulgKhIxdDnPOzsA4UQEFLGyKa6wDqGiBlFLx38P14eviVWPA0wvNDBaNJuT
	 zaMl6oLBxAJ2k50B6dkC+wOel3309yOpjng6OZhmMehYZT1+OIEMozGleLjCKAAf/uXUa
	 WPSX/stO5vSCor+H2HTh++Z6/YdrWkWB/6zTEth9YtjFUDPLNIuy9LP4CfF2gxq9883YF
	 UDmisAYG2KsDwj0PIhfcCBixdgFMEPSFoOQ5BEXyLWyQF6Qd8O7k8YOcSyq4pQ1B7lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=mrjdrajlmzcidk7mkjmbpsmqv4.protonmail2 header.b="A/HWcYxn";
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8D60A261E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D8D60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=mrjdrajlmzcidk7mkjmbpsmqv4.protonmail2 header.b=A/HWcYxn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mrjdrajlmzcidk7mkjmbpsmqv4.protonmail2; t=1795529023;
	x=1795788223; bh=B9yYCG51wZGY5VYaruOeK8f+eJvxe9cZ0rtbqxcryBU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=A/HWcYxnF1l5NB3Zsy1sXn0lKMu8pXDwBwvfkAjSZoWLR1yoC4OqynXwzPAE1gItB
	 ugrrKD8oOO6OwaxtZc4ywDkxlUIamjqnvaA0F0d2tuYxE7+93lh9fpc/tH2QXIkZjq
	 m5wHm0WdWQvhNhucGNGTjR6Z1q6fnKa8rCx2AYT4PL+GRg4a/rfWhmA/sGIq2prQbR
	 2AcQYz86MO/f1vcHP585H/vt7FVSjvgI6WYBhkzy36X7Z9FTOO0ZpFb3vOy9Zqx9F/
	 8ZaH4KL6qEcKXHZqyxE3sxFkmvlZijE1scOcPba05cWkeFKMtrthbtTMfPJhxfqh6t
	 uk7Gelen5ygVA==
Date: Tue, 24 Nov 2026 14:03:39 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com
Subject: [PATCH v4] Bluetooth: request LE data length for MT7922
Message-ID: <20261124140325.3092381-1-cochcoder@proton.me>
In-Reply-To: <20261123233502.222664-1-cochcoder@proton.me>
References: <20261123233502.222664-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: d0b64ce96f547f49ebd0089e79001d5f7230cb51
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

MT7922 USB firmware can accept maximum LE suggested default data lengths
without negotiating a larger transmit data length on a new connection.
On an ASUS G614PR with USB ID 0489:e0f6 and firmware 20260724143815,
ASHA playback remains choppy until an explicit LE Set Data Length request.
A request on the same Cochlear Nucleus 8 connection raises delivery from
21.5 to 50 audio SDUs/s and reduces peak outstanding packets from 32 to 3.

Set a quirk for MT7922 in USB setup and request the current suggested
defaults after successful remote feature exchange on central-role links.
Require local and remote DLE support and the LE Set Data Length command.
Keep suggested-default initialization and PHY negotiation unchanged.

Do not restrict the workaround to the tested firmware build or OEM USB
ID: the affected firmware range has not been confirmed. Other MediaTek
chips do not enable the quirk. The request also applies to 1M peers that
support DLE, and ordinary link-layer negotiation determines the result.

Hold a connection reference while queued and revalidate its membership,
state, role and capabilities before sending. Release the reference on
completion, cancellation or queue failure. A failed optional request
does not reject connection setup.

OpenCode and Codex assisted with the implementation, review and testing.

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in this revision: disclose AI assistance in the changelog.
No source changes.
Previous version: https://lore.kernel.org/r/20261123233502.222664-1-cochcod=
er@proton.me/

A firmware fix remains preferable; the affected firmware scope is
unconfirmed. Wider hardware, suspend/resume, other profiles and
native concurrency testing remain open. GCC/Clang W=3D1 builds and
82 source-extracted sanitizer controls passed on the v2 source.

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 1b3dab0d1..1869815cc 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1858,6 +1858,10 @@ int btmtk_usb_setup(struct hci_dev *hdev)
=20
 =09btmtk_data->dev_id =3D dev_id;
=20
+=09/* MT7922 needs per-link requests despite suggested defaults. */
+=09if (dev_id =3D=3D 0x7922)
+=09=09hci_set_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
+
 =09err =3D btmtk_register_coredump(hdev, btmtk_data->drv_name, fw_version)=
;
 =09if (err < 0)
 =09=09bt_dev_err(hdev, "Failed to register coredump (%d)", err);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index efb85c781..85a4931e5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -348,6 +348,11 @@ enum {
 =09 */
 =09HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
=20
+=09/* The controller needs an explicit LE Set Data Length request for
+=09 * each central-role connection despite accepting suggested defaults.
+=09 */
+=09HCI_QUIRK_NEEDS_LE_SET_DATA_LEN,
+
 =09/*
 =09 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
 =09 * inside the LE Extended Advertising Report events are discarded.
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_s=
ync.h
index 509ec4161..eab827dfa 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -195,6 +195,7 @@ int hci_le_read_remote_features(struct hci_conn *conn);
=20
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_=
opts);
+int hci_le_set_data_len(struct hci_conn *conn);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *q=
os,
 =09=09=09   u8 num_bis);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6c7f9a9f..7ef2c4d19 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7436,6 +7436,14 @@ static void hci_le_remote_feat_complete_evt(struct h=
ci_dev *hdev, void *data,
 =09=09=09 */
 =09=09=09conn->le_tx_def_phys &=3D ~HCI_LE_SET_PHY_HDT;
 =09=09=09conn->le_rx_def_phys &=3D ~HCI_LE_SET_PHY_HDT;
+
+=09=09=09if (hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN) &&
+=09=09=09    conn->role =3D=3D HCI_ROLE_MASTER &&
+=09=09=09    (hdev->commands[33] & BIT(6)) &&
+=09=09=09    (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) &&
+=09=09=09    (conn->le_features[0] & HCI_LE_DATA_LEN_EXT) &&
+=09=09=09    hdev->le_def_tx_len > 27)
+=09=09=09=09hci_le_set_data_len(conn);
 =09=09}
=20
 =09=09if (conn->state =3D=3D BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2e88af51b..ac82aa085 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -9286,3 +9286,61 @@ int hci_le_eks_oppt_encrypt(struct hci_conn *conn)
=20
 =09return err;
 }
+
+static void le_set_data_len_complete(struct hci_dev *hdev, void *data, int=
 err)
+{
+=09struct hci_conn *conn =3D data;
+
+=09bt_dev_dbg(hdev, "err %d", err);
+=09if (err && err !=3D -ECANCELED && err !=3D -ENODEV)
+=09=09bt_dev_warn(hdev, "Failed to set LE data length (%d)", err);
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
+=09    conn->role !=3D HCI_ROLE_MASTER ||
+=09    (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CONFIG)) {
+=09=09hci_dev_unlock(hdev);
+=09=09return -ECANCELED;
+=09}
+
+=09/* Use the current suggested defaults, including later host changes. */
+=09if (!hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN) ||
+=09    !(hdev->commands[33] & BIT(6)) ||
+=09    !(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
+=09    !(conn->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
+=09    hdev->le_def_tx_len <=3D 27) {
+=09=09hci_dev_unlock(hdev);
+=09=09return 0;
+=09}
+
+=09cp.handle =3D cpu_to_le16(conn->handle);
+=09cp.tx_len =3D cpu_to_le16(hdev->le_def_tx_len);
+=09cp.tx_time =3D cpu_to_le16(hdev->le_def_tx_time);
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

base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f

