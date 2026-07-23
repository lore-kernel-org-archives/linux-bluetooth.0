Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65135E1A8;
	Thu, 23 Jul 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789351; cv=none; b=T+rs8zkGukZU2oFqs9txxCrk04lW1oLOoIu+QnAW2Ff49p2uBE+ke1nC+NFVaMFQspnJaMVAiP5iMIPcUsPAJPv/tX722/+THnQZTCY51JWv+rBTQPp3/7ULLEGyTZ9SfGeLCobjtq2dRs3+rEKSBnDKed7JKyXA7FHPOZnQCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789351; c=relaxed/simple;
	bh=0JvOFhfoVQkkNvOTjgHbnkkriS7MFY1HDVb4yjPrPYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfE540YDVkwPSYSW4OZgiOOPPZiOSGekc8qwPyIwrAWlnj2XH5dbKhDeFe4f12E1Hv4mp5qd1J870TnBvmucBzYPCzxJ6weKz8Opq/tNQ4rjH7N8eGSv9QsJTMkopvD9zQxzOeoWQSX6T12xHgnm/OLEmaxTtorQQDudihBALlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QZ1PwJ9i; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QZ1PwJ9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bI
	IP3Fz2q6egkvabG/87bmB5y1j8kA6VnVOadYgQlq8=; b=QZ1PwJ9i//zCQiyJvx
	AvqeIrou9v2egTM/m7UtEKAc5c8YohXFolPkNj4VMJ7xiE6OI103cEuS7GYqR4lK
	sdqPMZGz1nRzj2twaapOsEWHwx2pHERuxoWmsXQUWDDpfvm02pixYjo3dqLArPFE
	GPrQS1u6TmuMYpBUldogRRNRE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD370VOuWFqnUGkKw--.47468S2;
	Thu, 23 Jul 2026 14:48:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
Date: Thu, 23 Jul 2026 14:48:45 +0800
Message-Id: <20260723064845.2298792-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD370VOuWFqnUGkKw--.47468S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4UKF13tFykKr4UWFW8tFb_yoW8Wr1kp3
	4kKFZ3CFWDG395Z3Wvy3Z7Jw4UArnFqF1xKrWvkr1rA343Jr47Aw4UC34jvr4j9rs3tFW2
	v3WYvrnxKFyDCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRh0eDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhB1r2phuVDUBgAA30

l2cap_le_connect_rsp() obtains a channel via
__l2cap_get_chan_by_ident() but neither holds a reference nor uses
l2cap_chan_hold_unless_zero() before locking and operating on it.
A concurrent l2cap_chan_del() triggered by a remote disconnect can
free the channel between the lookup and l2cap_chan_lock(), causing
a use-after-free.

The BR/EDR counterpart l2cap_connect_rsp() and the sibling handler
l2cap_le_command_rej() already use l2cap_chan_hold_unless_zero()
to safely hold a reference, but l2cap_le_connect_rsp() was left
unprotected.

Fix by adding l2cap_chan_hold_unless_zero() after the ident lookup
and l2cap_chan_put() on the exit path, consistent with other L2CAP
response handlers.

Fixes: f1496dee9cbd ("Bluetooth: Add initial code for LE L2CAP Connect Request")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 538ae9aa3479..1156aba4e83c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4820,6 +4820,10 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return -EBADSLT;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		return -EBADSLT;
+
 	err = 0;
 
 	l2cap_chan_lock(chan);
@@ -4865,6 +4869,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	}
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.34.1

