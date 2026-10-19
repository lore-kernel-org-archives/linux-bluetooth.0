Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10651483823;
	Mon, 19 Oct 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407407; cv=none; b=Xf9AWNr9XTIN5yCAA1SmHjIuocQkX5vICoP5FtAtWXo5xG26ocwFxBfLSuVI33CmqaN8/TLmBgcDP2FAr9jWRFyCo2jhGLJTRU3JaaP7wanVcgj4Oflngx03kd2pgiIhrQ565NfQyeEIOixG5G6rUR7mW6hC48TdLIVqiCH6cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407407; c=relaxed/simple;
	bh=1PM13OG7boptdV27S1KX5P/taAqG86KVUt56BO4CQ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AL3VjFiNLq9eZ/ikgxotWKL9J2zmB6apMv1l4Ll1wZ/LD7K1vUek0r+Xha6bbNJdiD7oU5YYLLACCbYDNEtXvGq4ZSuPBfSNePPOn7Xy3M7pH6E7HCkdSj36TgDHps7cG8ljJafC5TYEMQSfFxC8+a99gIDO/CSlZZnDtJeGM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BVCZ4Hz4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BVCZ4Hz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6a
	iuWIc4kKOUC22IXyBQ8F2KwrWIr6kv4uHizyQhXlw=; b=BVCZ4Hz4pvHwTCTGvL
	cL/Ikvy3zoeb8Xox5THHY5aum0YP1zIxlp/rZVLeZ4qMpXmF5fFSPMnr2T2f6QSN
	CfNYdq8Az7m661BXtrv+AD685ovC+xYMgv4b4eRQy7bjmB6gNnsyxfsS681uLnDh
	+1e7cG4kZHnoAXLm0UwVoK1hw=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXX3Va99VqTTXJBA--.63914S2;
	Mon, 19 Oct 2026 18:56:26 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize LTK before publication
Date: Mon, 19 Oct 2026 18:56:24 +0800
Message-ID: <20261019105624.489859-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX3Va99VqTTXJBA--.63914S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zrykur1xur4DAr13Gr4DArb_yoW8Zr1rpa
	9xuas3ZFWqqw4UAr48Aa1xua4rJw4kur17Gr9093y3Zwn5tws29w4Yyr4qg3W5urZ0y3WY
	qF40v3yIgr1qywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRx9N3UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4BokCGrV91ofRwAA3c

hci_add_ltk() publishes a newly allocated LTK on hdev->long_term_keys
before initializing its address, type, value, authentication state,
encryption size, EDIV, and random value.  hci_find_ltk() and the debugfs
long_term_keys_show() traverse this list under RCU and can therefore see
a zero or partially initialized key before those stores complete.

The race is reachable by racing an LTK addition with another CPU looking
up or dumping long-term keys.  For example, userspace can issue
MGMT_OP_LOAD_LONG_TERM_KEYS while another process reads the corresponding
debugfs file.

Initialize all fields of a new LTK before list_add_rcu() makes it visible
to RCU readers.  Existing LTKs remain published and continue to be updated
in place.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 970d0f1b2803 ("Bluetooth: Convert LTK list to RCU")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9063..9500da51af85 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1297,7 +1297,6 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		key = kzalloc_obj(*key);
 		if (!key)
 			return NULL;
-		list_add_rcu(&key->list, &hdev->long_term_keys);
 	}
 
 	bacpy(&key->bdaddr, bdaddr);
@@ -1309,6 +1308,9 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	key->enc_size = enc_size;
 	key->type = type;
 
+	if (!old_key)
+		list_add_rcu(&key->list, &hdev->long_term_keys);
+
 	return key;
 }
 
-- 
2.43.0

