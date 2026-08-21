Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57F383C99
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334037; cv=none; b=L54Nr64VMqr72DUqTHgo2jgCk57laqBjkTBZlQMsEySDwMOvBz/iPGZqM3bpcjvS7sRZk09bKDv5oL0TkM38QjtKcDDG2c7OniTGzIRBx726f7EZjFgBs2VXfPzoOvOE30XVnfPJRSzppepMvmWfzcjkzjpsP+BzVfhMMWxqN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334037; c=relaxed/simple;
	bh=P1Xq0UzEM0t7r9IEf/5mikKYu1zHCHI9UGwb3zHVBPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6QQBlnQ91nmtGG7KVgZS2GiQ2LiN9vuSnrpS0cFAT79m39MCYgBcpg78Rv8ouD9dZS8ryzhwExhl8plDCmiX9DRYELl/vlnKFa+Wyy+LVmptCEz0QVHZ/DjrS49+0KsXBT8xHyWI9ZKhU1lYnKa0+nq31dRW5jL/qGln1TpsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q67+dL98; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q67+dL98"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836d228798aso1085687b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334031; x=1787938831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5c3s5X8AAUMms2euYSrBnscwrovVDKGX5JSFjmzAWQ=;
        b=q67+dL98sKimy1YcBHXReoiLM5qVek4eiXOK2wduJlhtCtLb+KWhvj+gYBkSMBCAfC
         WT+9YnPllhMxTljztgEJaaqDS06Bwkxm2JMNCYp4KMd+3K4p5DamaOBDorq4EUHbig+E
         Gm92Lfg2XQsx3sHmeBpN6QOjY5fkOJkvY78r4DXByS6lyCNePJghFEbpsVX7XOFrwAta
         xSzlGEUAaqYL+wHI+wAziKWPh/ZYrK/s5pWhu1v99EvWAGXqdH7nibArYVrqZ51Ie8kG
         n7UrJ2VA7ZgLJ5uzzcFmTq7sJRaIl/Oysvdc2snDPSCtfrreUwvWEl9obuhg2aXwAJ6z
         aEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334031; x=1787938831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5c3s5X8AAUMms2euYSrBnscwrovVDKGX5JSFjmzAWQ=;
        b=RYzPSYqIJYIgq2jva3fln+Kt2Yd3pvaLJvLV4GJUuXNtP1SiM7kyqPIV/UyOXYCCGe
         4e/sNMpUiaGYufNrdPmdNwr48yAr8Y1nUMCZJwyBs8gvXvhhxc6cE8kvHIBbN01pYaAG
         FSnVMhENArh73u0x1t/knOZEbhbysgImiG1ceEmyzfNtKVN2AD5+5IVvwz+GBGJbLQ0k
         qFVcp6by4KeEcbLUuHS9SI5l5RmSy0ZpAqwLFiB8X9dULl4esYgB+q6zLTOz0k8I+9uR
         uDvXdM6o30/donv3oKRljheAaeC3ob2qrm8Cv4VjMOBMoN2wEZmEQwDDXuOO2gZi2vGg
         BDjg==
X-Gm-Message-State: AFuF++kQisZaKtnmPJT9MBOpUlD8sqq4NDwrqKaQfPInuOPknLHbh0RK
	mwHlENW6dQo2ixBuf3NLxptnCnR719DiCyB+fUV2JM+27nAHMi7v9UD3
X-Gm-Gg: AR+sD13jnufhZxrxVIiyrn8cYPMmWryIZAdf5E3vrGFInBxCkn7bbu92wYlGBO9CndH
	J+SoeElED21lVPbdpyfHm014ot1wURbHh1RugmqncZ7QLVhpua5i2O+GV/w3KzH+/tznBfwfcrY
	OWA9Qpu1qRcCfHhaWfhskKLsr5XKE7h0oCwERmUt6n9SsrvgXBQs7g2aXwQPky/VlayuF/xCSzO
	/CUfxy2rZG5ofmQL0YZz1/Xsxw3Cabfxg+EQtJb9YBKRetxr/RRypNGnJNGMv79FYewAEhC2zo8
	agbhfhPp9IFMahlDTSPjxv2K7/FJMxOP8Z6AGgEQI3lsOQRXM+3i9HnNqhFuEgLXmT4/Yu4AeKd
	k1h56+MG9p72pJRya3/4YN0syefx4jP7H0Yh+Y9vdnXzAy/ruMJUFhXVK3qDgBcGk8gw6hvJPKp
	gSkMSVCble4uog5QDumvf9/3f2GqMVmwKzLcIKBK5ALj96qa595t12yOK6fVmpqUz/ZtYEbTePN
	856o04M23o6QFEEsWhPl5ARhYYl4eqpGnh82FjV+/+tggqPUi/XlY4=
