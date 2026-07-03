Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CB212550
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783122267; cv=none; b=q3l8CjyoKmPF10eNosK9gIE7MZjmJrqlBwJYKAM/l3YLLhE4YdCvKJNd3QPtnqKiIM459D2NeZ+Fa6YSXMjsFV0tyPFU4guuz2LMpDwiEdURpYR129F/WsqhI9A3By2nuvJKE71aN6NrtV6U64cmjFBJDnYmW4umdPI2U9xUH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783122267; c=relaxed/simple;
	bh=ND+Wv6r4wOF78Q5eEKwpzesmyiSU/qfJ7TGYtrE7A0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXJz5VIOLlZ5wttN8wE0574BNgFO1D1a83J0q5RQcAj0962TGRvFagVGh3tTZtz8QeRJA8zWs/nmYh9eHKM0KAwiWG+TZOFacRTAv/7XdzkoAZu0UInuYpTF5thjd6CS01wa9VDIt/uRfpDZlbZOz5PL9J16wlu4mWO8ON+rJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=emvnEi2w; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="emvnEi2w"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso663487a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783122265; x=1783727065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rks5YGAcJ1385Dxocys9sVAjRzx1bauM8Kjc3RgySr0=;
        b=emvnEi2w16N6gJya9iw4zHBiPYUA8D/MHMWPcDOE7f6DLdgrqGzwGe50bBYaRzy4nD
         tjNcvn1FrvieNpSlF4UV5R0o+70ZVAuD49+XWaieGywo5Z/1LTIKsN7NOmeq4gTZ0hg8
         mvsY4UzRf4w6oWNNIXLeklTH4C7ihwypDeF14wIb+o4eYymA+Tg8h/YuLtDry5OzKGJ1
         3p+mFQ2hSJXl9cIL5JiRTEL5OdaJaaxc2ro8yrg1HMwmuEz1REiYRXKK79AXvkfTogkX
         AVHw04FqBYJ+upIH6Yf9h591586pm3wKGAnDh2FMYzCcrR3SfeJ/pCXwT6NmwgIt3cX7
         L6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783122265; x=1783727065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rks5YGAcJ1385Dxocys9sVAjRzx1bauM8Kjc3RgySr0=;
        b=s2WeQL99S9jYY3zFnv36JjskObE8ER68wBM/t62mnf5kcw99Y8T8F8LVYP/U5Q/ghs
         SP5cA1S/Tkvq/YdiJ9go0pEM/SXY1TTd4w9hi+Bv6nR9m+/puJ1zWDKiygP/WwPhEu5c
         xjyVzwfJXaV5LOYxwYIkAWAGCYAVdONBDIOBJFD0pv9kL87sQIY5+LRPpiOWAxm2h3KG
         5OdfY6Jv8QGui2VhQGIQf9UlEHHCUiRVkgUC085S2IVg/pzSw1JSa4+4SRrYhr8/ysmu
         RVXpBjbLR83DH/DZq7h/7hsiWFXHxZJ0OYGwIi3R46UmUPuIbjwARrWnHgpu7q3JBiNi
         BwMg==
X-Gm-Message-State: AOJu0YxsbOnLVnALro7KeH8cIz589TS18XvsBk6GLeeJ5omO1jbTRpn4
	sdg0ZC+zOa/tRxFKmyuZ6vqC/y2CnUwP97SpAfvWoxnZPEI98J6tMWZLfs10RiRn/vEdLw5MvmO
	hhzo=
X-Gm-Gg: AfdE7cktSsCq6W4RW94X9dLey+nPLVSaqIWEWi6c0kdwR8VWfkB/aG807KdHwc5OhOk
	ni5rj31EYhfNasRONtLXy0pIvc/twwQxCQvcs8CJK3u8g/ua86giD7sPYcYCo2uKaj6KE3RLl24
	d2MlvJjKbS6QgrY8yw1aGhc9wN3nsQvRBZwCOq5wCgHK0Cab5uZlYivzx0xrqeC6ne1uEbW7Xxx
	eYcCJma2afpMQ8MIg9Wn/+sGdzlAjOjsLUatyIvzpSUxm1jZ11wRo6V6cOrprkqm0ojl7crRgIO
	fkj4Qw+dcytev0heUON/gcFt65FclojOApYjlY8sWllpNOdktQMmekanPRkOXo+CpqtUi17Hids
	FFyhWnbdZiR2mlKPrkBhn1s+eEGryhpO6b8ZN7ekOzeDyZWmbZ9XybtxX93KUHMKnyFrnLYkfyQ
	==
X-Received: by 2002:a17:90b:3909:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-382806b0a6amr1286680a91.9.1783122265404;
        Fri, 03 Jul 2026 16:44:25 -0700 (PDT)
Received: from p1.. ([172.56.107.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097ba48d0sm2835739a91.1.2026.07.03.16.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:44:25 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH bluetooth] Bluetooth: hci_sync: take hci_dev_lock in hci_clear_adv_instance_sync
Date: Fri,  3 Jul 2026 16:43:50 -0700
Message-ID: <20260703234350.225221-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_clear_adv_instance_sync() runs on the cmd_sync worker without
hdev->lock, yet walks hdev->adv_instances and calls
hci_remove_adv_instance()/hci_find_adv_instance()/hci_get_next_instance(),
all of which require hdev->lock. The list is otherwise serialized by
hdev->lock (add/remove_advertising mutate it, read_adv_features()
traverses it), so a concurrent holder can list_del()+kfree() or list_add()
an adv_info node mid-traversal, causing a use-after-free and list
corruption. Reachable by racing MGMT_OP_SET_LE(off) or advertising timeout
expiry against MGMT add/remove/read advertising:

  BUG: KASAN: slab-use-after-free in read_adv_features+0x44b/0x500
  Read of size 8 at addr ffff888013878000 by task exploit/150
  ...
  Call Trace:
   read_adv_features (net/bluetooth/mgmt.c:8546)
   hci_sock_sendmsg (net/bluetooth/hci_sock.c:1719)
   sock_write_iter (net/socket.c:1241)
   vfs_write (fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  ...
  Freed by task 52:
  ...
  Oops: general protection fault, probably for non-canonical address
  RIP: 0010:read_adv_features (net/bluetooth/mgmt.c:8548)

Hold hdev->lock around the traversal. Both callers run on the worker
without hdev->lock, so this cannot deadlock.

Fixes: c249ea9b4309 ("Bluetooth: Move Adv Instance timer to hci_sync")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bluetooth/hci_sync.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3be8c3581c6c..6b566c67ee98 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -487,6 +487,8 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 	int err;
 	u8 rem_inst;
 
+	hci_dev_lock(hdev);
+
 	/* Cancel any timeout concerning the removed instance(s). */
 	if (!instance || hdev->cur_adv_instance == instance)
 		cancel_adv_timeout(hdev);
@@ -525,6 +527,8 @@ int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 		}
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
-- 
2.43.0

