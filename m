Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3681E49F
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763212335; cv=pass; b=iWkSml4Hi9WaS0hzJIjC3dUK8NF1BJNmNNhxvkBWSpGRvMqzCUteV7WTWFNa1vqtIgzj4ms7gag/VPae8TvqgRrBkjgz4WSzULX2IX483zoPMa4aRAw/ZLOgtK7hnF9FUSxLk0j2G9K+E/KN/5DB5AJPuLaM1m71TWAIWC7WcnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763212335; c=relaxed/simple;
	bh=de7X1OHKpPDlMIXkbklzQAt1TXMVkHt7NRwLmTqIWgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7WjvP/ifQ8lxdLeSjzUvRMNPNMcuSc/vsf/ySNQnQPKdOtipe8CRBJ4IpEHmyyK0+vfChfgJpMyqWdd1ePui/w6Jiw/yIt61Leb4GuYRb7nA42Or8vTrKaSt9PcqpwULqmtACiTVKKQI6wJ0dFHg+mKvQbcyCdIqrr6r+P3Lk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ksGMGC7X; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ksGMGC7X"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vYR0g98zySs;
	Sat, 15 Nov 2025 15:12:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763212331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HQZp+Upp09W1TSPrLJkB1f6EsPdJSQv1P1/UwJ4U72k=;
	b=ksGMGC7XufJsz6gVnIXa9q9G5KvBP9ArpzP0NfXvOjOOi2OI1WKXPBRUBF5C/6JpT/Uw8k
	jnw4kVfUYfJpz7LhtcRpaHRX1hineXiDC5HmcEdwinkABG9//N7EKlJjVDzyvGm/e3pwKa
	zmvqqprB7aNMwEA65rI551oggCQINDk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763212331;
	b=JeOPqaelktKAS5RSkgh5Xc+7YfjTVMszurJTar4tQjUmj0FvU5beBkrIT/x07LvxbbDtn5
	/fAmWq4xBabcApukB9QuzQoSrPnZdSZxCCwyKwnDg69/GkK6e8J/xJrst4m9ecOwACqX5Y
	xlIAiaNmH5x3HqkPPbI/CHkQURaskTQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763212331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HQZp+Upp09W1TSPrLJkB1f6EsPdJSQv1P1/UwJ4U72k=;
	b=Dcb1KbORnqwtWNaeuCsz2oWs6CmSmIEzdAF1GKB61SmMd5N3Eb4wgZozxAxIM+6d8OIGdL
	Onjm1B+2S5utHWqxgXIpKejnzVbtecnP7jlfHmVGY54hXRRxqIpBnFp34kB6Ypb28rgzt2
	CVNYxx0Hrfnne7TJ2su2LvDAAFxbAbU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_core: fix accessing consumed skb
Date: Sat, 15 Nov 2025 15:11:35 +0200
Message-ID: <8d6e3b719f6dc3922d653795869ed7bcbcf086f7.1763212292.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access to skb after giving it to the driver causes a crash in
hci_cmd_work().

Do all checks before giving skb to the driver.

Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP")
Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=25e9c406cbd26c66c417
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9f686e5903a1..36612b4c098c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4162,16 +4162,20 @@ static void hci_cmd_work(struct work_struct *work)
 
 	/* Send queued commands */
 	if (atomic_read(&hdev->cmd_cnt)) {
+		bool is_nop;
+
 		skb = skb_dequeue(&hdev->cmd_q);
 		if (!skb)
 			return;
 
+		is_nop = (hci_skb_opcode(skb) == HCI_OP_NOP);
+
 		hci_send_cmd_sync(hdev, skb);
 
 		/* Don't trigger cmd_timer in case of HCI_OP_NOP since there is
 		 * no command pending.
 		 */
-		if (hci_skb_opcode(skb) == HCI_OP_NOP)
+		if (is_nop)
 			return;
 
 		rcu_read_lock();
-- 
2.51.1

