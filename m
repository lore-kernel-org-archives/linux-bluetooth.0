Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E33546C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170124; cv=none; b=X1E/oJUUHbyGeEaztr3bBfB+VcCKzbmzzmbLykcsvwKxmFRZsi7FDJ+b+zignFfTUOkuuV1wXKtCYxAlnLkPOfPo+lr9UdWhdw/N8y0qepBcv0+CYKycts4pepMU3iCcWmxiMZgeFYtSQiVo5blAcb2vT3MKwDmVO46REVDjtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170124; c=relaxed/simple;
	bh=RIgAITDV10bwuGVzOepFntdtCOFmtwmPcCIM01eQ6hQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Nz0dMCSQ7LlXJCKMb2cPJF1MTH9gheqUxLAvyP6+ZUuWQ3M9TIQm4+xtGuCaIQOv99V5TZSYBV1oP7CcNgiA/0JXi5TKUUFaSKG76v4Ck+wo6V6K6hx6KPcDXzw7dGPPAj3ci1q+F+IO4dM8jzwsfNh6h2xj1O70LYmmjj5NBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=pjcsGI9j; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="pjcsGI9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792170105; x=1792429305;
	bh=4cDh1GFBsgXPcb/IB8HyY5KM78MLBu5fXw6Ngm1w9oI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pjcsGI9jsrBq6ISfO86wSxyYL8PE9CaUxLWliPR1XRVrlTPwABEb+aShnUUTzE3s0
	 2UVekvp2nL9ydViW6z1198LiNk50S4QBBpoW8JVzAlLeemZ9nATw+WLv9y5WcB5En9
	 f+t1BnEn1H6W4OAVwYeNG3M/u5ev/7CQHn9mlM9q7svkf3HnLMQF7HVJo+3Jg5mMlM
	 SSiduzbuuX2dKA/qNuJyTCKa8eW0+DKVLWcmHXX3OekCA5lO0JFx8Gze8ixUdmbsEc
	 i9Ni6f0i4uAqfVzIkKMFPRZAjy5m/yx/yylMikfDUPasy5DgdJk9Rucm7rhgf4oB8x
	 wwImsKffmK4Ww==
Date: Fri, 16 Oct 2026 17:01:38 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, sean.wang@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: request LE data length for affected MT7922 firmware
Message-ID: <20261016170122.27119-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 3de2cc44725577df6b868d79478d9177a50d5b5d
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On an ASUS G614PR, the MT7922 USB controller 0489:e0f6 accepts maximum
LE suggested default data lengths, but ASHA playback remains severely
choppy until the host sends an explicit LE Set Data Length request.

With the firmware image dated 2026-07-24 14:38:15, a request on the same
Cochlear Nucleus 8 connection produces a Data Length Change event with
TX 251 octets/2120 us. Delivery rises from 21.5 to 50 audio SDUs/s and
the peak outstanding packet count falls from 32 to 3. Wi-Fi power save
remains enabled. Playback also works with the automatic request in the
local 7.2.9 kernel build.

Keep the existing suggested-default initialization and add a driver-set
quirk for the tested USB ID, chip and firmware image only. After a
successful remote feature exchange, queue a request using the current
host defaults if the central-role link and controller support DLE and
the controller advertises LE Set Data Length.

Hold a connection reference while queued and recheck its membership,
state, role and capabilities before constructing the command. Release
the reference on completion, cancellation or queue failure. Failure of
this optional request must not reject connection setup. Other controller
matches, PHY fallback and suggested defaults are unchanged.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
This is the first submission of this MediaTek-specific fix. It follows
Luiz's suggestion, in review of a separate generic DLE RFC on October 13,
to use a driver-set quirk if a controller needs explicit DLE. It is not
a revision or resend of that generic request.

Differences from the separate generic RFC:
- Require the exact tested USB ID, chip and firmware image build.
- Keep the existing suggested-default write unchanged.
- Require a central-role link, local/peer DLE and command support.
- Use current host defaults, not hard-coded transmit limits.
- Keep referenced queued work, cancellation and locked revalidation.

Tested on ASUS G614PR with MT7922 and a Cochlear Nucleus 8:
- Manual same-connection request: 21.5 -> 50 SDUs/s, peak queue 32 -> 3.
- Automatic request: local 7.2.9-arch1-2-asha-mediatek boots and playback
  is reported working; the matching firmware and quirk log are present.
  This local kernel/userspace stack has other ASHA patches. This is not
  a vanilla upstream-kernel hardware test or a post-boot throughput trace.
- Broader suspend/resume, battery, other-profile and native concurrency
  coverage is not claimed. An earlier brief quality drop is not assigned
  a cause or declared independently resolved.

