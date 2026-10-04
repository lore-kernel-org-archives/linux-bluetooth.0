Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5536998A
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131182; cv=none; b=lEOL5exynVSkgCWk/aTFyY5AeKqQqFaXAiKDVpeZhqY+V8K4EVO/UqX4ZOLJzyYP9x00eRlUy9Ok5eqg3/YjyyVKQVrX+maFkaBBi+w490rTR7NNGda+wijoIhP+cvgIpkClRG5Mua9ltEVeIxGV8G1DkKxWfVQLBicWzDJc76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131182; c=relaxed/simple;
	bh=Rj63DgR20oiwFDDc12/4Ve6f46BYY+nTaOfWOvX5CNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEPX02UpeUGkuQrDC+bKpPAgjOPh3FlNgXAKjMZrOWT4puS2IRYDUMiVFCa/ItfHf9ARyxCjAqJZm0S0HbDloFz8QSkIi9SC8+9bhsGJBZe2ufQLXsBlKWuMPpIlMAOZHNmgEW92Qt2KfPFbuwyce57fBtoiVcUloPY4Whb6HTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvk0aRfI; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvk0aRfI"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144fa6e60bcso36919c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131178; x=1791735978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yikDAY6J+GlEGObfqqnaCvM3+Krl2SbWGorcnJKWLX8=;
        b=Qvk0aRfI4PS08pt2e3It3JwW7TiU0iMUNWzS377Mu/KEYZV9SMV4l71WT/RgjPR1pQ
         cp7ubkA4aUGQoZbK2ZaKqjVIzLXkEaao0NpxuoViDazWZUCms/r2y6+jYMsS+/rMdEgS
         WXs6Umj0r8GsAjWETon/uol3URFCG/q/HYNhESfkxZ6Am/GW+ZLp8nmT5UvhQUfWbO4j
         XuTdgKrNmdmG1kMWLasUtS83TtdHI5IKJKeIcVAxPlITmyDdJvqxAOKf9shQVty7skdq
         ixak08g3IwEHpRX6iZb9Juzjz2XEipv23z9G9RsrRM3zzACu3TtqoIhef8oNVb+ZNOpQ
         I/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131178; x=1791735978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yikDAY6J+GlEGObfqqnaCvM3+Krl2SbWGorcnJKWLX8=;
        b=AQ5oAby/XylfKsvePQ0Jc3tijFbDW+XJXTDMVcrQN807vroELrDh4Ecc1N+eWhb3n7
         OQy4Gos3Py3Xa25rir9AS8ghk4SWN9eK1nkdpZ6WcAa9hXSO/nAOTA8mPHw5aLUVm9cB
         LzX9P0CcC4KPzS8d3Gm//zUY9xnxbGkFkf3vI/XR+M7Zq13kCqwAceHaIRWT904gob/H
         aCXVKmv4uc0ti6ydAiELujpG4ayIT2jBpB85N5lBeYVDqbVgF+og2QqVkkcI+MX6obw8
         GPNXdZxRy96vBACWfpsI0n+SOhldSpHoY7CaKThoS+i19kvd6O+w2YaNeCryKimBB6Km
         DBNg==
X-Gm-Message-State: AFuF++knBbQJFmM1CZmbUEtW2qFUmuZeUdUk8hktFPzZ2YQVNMiiCsrV
	33IfwE/cmVhFF4k/o0mn+zXhBtLLc3Oc7P44c1dBQrdDuSCDe0cjpq2U
X-Gm-Gg: AYBFou0hZ0D00FmnzONf2GavYvONlphojTJh/nNQxGg6g/QfntEFiJs20etSKrVHXGG
	24Y4Nhvz45ttZZBenR3f8tYiE5O2FGVfZW+1N5IuEifwv6ijolNC0PR7x/THI2jmT/GSySJdlW8
	jNtUFrhlRnloKjhAKclyq9iAfv0IWRpHIiEbwdmm5OQHv5VCWyV2/c38QhiZ4v4VFuvTu7+V9vK
	1az2LGwouGoi/hECcnjMhArMGG1c73Ss+32meJ3sAj6Vso/FZXfEHjoCVYZvUI+OH4hrrLq33Kp
	FbZD9sUKBla5IdYgKjt4pWD6t1eICRmwdJ2aKLlH3fq6TA1GEh0DjBG6ceUUTItwjrsjJicjgcr
	bI6F34QLDkxnFQWHxoUYsKnkYBXW4lDW9VCC4lkBX93J3vraTFtmwYCWGpSwvTsGTwuGgTI9MBT
	1sb57fFKK7+s/80V1y1P0SSWvY+NKRf4w7HZMGVpcwNp8+af1L78QC1ef1Z089hDYpB0efvmvgA
	979upmjpt38F319RUk3mxM6tHujFzxGJbNQFurVF5RhQFCpfuc5enySax9nsgKg3LNMAw==
