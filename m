Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D1374733
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912813; cv=none; b=bOO3KZh0XqYUhxdtYwrSPPDURZVO99hOAT2eVSkIh2ko7kHKugNLWp1bFbcAa9hba2CYKB5mrs+MZ91FWpc9Dp2EWXm/Es8UdUX1/ta1FH5cZQ3+56cIVetjyl35boXTolxsUszOjxy54BWeJgqNhJJmKXT7QCl7nGp/y26YgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912813; c=relaxed/simple;
	bh=3RDVZYhRcz8vBTRDCPncQTpOYVliYvqxmCzYiUzuAHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teyK2AX9iev/4lxc0E+LZYhyQ2e/IEliwLwG+UkjMYpqYXBemc1zwUCScG2HDtLGWqQEBpg6/mDS8iPNPQ9M51giqnM8Qp+DHzE5arRzLraqzHwNQ9Wt2sAOwD/Zlsh5nvGJLKagjHPgCVtYWtvedHxZWhUjXPe36xKQc9zPBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ed1VMAlK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ed1VMAlK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1x
	VBUkXcikCeULZEydVmRymAIEJ4UXQ8/gnfYOxP6QE=; b=ed1VMAlKGRpkKWjmHk
	xaEUh0C3pm3gxXOw9M2epUnhUYldBUxA+w7fK0QHVnDj0cgZND/vCR78aUKCi0mp
	mChu7uHEdw50+9h1odj4A1tPyyfa4IXjG4bgoHdgIXoaFZ8nYNen0DOMAUR0U+/B
	ZcVYEL6jDu9IMf3OvJFhfIf5Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6edwrtpCWKwAA--.11698S2;
	Thu, 19 Mar 2026 17:32:15 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	frederic.danis@collabora.com,
	pav@iki.fi,
	pmenzel@molgen.mpg.de,
	ceggers@arri.de,
	research@johannes-moeller.dev,
	b23@ee.vjti.ac.in,
	surban@surban.net
Cc: linux-bluetooth@vger.kernel.org,
	Zhang Chen <zhangchen01@kylinos.cn>
Subject: [PATCH] Bluetooth: L2CAP: Fix send LE flow credits in ACL link
Date: Thu, 19 Mar 2026 17:32:11 +0800
Message-Id: <20260319093211.2239158-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnq6edwrtpCWKwAA--.11698S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryrWFy7Kw4UJrWkCw4UArb_yoW8Gr48pr
	WDGFn3Ca48Xrs0v3WkGw1xWa1UJr92gF1Y9rWjg398A3s3Jw48Gw4jka4jk3Wq9rWvqFWa
	yF1rtwnxKa4Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULXoxUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC6B8hvWm7wp9rLAAA3j

From: Zhang Chen <zhangchen01@kylinos.cn>

When the L2CAP channel mode is L2CAP_MODE_ERTM/L2CAP_MODE_STREAMING,
l2cap_publish_rx_avail will be called and le flow credits will be sent in
l2cap_chan_rx_avail, even though the link type is ACL.

The logs in question as follows:
> ACL Data RX: Handle 129 flags 0x02 dlen 12
      L2CAP: Unknown (0x16) ident 4 len 4
        40 00 ed 05
< ACL Data TX: Handle 129 flags 0x00 dlen 10
      L2CAP: Command Reject (0x01) ident 4 len 2
        Reason: Command not understood (0x0000)

Bluetooth: Unknown BR/EDR signaling command 0x16
Bluetooth: Wrong link type (-22)

Fixes: ce60b9231b66 ("Bluetooth: compute LE flow credits based on recvbuf space")
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ead51dc0f3f1..d444ec5be88f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6633,7 +6633,7 @@ void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
 
 	chan->rx_avail = rx_avail;
 
-	if (chan->state == BT_CONNECTED)
+	if (chan->state == BT_CONNECTED && chan->conn->hcon->type == LE_LINK)
 		l2cap_chan_le_send_credits(chan);
 }
 
-- 
2.25.1

