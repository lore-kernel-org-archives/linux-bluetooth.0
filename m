Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CD17597;
	Mon, 29 Sep 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123854; cv=none; b=URdpdvb8GSOouaJW5H0VVNQhBp2NkiPYl7RJSk8H20LrGf1L5y2aQpHqAAd/3AmsmffLDAFLzB/dByvywjiAto6vLcKOULuza3g13ty+rEFpKxS6ZuuFjcHvYXr0kacRG+wg4RT4lzFikBu6oi7BNLFMdxI/zunCfRJH6Br7OZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123854; c=relaxed/simple;
	bh=q042932vr0hC0c5LLq/gdKyp7y3KYG+RrNctf606VUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvRtbYomkTr6N9eKr2wUjYdraZqimX/NgJ0le14WsXKM+lAvjy8zYO9aPNRcPkjQFcAaU5inwR9pBpqJhBHyz2BRG2tRjoo3rQC3ZWcgJ4nHjwLZ3SpApbIe/LghcvvQ3OeXZv9cuTteVoSuIE3pj4LPxGHgqUmjXgHW3J0ebqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EfB4bdeV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EfB4bdeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wS
	oZCNYAX2ePpPhlyspAXsVo1kSo/yX1dG8TSjUatxk=; b=EfB4bdeVjW7MAiOjkw
	+TwUd28gNYptay3VaigdwfxX1r62/PnbLO3qBe394LEUTItfFM43xU0MU5ICsw0n
	XpymiYkRWF5jUG7W+BmVjHq/K+Pl42zjzw8eZINT6o6/bs/bcRjyb24zvm+gxPTh
	qguH4EdfoMqRndbgRN4LZ8C/E=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_2RxGdpoA8B0Aw--.45924S2;
	Mon, 29 Sep 2025 13:30:26 +0800 (CST)
From: Cen Zhang <zzzccc427@163.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	pav@iki.fi
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Cen Zhang <zzzccc427@163.com>
Subject: [PATCH v2] Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once
Date: Mon, 29 Sep 2025 05:30:17 +0000
Message-ID: <20250929053017.148216-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_2RxGdpoA8B0Aw--.45924S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF45WryrKryDCFWUXFWDArb_yoW8Gw1Dpa
	43WFy5Zr4rXr43XrykAa1fZFW8uF1Igr9rCa1DWryfJ3yaqr1xtw1UtryFqF9Y9rWDuF45
	ZF4qqFy3C3W5Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFeHkUUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/xtbBYwnXhGjaFFZXiwABsU

hci_cmd_sync_dequeue_once() does lookup and then cancel
the entry under two separate lock sections. Meanwhile,
hci_cmd_sync_work() can also delete the same entry,
leading to double list_del() and "UAF".

Fix this by holding cmd_sync_work_lock across both
lookup and cancel, so that the entry cannot be removed
concurrently.

Reported-by: Cen Zhang <zzzccc427@163.com>
Signed-off-by: Cen Zhang <zzzccc427@163.com>

---
v2:
 - Add missing unlock when entry == NULL (suggested by Pauli Virtanen).
---
 net/bluetooth/hci_sync.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b6f888d83..23a7fbec3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -862,12 +862,15 @@ bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
 			       void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
-
-	entry = hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
-	if (!entry)
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	entry = _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	if (!entry){
+		mutex_unlock(&hdev->cmd_sync_work_lock);
 		return false;
+	}
 
-	hci_cmd_sync_cancel_entry(hdev, entry);
+	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
 
 	return true;
 }
-- 
2.43.0

