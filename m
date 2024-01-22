Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95D47793
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942803; cv=none; b=BB2RSL94nNLK2jMQFqc/JfUSOJ6e4J65R6E8WBLiPmEiDLbh6yl7lGSoJ1rUIFPQKDrnr0YzZKGjgW6pnwWDYHq+qF2/wl8x0ksFgshOBRgT2y0GU1Luxm2bPagqCiWu2L3oIAz3SsGUs0x0EDridvWuzrzuy/d29QUCwNxYkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942803; c=relaxed/simple;
	bh=dY53ZZwQTdfTQidnD2oMQ+8X7hoCp/XDODJmfrxRaxM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=gD7dS7YAhRxKhPz1KYMPlX1QyT76xp0nAXRkW1HCvSVZ3RRppZY/hh1Q8vy9nz6rkzWwxZeY1bDQtEYgPPS4GYikvwydj5UxYx2lN+Zc3WMUBPRrazV2PAYc69HXUTUsZ/dXW8hyy7O1UUyQUtec0n/YL4dX+d2hY1YTPpmQx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NikZVnOW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NikZVnOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942800;
	bh=dY53ZZwQTdfTQidnD2oMQ+8X7hoCp/XDODJmfrxRaxM=;
	h=From:To:Subject:Date:From;
	b=NikZVnOWY/y9a52q3siIuOtHOo5Qrc5gY7sCpJR6ZFCWPQ85SXql73HI4Jvkwfu9z
	 k/YOQvh/ImLlEi3gXwSZa2N1tja/zDHexz0W74MeArCQVrroDerut0tu/r5iX3aaO5
	 e8DfGchSLTe/1ZsSr/U771psIRJymYXmhcQiSRKO7sdb+drKiIW0OkNBSNZJhb6p+/
	 vrtce3XI1KiIAgqB5tp7mvB8/25KYYhl7a/Illp2vbeNUAi3et2joUVcYVT6KjJDAp
	 eD85QXF5H3mwiGKKHubUUzXpIHrPDKMm4vOd7RxfzukV2eUlADkfY5BGai1dVBN/7k
	 rO6MCfChZSd+Q==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 919E937813B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 17:00:00 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Mon, 22 Jan 2024 17:59:55 +0100
Message-Id: <20240122165955.280126-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

LIMITED_DISCOVERABLE flag is not reset from Class of Device and
advertisement on limited discoverable timeout. This prevents to pass PTS
test GAP/DISC/LIMM/BV-02-C

Calling set_discoverable_sync as when the limited discovery is set
correctly update the Class of Device and advertisement.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 173986f3405f..8c4493255f92 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1045,6 +1045,8 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int set_discoverable_sync(struct hci_dev *hdev, void *data);
+
 static void discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1063,7 +1065,7 @@ static void discov_off(struct work_struct *work)
 	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	hdev->discov_timeout = 0;
 
-	hci_update_discoverable(hdev);
+	hci_cmd_sync_queue(hdev, set_discoverable_sync, NULL, NULL);
 
 	mgmt_new_settings(hdev);
 
-- 
2.34.1

