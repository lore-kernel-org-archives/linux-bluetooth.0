Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D182EA151
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007869; cv=none; b=XQycNDL/9QZD+UNh6yzXzAW323dsY+m/Mbr5evYU87szDANJHgsb+jg8mmsxSI+6qUoFXduCawR3LNicx2Qnav6DbMr4lUw/eorHOMmq1e2LgAwO7sT+ofierFk9Ohh+2OhfzYNj5bk1EfQR68Vuc73c1oniePhM4TKZzV/mbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007869; c=relaxed/simple;
	bh=ItM5kfeuUxShOQAIMce5fuzfTs80E+nk+vxR7NsYXpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekAv1byhAPRRPbmp1jWslv8zChhMD/YUUVMfnSuwsWi3HvK+8xGx3CbLtWnJM4Z8E/Dl+WadadQmEekjKCD61XiV8RH6ib9TdpSEv0dWCQtlnnaLPkrFiF0HsuHtMdnuA3Rd5DBFEdtlCKy/VTfUrCW9HRWVLo/gmGBHHLnCRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QJeHgbY+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QJeHgbY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755007866;
	bh=ItM5kfeuUxShOQAIMce5fuzfTs80E+nk+vxR7NsYXpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJeHgbY+WBAmYL1bscEe5uR/rJYCq2KoU7Ceg3Ud87RLY/Q2cfsh3iDCHB9LMu6zU
	 8DmqrA6w8ECVOK8MpRzwPSCF1if7BaxJMCiGyMvxvIBaTrnACxXoWvgs54su4vDz4U
	 VEnhncHf7JJcQxVwHBOOZ9YO9cHo0QRPbq4W8Bq3le5ivXYU3HXdZX9VSPOdDKWk0D
	 kZGBYRH7sNkr5oE9G2yqoS9zCVIJ4PYSOD4C+zUr32ZysSnPh4jUfC0l2elqMKRln0
	 +rky/HKZ9KPwYoHekThDjA0aY2ehS3DucupPxXetZpYw34H3S7hikGxIZnXDIBjj1j
	 AIBhTQtwrwGzA==
Received: from ryuzaki (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF3D717E046C;
	Tue, 12 Aug 2025 16:11:05 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH 1/2] Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
Date: Tue, 12 Aug 2025 16:10:27 +0200
Message-ID: <20250812141028.509783-2-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812141028.509783-1-ludovico.denittis@collabora.com>
References: <20250812141028.509783-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the host sends an HCI_OP_DISCONNECT command, the controller may
respond with the status HCI_ERROR_UNKNOWN_CONN_ID. E.g. this can happen
on resume from suspend, if the link was terminated by the remote device
before the event mask was correctly set.

Currently, the hci_cs_disconnect function treats any non-zero status
as a command failure. This can be misleading because the connection is
indeed being terminated and the controller is confirming that is has no
knowledge of that connection handle. Meaning that the initial request of
disconnecting a device should be treated as done.

With this change we allow the function to proceed, following the success
path, which correctly calls `mgmt_device_disconnected` and ensures a
consistent state.

Link: https://github.com/bluez/bluez/issues/1226
Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe7cdd67a..6c67dfa13 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2703,7 +2703,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto unlock;
 
-	if (status) {
+	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
-- 
2.50.1

