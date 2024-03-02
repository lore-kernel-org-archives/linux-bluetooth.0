Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8A2C683
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399204; cv=pass; b=AphRi3B4qSAbeHjjB+a5iUZChioIP1GCjoIDGzGwERnUau3oPdAE9NwnrBvqz7hmHiDvn3Efi1E+v91ztPKfCeA7xUKeRfUM1r50V5cFAK4xVkXeL4UdmYmJSjQ1x0QLWaZo2SyIKVjtDtI4P9tVEXSluudT6fJAHQk72R97UZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399204; c=relaxed/simple;
	bh=4pkNqiLMkhqOLLrbeBDBHXbaEXWQcxVJEsZwYuGq4Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISfTsaLS4TsxO7kIN4WYMwY9VzJqHHAbDgcR50RaPPWj5aK9+qXn3k14mdER9IdAc4+9cKAdtvjJ+vNfnGkDFOYgMDyaUcT4L8WawzL1G30rthw3Kijne2Wk5r3BFhh0WDjbrX69PqZHl7yhs349oMtT5FD4YG8YqwZ8hKZxzlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Dr4s6fPE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Dr4s6fPE"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnBFM2224zyxR;
	Sat,  2 Mar 2024 19:06:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709399191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EkjfuxVgBnvb5r2537n+vIYXH6IlLYTiCGav7Xq5l44=;
	b=Dr4s6fPEdSn4PDsitv7GZqiqG1V8F4q+wYQUXC5/QoXCZk0PyDQFnsG/NT60eJOjH13mIW
	a9XNJQJAXBZ9uGQdRRI8P24fWa8GWPwKiilnoSwDrJzIwlhfEnwva3iyIp1vt9O17LAYMm
	8nKs45AYiX3Ssw+X8Ee8F/x+oB6Ekf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709399191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EkjfuxVgBnvb5r2537n+vIYXH6IlLYTiCGav7Xq5l44=;
	b=RrAe6QFsmRd+8Ax5bl4aMLCipOgHerHup77zPINthE7GUK+HK8ODW5OVM5qvtPrF/VPv1g
	Qd3T0Vb1KM0rVvqwBrLY9xh18D9ZOYsrDs5CHMh7LdTLE6dsoQmRa6c61suCt6iBLghs2f
	hCy+klJ0ZhWOLrKTOBz9G/HVfKv2Yio=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709399191; a=rsa-sha256; cv=none;
	b=MW6ak0dlDE4dzxrFGzmWAuI0ySmISgorEgNQSPQFtXC/uPim1TK0TL4NsPSXk0ur1Xrgg8
	eZfAzEyqse/xxwYGCWl9orFGuVN/2viOfpB8ZgycVzZg4r31z/XYiCWtlPeXwQIYxnHxSv
	UwPvTrazIEA01jktKZ1mL0aN4M9ISY8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: fix use-after-free in accessing skb after sending it
Date: Sat,  2 Mar 2024 19:06:23 +0200
Message-ID: <90576ca2ad6b1c3e24c585c734cde44bbcb388bf.1709399114.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_send_cmd_sync first sends skb and then tries to clone it.  However,
the driver may have already freed the skb at that point.

Fix by cloning the sent_cmd cloned just above, instead of the original.

Log:
================================================================
BUG: KASAN: slab-use-after-free in __copy_skb_header+0x1a/0x240
...
Call Trace: ..
 __skb_clone+0x59/0x2c0
 hci_cmd_work+0x3b3/0x3d0 [bluetooth]
 process_one_work+0x459/0x900
...
Allocated by task 129: ...
 __alloc_skb+0x1ae/0x220
 __hci_cmd_sync_sk+0x44c/0x7a0 [bluetooth]
 __hci_cmd_sync_status+0x24/0xb0 [bluetooth]
 set_cig_params_sync+0x778/0x7d0 [bluetooth]
...
Freed by task 0: ...
 kmem_cache_free+0x157/0x3c0
 __usb_hcd_giveback_urb+0x11e/0x1e0
 usb_giveback_urb_bh+0x1ad/0x2a0
 tasklet_action_common.isra.0+0x259/0x4a0
 __do_softirq+0x15b/0x5a7
================================================================

Fixes: ea5391e7b256 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6ca4c0df9f9c..df3aa41e376d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4217,7 +4217,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (hci_req_status_pend(hdev) &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
-		hdev->req_skb = skb_clone(skb, GFP_KERNEL);
+		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
 
 	atomic_dec(&hdev->cmd_cnt);
-- 
2.44.0

