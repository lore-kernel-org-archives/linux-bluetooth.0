Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB97258EF3
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790491379; cv=none; b=Yq0t1QzMAHZNSPf/NQSt2aobbkB77nBS2VsXupn5sFeo/BiWR5+65MiXDLbE7qxRKnsidJqXVMXbSXdwzX6IGYYGV3LC1cRSKR9CqR/BY924RdhZhqaYDPJbmL5zLPUUBZ4mTyZAQCpV723Na4xmnXmX0vWVpRIw8quaM7EvLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790491379; c=relaxed/simple;
	bh=SHX5CcZ9NgZVQ7RWnVjWXD1ZsLK8zdEIarGY3RP0LB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOuwYvo91tPZKImfB8uklOZYSVGVnV5RrSK6pdLHuUui/decC6NoWrzysxPdSZbyoWypJZjLiQnZFHWPfFB66E2GGHIcAeL3OEUKD0nopekraM6MWb3HxZ5Su8HxPmmCcFzWXJjCpLO09vvQXRvvfIPGZznwaLxbKkl+jjiz9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdGZVksf; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdGZVksf"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-343241d5d34so47564eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790491377; x=1791096177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/cLSPE0PR+bWtbKuNr+eRv03HP0glFxHAl3V3XR+bQ=;
        b=rdGZVksfjK+6AJ982CS44WQ5u3MJg9HIygk+HU5IBSlcLNls3V825jOuEzFAR42pJs
         yhKKreutVURXzrx2ci3yyJwQSFCS9Vf0gSjqIqBzBpLYoEfN+RfSdWUYmyUyRU90LR4x
         HwZd754vXIeYI0fIkuJ3pX9DZXIzoewnLx3twms5lmGDJPrIMQSoV1u2IKIW1FXJsPEG
         kn0EUJtqNr0BDW5pMa/jln8wNOAfMCzZtgNJqwcUaaUE48NkQebVxMo03DpqtP/1ohxC
         fecRL/eMchykELsspv01W7rhQA9zKVOXZ+4OWtIOyRClHKcIc7K/hSdnFy29yzT4ldsr
         Czag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790491377; x=1791096177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/cLSPE0PR+bWtbKuNr+eRv03HP0glFxHAl3V3XR+bQ=;
        b=dBjM7XNygFzmtne3NZZAjvzUDuvFbSX7yDznzgMmfJmbcIGA9FN1vOKI6cHes0CdIE
         QhMWOy6tfMK3rAPRXROAs/CehFQKUpHSD3L0ET9KjqxKIqzH9XfSmNT/6brzk3Cr/MJs
         ruun9FQF9ILPex/APJ9Bd/nsUHd/xVIw27ykJCD7/KstsLSVQ/yV5lAG2n3TNC9wuMOc
         pNP9AQiqfRnv5Qj4cdClqXD8Vner+/TrI26A++YK2iCTle0FQ/PJ3Ug+fKWGXU2Qr070
         2Z29LpSbio5PyuWN8bWHs8lpYMasl4W4J9WeE5ENCf/5u9Gl/8ERY5rvB20IBh4DOSrW
         u3AA==
X-Gm-Message-State: AFq9FYIdE4BzoIeK05DFT23L+BEsn3e5mVnk6dXyay+Hinp5WKB2ged5
	/PqTxIxWR1dwko1ZJPhW6lWe/6uhnj/2kyJ0PExcVVBJ4MTjGDZKXnPL
X-Gm-Gg: AYBFou0ClUGB8sgD7M0ASvDrGRx7m3gNfIfvg8EouSAa4LARk3kA1hZ0flAV2jEpNwU
	0uMbvQGxI2z9GwEaK5DdqJ2oK5X4GgxvCPUc6YZsc6C/aTsI93uuT/U8HKRfDdX+ZGk+YHsYnTR
	KeErRdO2X5s7cUSMOGyB/64N1hvlZqu44SG8LFJUoMzbbFmH9BNMYhQZlegguPfxOvdZyl7/9Wg
	TtI5+vZVW+uEPy7LkMHZ+Kx0OrRfK17U/7y06keRsHkf6U8T3J4OTncroHKaGbSSEH26xr/0TeD
	r8mNMBQ6Exv38Bi7gQ1rnhpf76tMk9A/DxAoFSjZi37YUakPU7kbSZooMI7Ni+udZzXe5jeb2+W
	PcyuTGOyksY0SjwMa8SHPJvn4eRrOfra5hqbS44rTzXA9kk192j/+gxDI/i2KOYNnvllQ2UpTuA
	hoKwCbUWiSHq3bbrCRJWjMrIAylqFG2rrMLefv6accsl7c9DHNdTaxwzH34OdbqAfqSEmy2E/v1
	2sM+IuVWsgFG7iV7zVvQtAbX/PRsYix+c4ANuBx8yFug+sAsrvQy8tF7ZYhs5QGCNpnoW+PlK0z
	EhYu
