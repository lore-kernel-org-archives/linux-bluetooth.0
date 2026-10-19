Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C64E3252;
	Mon, 19 Oct 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408594; cv=none; b=IgYB08cl3Ld7QKji7WWAN6udZZ3WR3OZoimaoZ4zHh4Mva/2D7geFYEe9O9CFnF7mKE7IV5E+j7F3DxUR9/pjrQrKE+ir3UWYvs8NIgIv5SdktGkMJwLhSLTtUuyvED7cbPBnwXVZG8o6Cd3Dv637TJkSY66U6Q02Xkdye6bzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408594; c=relaxed/simple;
	bh=8sS/vaJsVJSewGKtcemUEEWScFjW/75ASQ2eygZZLGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVKPcVdV3IOHYWCQnUKOl1AmBii65/O7cUWTZwpcinIgPql/TnhHGnkJtr89JdHb94T1bYZKjwUiDy4vsZ9q796fKjgc5I+DPEH6Yu55gPhMQHuMMFmfuF2L6Ab4O1gAJb3JkNxvcT63WCK9ehNj+x8QPrldSwNmoiVaOK6an2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BnPfs31U; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BnPfs31U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=el
	ecKPnkoC6KLvYRG3csl1M9fv8lhMaW+KJrWAlcY08=; b=BnPfs31U2NR8sVfKH3
	vBzkaPOug8/yiPReT6GoF7/OHxRbFqLWtf5OWJu2ynFPpvE2rboltJ+icKO8+xqp
	Ir44IPqkLtmLPHAbUUbYEawY487LWQW12xODDs/iGCa2+vtBEMLhlyqPxx2e3SqI
	qH+lM4oUj1Ykbb0ayEiEm4EFM=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHAXX8+9Vqx8LGAg--.64238S2;
	Mon, 19 Oct 2026 19:16:13 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize IRK before publication
Date: Mon, 19 Oct 2026 19:16:11 +0800
Message-ID: <20261019111611.491779-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHAXX8+9Vqx8LGAg--.64238S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkKryDJry7Cw15uF4rXwb_yoW8Kry8pa
	9xZ3Z3ury8KF15Ar1UKa1xu3Wrt3yvvFyUJ3yq93yS9Fn0q3Wvyw43CrWUta4furW8KFn5
	XF4FvryvgrnrurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRx9N3UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3x1OMmrV+-1qlAAA35

hci_add_irk() initializes the identity address and address type of a newly
allocated IRK, publishes it on hdev->identity_resolving_keys, and only then
initializes its value and RPA.  RCU readers such as hci_find_irk_by_rpa()
and the debugfs identity_resolving_keys_show() can traverse the new entry
during that window and see a zero or partially initialized IRK.

The race is reachable by racing an IRK addition with another CPU resolving
or dumping IRKs.  In particular, userspace can issue MGMT_OP_LOAD_IRKS
while another process reads the corresponding debugfs file or triggers RPA
resolution.

Initialize the IRK value and RPA before publishing a newly allocated IRK.
Existing IRKs remain published and continue to be updated in place.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: adae20cb2d20 ("Bluetooth: Convert IRK list to RCU")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/bluetooth/hci_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9063..6d6d4eb1268a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1315,9 +1315,10 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa)
 {
-	struct smp_irk *irk;
+	struct smp_irk *irk, *old_irk;
 
-	irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
+	old_irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
+	irk = old_irk;
 	if (!irk) {
 		irk = kzalloc_obj(*irk);
 		if (!irk)
@@ -1326,12 +1327,14 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		bacpy(&irk->bdaddr, bdaddr);
 		irk->addr_type = addr_type;
 
-		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
 	}
 
 	memcpy(irk->val, val, 16);
 	bacpy(&irk->rpa, rpa);
 
+	if (!old_irk)
+		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
+
 	return irk;
 }
 
-- 
2.43.0

