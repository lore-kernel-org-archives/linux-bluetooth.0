Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03C2E03EA;
	Sat, 10 Oct 2026 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661654; cv=none; b=j3BuFRixJQxJlgj2sUEMXsXZEGNFVQKw3Bk0pZQ7JW9CdmnqyJd9mjDFa7wcEBeCNzRwRnZR3r4BUjae6kQt6bsesIjEDR1lFHsQeqEw9JJKnGYoeRiXXpw/XA+50MUhenHDNKJCu0h6vGRJOZ3JVADwP2XC5/YkHFzKrGlCY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661654; c=relaxed/simple;
	bh=9GauxRQzIAwsKzGDKgOy2WQh7zXa5Sd00EFKV27DEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLCUPbW834KanleuBdMn4EvfOrr/jHNZVJBEeasQWbBmWbiC43SRx+H6rV5wIbpnfygZjGSKaLRzpCltiddu77PIyzOnUW+31nrbTSAGC6FkLlmC2kWafUBYl5Vm1UCiXK3wPMFDeemmDIJe2t9NdlCjwTJrQ5oa6/EtY+9+H3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Iqt0c1uG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Iqt0c1uG"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B381780DFB;
	Sat, 10 Oct 2026 21:47:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BA18lJ_1ixDk; Sat, 10 Oct 2026 21:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791661649; bh=9GauxRQzIAwsKzGDKgOy2WQh7zXa5Sd00EFKV27DEtw=;
	h=From:To:Cc:Subject:Date;
	b=Iqt0c1uGKQKKi+C6iBhbs2yAQbaf9Nn1iEawSoj16JVWPFP7wbss1KU815CqEPpYm
	 Au8qvndSAPhDKanzIG1YSLa7XtpJInf/R7CAXE3fMy4W14y+gV27tNH81aRWElQFtW
	 VZMZgI1lrbLui5IMb62ZtVaGZoBLDY2T+bmj3vI+6qPzKr/48DitvGMMSQtRSqoV3p
	 hJ9xPPVHscIVqnzK6nWwRJYwBFU5uTaym+pGRbr4RF5dtgHHrc3qFjicY7n6pk2pVF
	 qkumJpu/BmqmWdVBqS7PfADNizAr/xiFxaT5eAsuYiodp1i03PDt6veqA7NpEPzrBx
	 u+PYSJtsOMHtw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Manish Mandlik <mmandlik@google.com>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: coredump: Don't leak an active dump when the device is opened
Date: Sat, 10 Oct 2026 22:47:04 +0300
Message-ID: <20261010194719.1364490-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the device is closed during a dump and opened again before the dump
timeout fires, hci_devcd_reset() in hci_dev_open_sync() clears
dump.head and cancels the timeout without freeing the buffer, so it is
leaked.

Free it instead after making sure the timeout is not running.

Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
On top of 860b93123309 ("Bluetooth: hci_sync: Serialize devcoredump
reset during device open")

Tested with hci_vhci.  force_devcoredump in TIMEOUT state, then
"hciconfig hci0 up" before the timeout.  Without the patch the buffer
stays in /proc/vmallocinfo, with it it is freed.

 include/net/bluetooth/coredump.h | 2 ++
 net/bluetooth/coredump.c         | 9 +++++++++
 net/bluetooth/hci_sync.c         | 4 +---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index acc1849f6..b8bba9a8b 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -70,6 +70,7 @@ struct hci_devcoredump {
 const char *hci_devcd_state_name(enum devcoredump_state state);
 
 void hci_devcd_reset(struct hci_dev *hdev);
+void hci_devcd_discard(struct hci_dev *hdev);
 void hci_devcd_shutdown(struct hci_dev *hdev);
 void hci_devcd_rx(struct work_struct *work);
 void hci_devcd_timeout(struct work_struct *work);
@@ -90,6 +91,7 @@ static inline const char *hci_devcd_state_name(enum devcoredump_state state)
 }
 
 static inline void hci_devcd_reset(struct hci_dev *hdev) {}
+static inline void hci_devcd_discard(struct hci_dev *hdev) {}
 static inline void hci_devcd_shutdown(struct hci_dev *hdev) {}
 static inline void hci_devcd_rx(struct work_struct *work) {}
 static inline void hci_devcd_timeout(struct work_struct *work) {}
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 71fc8dab4..b4283e6ae 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -104,6 +104,15 @@ static void hci_devcd_free(struct hci_dev *hdev)
 	hci_devcd_reset(hdev);
 }
 
+void hci_devcd_discard(struct hci_dev *hdev)
+{
+	cancel_delayed_work_sync(&hdev->dump.dump_timeout);
+
+	hci_dev_lock(hdev);
+	hci_devcd_free(hdev);
+	hci_dev_unlock(hdev);
+}
+
 void hci_devcd_shutdown(struct hci_dev *hdev)
 {
 	unsigned long flags;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e538..cc2f81b62 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5503,9 +5503,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		goto done;
 	}
 
-	hci_dev_lock(hdev);
-	hci_devcd_reset(hdev);
-	hci_dev_unlock(hdev);
+	hci_devcd_discard(hdev);
 
 	set_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_OPEN);
-- 
2.55.0