X-Received: by 2002:a05:693c:2589:b0:340:f698:fd56 with SMTP id 5a478bee46e88-34273249209mr8610490eec.2.1790491376674;
        Sat, 26 Sep 2026 23:42:56 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm20236005eec.25.2026.09.26.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:42:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Serialize SMP remote OOB data access
Date: Sun, 27 Sep 2026 14:42:50 +0800
Message-ID: <20260927064250.3692041-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_pairing_cmd() looks up remote OOB data and copies its contents
without holding hdev->lock, which serializes the list's writers. After
SMP finds an entry, a concurrent management Remove Remote OOB Data
command can unlink and free it before SMP reads its present flag or
copies its random and confirmation values. Removal can also invalidate
an entry while the lookup is still traversing the list.

KASAN reported:

  BUG: KASAN: slab-use-after-free in build_pairing_cmd+0x948/0x9b0
  Call Trace:
   build_pairing_cmd+0x948/0x9b0
   smp_recv_cb+0x459f/0x8110
   l2cap_recv_frame+0xf14/0x9190
   l2cap_recv_acldata+0xa64/0xd40
   hci_rx_work+0x4ca/0x730

  Allocated by task 87:
   hci_add_remote_oob_data+0x11d/0x530
   add_remote_oob_data+0x282/0x400
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 93:
   hci_remote_oob_data_clear+0x108/0x1c0
   remove_remote_oob_data+0x198/0x220
   hci_sock_sendmsg+0x1033/0x1ea0

Taking hdev->lock in build_pairing_cmd() would recurse for callers that
already hold it and invert the device-to-L2CAP lock order on the receive
path. Add a per-device remote_oob_lock instead, held across the SMP
lookup and copies and by the add, remove and clear helpers. Cover
initialization and in-place updates as well, so SMP cannot read partially
initialized or updated OOB values. Release the mutex on allocation
failure, preserving the existing error return.

The new critical sections acquire no device, connection or channel locks.
Writers retain their existing hdev->lock protection, which continues to
serialize the other readers without changing their locking or behavior.

Link: https://lore.kernel.org/r/00660cd3-7d71-13a4-f617-229e6defb701@gmail.com
Fixes: 02b05bd8b0a6 ("Bluetooth: Set SMP OOB flag if OOB data is available")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 12 +++++++++++-
 net/bluetooth/smp.c              |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4105c446ca98..1bf0eb34f376 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -562,6 +562,7 @@ struct hci_dev {
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
+	struct mutex		remote_oob_lock;
 	struct list_head	remote_oob_data;
 	struct list_head	le_accept_list;
 	struct list_head	le_resolv_list;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9063..d77dd86720bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1489,8 +1489,10 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s removing %pMR (%u)", hdev->name, bdaddr, bdaddr_type);
 
+	mutex_lock(&hdev->remote_oob_lock);
 	list_del(&data->list);
 	kfree(data);
+	mutex_unlock(&hdev->remote_oob_lock);
 
 	return 0;
 }
@@ -1499,10 +1501,12 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
 {
 	struct oob_data *data, *n;
 
+	mutex_lock(&hdev->remote_oob_lock);
 	list_for_each_entry_safe(data, n, &hdev->remote_oob_data, list) {
 		list_del(&data->list);
 		kfree(data);
 	}
+	mutex_unlock(&hdev->remote_oob_lock);
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
@@ -1511,11 +1515,14 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct oob_data *data;
 
+	mutex_lock(&hdev->remote_oob_lock);
 	data = hci_find_remote_oob_data(hdev, bdaddr, bdaddr_type);
 	if (!data) {
 		data = kmalloc_obj(*data);
-		if (!data)
+		if (!data) {
+			mutex_unlock(&hdev->remote_oob_lock);
 			return -ENOMEM;
+		}
 
 		bacpy(&data->bdaddr, bdaddr);
 		data->bdaddr_type = bdaddr_type;
@@ -1548,6 +1555,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
+	mutex_unlock(&hdev->remote_oob_lock);
+
 	return 0;
 }
 
@@ -2485,6 +2494,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
+	mutex_init(&hdev->remote_oob_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d23f9d0729c4..2df303f6a38f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -662,6 +662,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		else
 			bdaddr_type = BDADDR_LE_RANDOM;
 
+		mutex_lock(&hdev->remote_oob_lock);
 		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
 						    bdaddr_type);
 		if (oob_data && oob_data->present) {
@@ -672,6 +673,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			SMP_DBG("OOB Remote Confirmation: %16phN", smp->pcnf);
 			SMP_DBG("OOB Remote Random: %16phN", smp->rr);
 		}
+		mutex_unlock(&hdev->remote_oob_lock);
 
 	} else {
 		authreq &= ~SMP_AUTH_SC;
-- 
2.43.0