X-Received: by 2002:a05:7022:b047:20b0:14b:edb2:c3bc with SMTP id a92af1059eb24-14f5625d203mr17992869c88.0.1791131177596;
        Sun, 04 Oct 2026 09:26:17 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcec9f1dsm15511885c88.16.2026.10.04.09.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:26:17 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix command skb lifetime during scan setup
Date: Mon,  5 Oct 2026 00:26:12 +0800
Message-ID: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During PA sync scan setup, hci_le_set_ext_scan_param_sync() gets the
address used for the PA_LINK lookup from hci_sent_cmd_data(). The
returned pointer borrows storage from sent_cmd or req_skb, without
holding a reference to either skb.

The scan worker runs on req_workqueue while hci_cmd_work() runs on the
separate device workqueue. After the scan worker loads sent_cmd, the
command worker can free and replace it before hci_sent_cmd_data()
dereferences the skb. The command payload can also be freed between
returning from the helper and comparing the address. The connection
lookup's RCU critical section does not protect the command skb.

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_sent_cmd_data+0x27c/0x2f0
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_sent_cmd_data+0x27c/0x2f0
   hci_le_set_scan_param_sync+0x43a/0x850
   hci_passive_scan_sync+0xb09/0x1460
   hci_update_passive_scan_sync+0x47c/0x6e0
   hci_le_pa_create_sync+0x200/0xa70
   hci_cmd_sync_work+0x13c/0x290

  Allocated by task 95:
   skb_clone+0x13f/0x340
   hci_cmd_work+0x2a9/0x7e0

  Freed by task 95:
   kmem_cache_free+0xba/0x3a0
   hci_cmd_work+0x29c/0x7e0

Use hdev->lock to serialize the address snapshot with sent_cmd
replacement. Protect req_skb replacement and completion cleanup with
the same lock because the helper falls back to that skb. Copy the
address before releasing the lock and use the copy for the existing
RCU-protected connection lookup. Release the mutex before sending or
waiting for commands, preserving the lookup and completion ordering.

Fixes: 22cbf4f84c00 ("Bluetooth: hci_sync: Use QoS to determine which PHY to scan")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_core.c |  4 ++++
 net/bluetooth/hci_sync.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2076689eb302..74d9865e08c2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4115,9 +4115,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	bt_dev_dbg(hdev, "skb %p", skb);
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->sent_cmd);
 
 	hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 	if (!hdev->sent_cmd) {
 		skb_queue_head(&hdev->cmd_q, skb);
 		queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -4138,8 +4140,10 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
+		hci_dev_lock(hdev);
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_get(hdev->sent_cmd);
+		hci_dev_unlock(hdev);
 	}
 
 	return err;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c01c8b58d9e8..a92a81846e9d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -32,8 +32,10 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
 	/* Free the request command so it is not used as response */
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->req_skb);
 	hdev->req_skb = NULL;
+	hci_dev_unlock(hdev);
 
 	if (skb) {
 		struct sock *sk = hci_skb_sk(skb);
@@ -3064,15 +3066,21 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 	 */
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		struct hci_cp_le_add_to_accept_list *sent;
+		bdaddr_t bdaddr;
 
+		hci_dev_lock(hdev);
 		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST);
+		if (sent)
+			bacpy(&bdaddr, &sent->bdaddr);
+		hci_dev_unlock(hdev);
+
 		if (sent) {
 			struct hci_conn *conn;
 
 			rcu_read_lock();
 
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
-						       &sent->bdaddr);
+						       &bdaddr);
 			if (conn) {
 				struct bt_iso_qos *qos = &conn->iso_qos;
 
-- 
2.43.0

