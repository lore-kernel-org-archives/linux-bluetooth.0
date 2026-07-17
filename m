Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E91E5B68;
	Fri, 17 Jul 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302403; cv=none; b=tRaeKbAkS+T/S3XJ7bWIbD9OJjiZBTk0Gruiryl9wUSC4nAdgKq95ppKxff0gDhRD5BeiUr89OEqEpzyBDlceYBnQmlK27x8uqDbFXju7/e2uqJQiH13OVEHBg/sWyqccGgr4Icy6yPAteDwRbld9kRDuXVqhkW611v5NVrtMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302403; c=relaxed/simple;
	bh=BnNLpmMd3CKVj/T8vqaDZyJr0y7O34aGDbgeFXEApTg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qmNQacw0qvIV2npFRoCV8/OhiWQImAzu4S/1iERCutL195U0cqzGK5O2FP01ek2KRS3Nljf2A2dpXmVaWiBD1J9zP/9LMbgiGot6IYdEM0FrM6qG/bhJe7Av1i/tAeClZX3SPcf7gdEdgeS3cu2PYO1whAFVo1shQ/JAMwvV3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YXprS1Hk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YXprS1Hk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1l
	QV1rDJRR3zXGK07I/WZjsIENvlUZw1bYoGP6w19nE=; b=YXprS1Hktxtb9Tt8Yc
	M153qxrnXWMpMaVYwiihCzEoPPB+I9EM8MXW6VPxldWbkhLGuWxAB70NSBTLyUwZ
	+79SM/JG3KAENE8YJeh6Uiu/79tvt8MfznrzZ0scYysZ+inlQYcX8Ze3lufirAKB
	0BEJQcqzxUMVALhS7TpWqUitw=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnJ_4dS1pqGlvuIA--.12483S2;
	Fri, 17 Jul 2026 23:32:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jiale Yao <yaojiale02@163.com>,
	Tim Bird <tim.bird@sony.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HIDP: add missing length check for incoming frames
Date: Fri, 17 Jul 2026 23:32:37 +0800
Message-Id: <20260717153238.2002330-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnJ_4dS1pqGlvuIA--.12483S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZryfAFWUGFW5Cr43ur4DJwb_yoW8JF1xpr
	nrGFs0krWUWr4jya1kJay8Zry3KFyv9w1SgFyvq34rJry5Aw4UJan7Gr4agwsxZrZ5Aa1j
	kF40vFsxGrWvvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi_Ma8UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR4LRWpaSx7uMwAA3l

In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
read without verifying that skb->len >= 1.  A zero-length L2CAP PDU
delivered via the HIDP control or interrupt channel causes an
out-of-bounds read.

Add pskb_may_pull(skb, 1) guards before both reads, matching the fix
in commit 6770d3a8acdf ("Bluetooth: bnep: reject short frames before
parsing") which addressed the same class of bug in BNEP.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/hidp/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0e24c5e2955e..6c7da8aca732 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -565,6 +565,8 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
+	if (!pskb_may_pull(skb, 1))
+		return;
 	hdr = skb->data[0];
 	skb_pull(skb, 1);
 
@@ -601,6 +603,8 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
+	if (!pskb_may_pull(skb, 1))
+		return;
 	hdr = skb->data[0];
 	skb_pull(skb, 1);
 
-- 
2.34.1

