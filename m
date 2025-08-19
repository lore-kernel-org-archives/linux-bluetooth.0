Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BF23D29A;
	Tue, 19 Aug 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589365; cv=none; b=ClUEAnf83braSoKdvB7c2SsuN/C0piNt9IBg3kDaJZqi71ipC3S3hA0+MHb7Axdpzossogtj3xTHp7TS0BcnboehO85b5z1vAIK277AHQbgCUcbENKwptOo+/t1tC8J4JOOAXNume1hm7WitYopLKIk10Qq8GW1foDgI1GgwSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589365; c=relaxed/simple;
	bh=dtsONDXcxUqEo6LNwxFsIQLqVqe+nO9IR6P2RmIS7HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tAYlqL7dMclnvZtUG86hAFOWUy10rapCzPc0zhYMHuJLL9LkangBK2YytgPXubQkj6/FENKKjWsssq/ohbmIcxUY6ONTwERD1HH5bxsCbQNpIcJnyaRWtV8SHj4OW+HljtC4nQBQEDh2iAGJykiyp6ovT8BGRN0W+XlS3nmuCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jknt42Il; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jknt42Il"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF3DFC4CEF1;
	Tue, 19 Aug 2025 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755589362;
	bh=dtsONDXcxUqEo6LNwxFsIQLqVqe+nO9IR6P2RmIS7HM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jknt42IlORA1JNj3Zj4MkNGdVyuvmlZs1jjSqAzsZsYfDKo17Qt4LFPkKzR0AJBVK
	 ffvVp8BjnrK0xlU7PnJu+fxETWVovC/N02AhfKJ4FO3OPA5QTQgx4DdC9RVRngFYYB
	 gowMueLQiGZ/yInNLywxBQp/HEV8TqbiBn1pQgirfBlrwC4cvlKy7oePoWEn4AD/8I
	 29E/Fok5Ei6+GyuwPfHaPU7hwxffDfTzPhg2YrcXeuqKFuSstWv2EyWr0LdXkD3ZKo
	 TeZMdEvCmTqGoM8BHMuRi7/0hgVku1d0oEZJBQX0zXoFWyMHIi/FuuEb/JfayL/tZj
	 Q3hzSqOB2BLpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC23CA0EF5;
	Tue, 19 Aug 2025 07:42:42 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 19 Aug 2025 15:42:24 +0800
Subject: [PATCH] Bluetooth: hci_event: Disconnect device when BIG sync is
 lost
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-bis_dev_disconnect-v1-1-a87c540efc46@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAN8qpGgC/x3MTQqAIBBA4avErBPUiH6uEhHmTDUbCyckkO6et
 PwW72UQikwCY5UhUmLhMxSYugJ/uLCTYiwGq22rezOolWVBSguy+DME8rdqjEPrCG23eijhFWn
 j559O8/t+ujHoImQAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755589361; l=1615;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=/vhHRnEjB+7Jmzi7phGDpbSSLMxQT6GFh7t8rujQBfY=;
 b=51iFZ4j+7dfQHrrvk+ZfzzZSwBLCVJ61HsQRjqSXJGCbY7lVHUWcHJA3kcrd34NnN4QaCnwKy
 2ztKhhkfCZoApBo2wjDYODktyOGETXYQ11f+ApiWfqIjBE9XWF8kJis
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
 net/bluetooth/hci_event.c | 5 +++++
 1 file changed, 5 insertions(+)

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

---
base-commit: c921e5d14590381e6db7e451488b7b9ddc67a32c
change-id: 20250819-bis_dev_disconnect-31ad2aed27bc

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


