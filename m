Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D1B67A;
	Wed, 20 Aug 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656180; cv=none; b=Lx69lxdB22atsyfKBXWUGirKndgToIeElaIRflbHcwkLNKFhQmPffnHSBrKbsbOzmHd4vtSbnr/yqo3tsKIMLyiTQSj97SF0wx+3QiE3ARivpD/nCoc9KLZktQqUgIPn1zFX/802d11MItMcwTSzjUixxZXQCK4LfYREavRNKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656180; c=relaxed/simple;
	bh=CXv4CUbdg2DJqLAJ9Zvm3lBEiYdY4MTBMhMaeE8cmSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jXOMMOum5htPtc5SZcQw36GPnIf43Et/IMDlPo30xHA/uEouJWPpAHTIpk1+MJq5gK0rqf1sX+lomeFGXxMSvDv6eSODkm99GH+uj5geeMyNoaav5rN8+gCA3R1tDpcWhjMgqqwaHQCr4oxfa2t+N2tL6sZhy6tVwkyAGsVFTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw0QihFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw0QihFG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A515C4CEF1;
	Wed, 20 Aug 2025 02:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755656180;
	bh=CXv4CUbdg2DJqLAJ9Zvm3lBEiYdY4MTBMhMaeE8cmSQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bw0QihFGr6t0ZHZs+1qTSymuJh2ay6y0vgdnjAc62DSXLk27mQE5ndJmH9dixpwQR
	 YKMzkv0Bl/n9P0nKYtkPZkkUYs2xVTJq/eVwQWshy2TFByuwea125q6bG3X7jm5bSJ
	 qtuaITCZ1YmNGKYXujUj5H8RUClUTjkjJNLxbLFMiavrrUnz6SkF3qgMUbhe1szWMd
	 AvhXcUfwExV1wdxmm9CugeXgr90naBBVId7A66AwicsSUoUNPoDB5kzuxCnAaby1De
	 kPOy5ie6KygHlH2KnUHJohIclNvj3JqJz75wgT90CtPTwimU9eSsytVQhm/WeXRUz4
	 bttoMre77L/JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85ACA0EE6;
	Wed, 20 Aug 2025 02:16:20 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 20 Aug 2025 10:16:17 +0800
Subject: [PATCH v2] Bluetooth: hci_event: Disconnect device when BIG sync
 is lost
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-bis_dev_disconnect-v2-1-a0e1436690e2@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPEvpWgC/32NQQ6CMBBFr0JmbQ2tIMjKexhCynSASaQ1LWk0p
 He3cgCX7yX//R0CeaYAXbGDp8iBnc2gTgXgou1Mgk1mUKWqy1bexMhhMBQHwwGdtYSbuEhtlCa
 jmhEhD1+eJn4f0UefeeGwOf85PqL82b+5KIUUum2wrkqasLre9fp0M+MZ3Qp9SukLtE/4K7YAA
 AA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755656178; l=2319;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=v14Qp3rsVxau4kHADKxPc6IBwqZ+pK1qDr/sjGiTwJQ=;
 b=PbVSVKUqHK+OIDyPFHfbzDAtggCC20YCrbJ3NFjGGlzduPhzJMmQPI5m9OUvpaMuF/s6H1rBY
 7KB4QfLVQ1OAYAVKfg7I+ceanRlIx+zgDHmbVhJ7gYjIBZM/lnaZHPg
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When a BIG sync is lost, the device should be set to "disconnected".
This ensures symmetry with the ISO path setup, where the device is
marked as "connected" once the path is established. Without this
change, the device state remains inconsistent and may lead to a
memory leak.

Fixes: b2a5f2e1c127 ("Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event")
Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Add BIS_LINK handling to device disconnect
- Link to v1: https://lore.kernel.org/r/20250819-bis_dev_disconnect-v1-1-a87c540efc46@amlogic.com
---
 net/bluetooth/hci_event.c | 5 +++++
 net/bluetooth/mgmt.c      | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1686680a38c8..59aae893e0ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6998,6 +6998,7 @@ static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_big_sync_lost *ev = data;
 	struct hci_conn *bis, *conn;
+	bool mgmt_conn;
 
 	bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
 
@@ -7016,6 +7017,10 @@ static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
 	while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
 						     BT_CONNECTED,
 						     HCI_ROLE_SLAVE))) {
+		mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &bis->flags);
+		mgmt_device_disconnected(hdev, &bis->dst, bis->type, bis->dst_type,
+					 ev->reason, mgmt_conn);
+
 		clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
 		hci_disconn_cfm(bis, ev->reason);
 		hci_conn_del(bis);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3166f5fb876b..90e37ff2c85d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9705,7 +9705,9 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!mgmt_connected)
 		return;
 
-	if (link_type != ACL_LINK && link_type != LE_LINK)
+	if (link_type != ACL_LINK &&
+	    link_type != LE_LINK  &&
+	    link_type != BIS_LINK)
 		return;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);

---
base-commit: c921e5d14590381e6db7e451488b7b9ddc67a32c
change-id: 20250819-bis_dev_disconnect-31ad2aed27bc

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


