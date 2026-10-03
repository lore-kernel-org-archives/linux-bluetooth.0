Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FD392C2F;
	Sat,  3 Oct 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015153; cv=none; b=bToL/CaKsELdQkFkBTuoh01pj2FUO5JOnGg4CvoC/aUNe3IyrQCxphtYFKZQYwFx1vRbNnuqL5Lg74+9lKsFxOLlB/6g/wKVjvgFB/+fXTGIVCUvYFrlCm/yh/LeuHD+ljE/QZOouzmuz/0rIatENbLF1rJkKRZ2WAOh1QJuXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015153; c=relaxed/simple;
	bh=8QCmAtoIp3t4FCD514njzl+gBJHFnJzQDwyGCKPoTdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nLlxNJGOeNO7lZp6edMniwxoONmP2VHnUrbbrwJQ7uBu5QDw+fTJNgvYJ3Q1NODHHqsr8Rr8+dptTM+fuTzuXB5T52dsHpP5QdWyEXAwunmQ3TtiiV3XscCSHM68N79cNJatcZ4Vj9zG6lr3iAFQFVZiTe/ZM24xODzjCWudMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a9/jIq6E; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a9/jIq6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vu
	u04VTFmr4tu+lBddHFDRfVGtQ4uw8E9w5dfXioYI4=; b=a9/jIq6EXNo4zOASXU
	E2Q07Re5hmG/beXvBspCI8z+8YALo3D7tUcAUM+PnhuPBguk0wSqK3McjDSdal+9
	0KOI5zWLOSERDA7HGAnYEzzfM8Vs8bOrc/nTnRJL/N0u9p1HOGTQr8mPt/KXwPCY
	q7cZA1jwAttFa99RTgAz8iZYU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDH3X_XuMBq54w2CQ--.15705S2;
	Sat, 03 Oct 2026 16:12:08 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Bluetooth: mgmt: handle mesh send completion queue failure
Date: Sat,  3 Oct 2026 16:12:05 +0800
Message-Id: <20261003081205.433725-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH3X_XuMBq54w2CQ--.15705S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15uw1fJF4rKrWUury3Arb_yoW8Jw18pr
	Z0g3ZxAFW8WrZrGasrAF4xuFZ0yrs5Wry2kr97X3sYyrZYqrWqqr18KFyjyFyrurWDJrWj
	9F4DtF43Xa93KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFoGQUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRgvaWrAuNjA8QAA3o

mesh_send_done() relies on the queued command and its destroy callback
to clear HCI_MESH_SENDING, complete the current transmission, and start
the next one. If hci_cmd_sync_queue() fails, neither callback runs and
mesh transmission remains permanently marked busy.

Run the completion and continuation callbacks directly when the command
cannot be queued.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/mgmt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac4864e56ec7..690af594ddf4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1131,11 +1131,16 @@ static void mesh_send_done(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    mesh_send_done.work);
+	int err;
 
 	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
 		return;
 
-	hci_cmd_sync_queue(hdev, mesh_send_done_sync, NULL, mesh_next);
+	err = hci_cmd_sync_queue(hdev, mesh_send_done_sync, NULL, mesh_next);
+	if (err < 0) {
+		mesh_send_done_sync(hdev, NULL);
+		mesh_next(hdev, NULL, err);
+	}
 }
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
-- 
2.34.1