X-Received: by 2002:a05:690c:e013:20b0:81f:49e1:1f15 with SMTP id 00721157ae682-849ea01a334mr26664027b3.0.1787334031357;
        Fri, 21 Aug 2026 10:40:31 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abc153sm45081607b3.4.2026.08.21.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:40:30 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix reject-list lookup UAF
Date: Sat, 22 Aug 2026 01:40:22 +0800
Message-ID: <20260821174022.3033729-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_recv_frame() walks hdev->reject_list while holding conn->lock,
but reject-list updates are serialized by hdev->lock. Consequently,
block_device() or unblock_device() can mutate and free the current list
entry while the receive path is examining it.

The following interleaving causes the use-after-free:

  l2cap_recv_frame()             unblock_device()
  fetch reject-list entry
                                  hci_dev_lock()
                                  list_del()
                                  kfree()
                                  hci_dev_unlock()
  read entry->bdaddr_type

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_bdaddr_list_lookup
  Read of size 1 by task kworker/u17:1/88
  Workqueue: hci0 hci_rx_work
  Call Trace:
   hci_bdaddr_list_lookup+0xee/0x100
   l2cap_recv_frame+0x8a4/0x8e50
   l2cap_recv_acldata+0xa64/0xd40
   hci_rx_work+0x4ca/0x730

  Allocated by task 92:
   hci_bdaddr_list_add+0x12a/0x300
   block_device+0x94/0x1a0
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 92:
   hci_bdaddr_list_del+0x182/0x230
   unblock_device+0xa0/0x1b0
   hci_sock_sendmsg+0x1033/0x1ea0

Taking hdev->lock from l2cap_recv_frame() would invert the established
hdev->lock to conn->lock order. Instead, walk the reject list under RCU,
publish and remove address-list entries with the RCU list primitives, and
defer their freeing until readers have left their critical sections.

The address-list helpers are shared with other lists. RCU publication
and deferred freeing preserve their existing locked lookup and matching
behavior while making reject-list traversal safe without changing lock
order.

Fixes: e493150e3639 ("Bluetooth: Centralize looking up blocked devices to l2cap_recv_frame")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_core.c   | 10 +++++-----
 net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 509c820a693d..69bcc820d22d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2055,8 +2055,8 @@ void hci_bdaddr_list_clear(struct list_head *bdaddr_list)
 	struct bdaddr_list *b, *n;
 
 	list_for_each_entry_safe(b, n, bdaddr_list, list) {
-		list_del(&b->list);
-		kfree(b);
+		list_del_rcu(&b->list);
+		kfree_rcu_mightsleep(b);
 	}
 }
 
@@ -2077,7 +2077,7 @@ int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 	bacpy(&entry->bdaddr, bdaddr);
 	entry->bdaddr_type = type;
 
-	list_add(&entry->list, list);
+	list_add_rcu(&entry->list, list);
 
 	return 0;
 }
@@ -2148,8 +2148,8 @@ int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 	if (!entry)
 		return -ENOENT;
 
-	list_del(&entry->list);
-	kfree(entry);
+	list_del_rcu(&entry->list);
+	kfree_rcu_mightsleep(entry);
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee459dd411f5..f2e741b25cfd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7077,6 +7077,25 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	kfree_skb(skb);
 }
 
+static bool l2cap_is_rejected(struct hci_conn *hcon)
+{
+	struct bdaddr_list *b;
+	u8 type;
+
+	type = bdaddr_dst_type(hcon);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(b, &hcon->hdev->reject_list, list) {
+		if (!bacmp(&b->bdaddr, &hcon->dst) && b->bdaddr_type == type) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
@@ -7102,9 +7121,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Since we can't actively block incoming LE connections we must
 	 * at least ensure that we ignore incoming data from them.
 	 */
-	if (hcon->type == LE_LINK &&
-	    hci_bdaddr_list_lookup(&hcon->hdev->reject_list, &hcon->dst,
-				   bdaddr_dst_type(hcon))) {
+	if (hcon->type == LE_LINK && l2cap_is_rejected(hcon)) {
 		kfree_skb(skb);
 		return;
 	}
-- 
2.43.0