Validation on Bluetooth upstream base 185c11232d5f:
- Four native Bluetooth objects compile with W=3D1 on an x86_64 diagnostic
  configuration (Rust disabled); this is not a full upstream kernel build.
- 37 source-extracted ASan/UBSan controls pass, with unpatched baseline
  and negative controls. These are not in-kernel concurrency tests.
- Equivalent backports pass the same controls on pinned 7.2.y, 6.18.y
  and 6.12.y snapshots. The 6.18.y and 6.12.y variants also compile the
  four native objects with W=3D1. No older-kernel hardware boot is claimed.

The firmware gate uses the selected image header. If setup reuses an
already-resident image, this is not an independent read of that image's
identity; the observed boot log matches the tested image. Please review
this limitation before widening the match to other firmware or devices.

Stable consideration: this fixes a real firmware interoperability issue,
but the change exceeds the usual 100-line-with-context stable guideline.
Please assess stable suitability after upstream review. No introducing
kernel commit has been established, so no speculative Fixes tag is added.
The 6.18.y backport uses the older connection-feature layout. The 6.12.y
backport also uses scalar quirks and checks queued duplicates before
taking a reference, since queue_once() there returns zero for duplicates.
Backport application/API differences and checks are documented locally;
no stable acceptance, older-kernel hardware test or public issue closure
is claimed. Please do not queue an unreviewed backport directly.

 drivers/bluetooth/btmtk.c        | 29 ++++++++++++++++
 include/net/bluetooth/hci.h      |  6 ++++
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        |  8 +++++
 net/bluetooth/hci_sync.c         | 58 ++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 75483d823..cab5c4c36 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -47,6 +47,24 @@ struct btmtk_global_desc {
 =09__le32 section_num;
 } __packed;
=20
+static bool btmtk_needs_manual_dle(struct hci_dev *hdev, u32 dev_id,
+=09=09=09=09   const struct btmtk_patch_header *hdr)
+{
+=09static const u8 affected_build[16] =3D "20260724143815";
+=09struct btmtk_data *data;
+
+=09if (hdev->bus !=3D HCI_USB || dev_id !=3D 0x7922)
+=09=09return false;
+
+=09data =3D hci_get_priv(hdev);
+=09if (!data->udev)
+=09=09return false;
+
+=09return le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x0489 &&
+=09       le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0xe0f6 &&
+=09       !memcmp(hdr->datetime, affected_build, sizeof(affected_build));
+}
+
 struct btmtk_section_map {
 =09__le32 sectype;
 =09__le32 secoffset;
@@ -219,6 +237,9 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, con=
st char *fwname,
 =09u32 section_num, dl_size, section_offset;
 =09u8 cmd[64];
=20
+=09/* Re-evaluate the firmware-specific workaround on every setup. */
+=09hci_clear_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
+
 =09err =3D request_firmware(&fw, fwname, &hdev->dev);
 =09if (err < 0) {
 =09=09bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
@@ -347,6 +368,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, co=
nst char *fwname,
 =09/* Wait a few moments for firmware activation done */
 =09usleep_range(100000, 120000);
=20
+=09/* This firmware accepts maximum suggested defaults but needs an
+=09 * explicit per-link request to negotiate a larger TX data length.
+=09 */
+=09if (btmtk_needs_manual_dle(hdev, dev_id, hdr)) {
+=09=09hci_set_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
+=09=09bt_dev_info(hdev, "Using explicit LE data length requests");
+=09}
+
 err_release_fw:
 =09release_firmware(fw);
=20
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1c992e875..513ca226d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -340,6 +340,12 @@ enum {
 =09 */
 =09HCI_QUIRK_BROKEN_LE_CODED,
=20
+=09/* The controller needs an explicit LE Set Data Length request for
+=09 * each central-role connection despite accepting suggested defaults.
+=09 * Set during the vendor setup callback for affected firmware only.
+=09 */
+=09HCI_QUIRK_NEEDS_LE_SET_DATA_LEN,
+
 =09/*
 =09 * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command is
 =09 * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is required
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
index 56ad10ab9..d78f330e3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6875,6 +6875,14 @@ static void hci_le_remote_feat_complete_evt(struct h=
ci_dev *hdev, void *data,
 =09=09=09=09conn->le_tx_def_phys &=3D ~HCI_LE_SET_PHY_CODED;
 =09=09=09=09conn->le_rx_def_phys &=3D ~HCI_LE_SET_PHY_CODED;
 =09=09=09}
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
index 7ac26daba..f919249e9 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8152,3 +8152,61 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys=
, u8 rx_phys)
=20
 =09return (err =3D=3D -EEXIST) ? 0 : err;
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

base-commit: 185c11232d5f586489bb3b74e6bcc7a6560ddd40

