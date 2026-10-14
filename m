Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFC3438A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943313; cv=none; b=iz8/Sr77zcjmoPD9W1fQiG9yIgyw6BDnAjPOFa5Bhsyea8+NGszLrutXDyeaB0r1UmZqaGxJx9Phfe0qNg2hC1vFqaspL0wCqAk+/g8WM35jDHaKwzcp4ydh6GJVRm19NqgpJHN7Immn7GwSRN5zXRfkFytHyPK6gAh2415JO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943313; c=relaxed/simple;
	bh=bU7/Gx358ch5+a9sv6/NMHosAwAPdmUl6ZxCeWlQLKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBWX3I/IoDgsnF+9JISKqVHIn7ID34VW3GtW6XQXhrZTnNGjAl7fMeOGjPAufOEn6Kj230kpIIgyoPLrSqoKvbb4kA9KPEW15a488oSnh89t7aChSMU8MQdVnp4rM7h8CGww63vTCWUru6K+X4St5BLXMO/rB3opkRXSgWLXyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kzBZaWMP; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kzBZaWMP"
X-Envelope-To: linux-bluetooth@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bU7/Gx358ch5+a9sv6/NMHosAwAPdmUl6ZxCeWlQLKY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791943308; v=1; x=1792548108;
 b=kzBZaWMPGqV4PkdzlG0AXse6OArOAlXpP6/c5X3YA9z5eWpQ8ONBgbzAKnK5ba5+hPF2w9vI
 Z4km1Dhpa5RMD+xoz2KcVxIp4AqAaG/vNtL8ckwNcHRXDecbT7teV+IhwTPsIdBnv3TdgCTNHlr
 6UloKT4Tx8fyDBkTkfsNVAe0=
X-Envelope-To: linux-bluetooth@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b3720ba25a7ff1a;
	Wed, 14 Oct 2026 02:01:48 +0000
X-Mizu-Trace-ID: 2b3720ba25a7ff1a
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix default RX PHY initialization
Date: Wed, 14 Oct 2026 10:01:31 +0800
Message-ID: <20261014020131.45467-1-liu.yun@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

Initialize the connection's default RX PHYs from hdev->le_rx_def_phys
instead of the TX defaults, which may differ from the RX configuration.

Fixes: 129d1ef3c5e6 ("Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 96195d2fd10f..c8fd3e2c79bd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1102,7 +1102,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		 * remote features are resolved.
 		 */
 		conn->le_tx_def_phys = hdev->le_tx_def_phys;
-		conn->le_rx_def_phys = hdev->le_tx_def_phys;
+		conn->le_rx_def_phys = hdev->le_rx_def_phys;
 		break;
 	case CIS_LINK:
 		/* conn->src should reflect the local identity address */
-- 
2.55.0

