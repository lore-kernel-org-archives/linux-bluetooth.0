Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB4374745;
	Mon, 19 Oct 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397852; cv=none; b=qiKGyw5+tFMAihn9D1xLH6/oYxyBA98xzkSFOzvGNSHzQBlZ70CCt3BWv9uuk74wRRQ0bHcaLPYvyYdVEDgMwU1Z0QamZpYldtb4UAmX9F3HRI7ZW+l8f/58+3jZqLltNGTtoh5ApIiorgs76OuHQsfUmXEuIM/QoU4iD0Yd3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397852; c=relaxed/simple;
	bh=xuzFr8H0l65biLRbODrcpmEfaFgxjGfnrwVQEH3nVfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3HOawJWqi+7V5oDMu4JtY58zpPSQJLrpjUJZu+qcxpjsJA+5QkXFpjO3CZOJ6qCFbCvClIBbt0J4yFzIi3g5KQLgtF2zF8of6lLiRRvecwHwMCNoNRZyxrdJa3UC/rfORib0zLSyqomgLRXgLrrAP0caO0naHJu8TGZTVqDxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kv9E1Ojb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kv9E1Ojb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IJ
	h4AcrNR9Wnea/vnfwOplN6A1wOIWko11KLp9H/mlg=; b=kv9E1OjbBZ8CCMDeDI
	53CBtHUix1/zXie4HGeJduBUqTyYebU+609phJgESQwQT86pJIABsFxSV5Qg/IHk
	dWQj28+XLa5kDg7vc3SQTizA8tKuys8E0V6dOpXGMUqY+GGbtCnXcBdSFQ+jF6ks
	WtVZRyevQ4CCZkbW9t92R4qyI=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXH1AJ0tVqiTvpBA--.13775S2;
	Mon, 19 Oct 2026 16:17:13 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize link key before publication
Date: Mon, 19 Oct 2026 16:17:11 +0800
Message-ID: <20261019081711.479294-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH1AJ0tVqiTvpBA--.13775S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18uw1fKrWDXFyfXrWrXwb_yoW8Zw4Dpa
	9xWas3AFW8Gw1rZr1kG3WxWa4jqa4kuF4UGrZ09343Zws8t39Fya1SyF4qk3sxCrZYyFyI
	vF1vvw10qr9rCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uwdb8UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3wnGqmrV0gl06AAA3C

hci_add_link_key() allocates a new link key with kzalloc(), inserts it into
hdev->link_keys with list_add_rcu(), and only then initializes its address,
value, type, and PIN length.  RCU readers such as hci_find_link_key()
and the debugfs link_keys_show() do not take hci_dev_lock, so they can
traverse the new entry during that initialization window and observe
a zero or partially initialized key.

This can be triggered by racing a link-key update with another CPU looking
up or dumping keys.  In particular, userspace can issue
MGMT_OP_LOAD_LINK_KEYS while another process reads the corresponding
debugfs file.

Complete all fields of a newly allocated key before publishing it with
list_add_rcu().  Existing keys remain visible and keep their current
in-place update behavior.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 0378b5977013 ("Bluetooth: Convert link keys list to use RCU")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9063..06313211f48e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1252,7 +1252,6 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 		key = kzalloc_obj(*key);
 		if (!key)
 			return NULL;
-		list_add_rcu(&key->list, &hdev->link_keys);
 	}
 
 	BT_DBG("%s key for %pMR type %u", hdev->name, bdaddr, type);
@@ -1276,6 +1275,9 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 	else
 		key->type = type;
 
+	if (!old_key)
+		list_add_rcu(&key->list, &hdev->link_keys);
+
 	if (persistent)
 		*persistent = hci_persistent_key(hdev, conn, type,
 						 old_key_type);
-- 
2.43.0

