Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759282;
	b=YM+uJLnvqr2HGUJ9PQogWB3STTKjIjCdmk48ZH9Y7Zx5f2sc5ij0H+8Wwh3O7Q/a1xN3
	 dmA3k+lco0xKig25x9R+rnLUuYeIy3xna7y07G6LyDO3DjdfGt4XlAy6jvAQiv7aDsQH2
	 wphQQx2dT1P4tXSVqnGL7JoYTRJMuMrEBiM0KJanzDzruMfPlhkCMcJwIxLzBU7jvuhos
	 PJnpJmUQjBkdFm8TD3HspqaVVkldTrCvzAHVnPlC+fcrvoxxpii15CRpM0q4AP//pR1Yl
	 NYLBW3OqX7mDj/Xk1SwGbxEu65HZIje6A1bDsJsmmq47voH+TgtRWEC94MPiFefiv5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759282;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Z3sVqZN0IDd2pBpezpf2Et11WrJLuLs2HjxGR8/zoHk=;
	b=ZNCSaMEDRs9tB4HN3vZQ6iizdvZ4Z5VNtjZ3835EpwCPbQBJuN9neDt5D+5aIuR55r9o
	 C8IN0Ss2z9qf8x3XLDG/azKhvCNsCynPI5N8TeL3rrKhEi7YLTZ/S7EA0zl/zbRLpx7zU
	 xQCgLH6YQKuiNohcGlv8hUSvQpcLbWsQ6UNwSyd2lfD8c0PEGsIbgP7qWVV/VyAdLOA8P
	 9quYa3RlYid8aEtOaDgeD4QMza/r8cuRW73kpjAmijEEkyEOSZbpcEwn2+x+5KtS8j9z+
	 Xluen2P3syyrncB6Wk3HOmCQdgS6x4620P+04DjWkH8GQC3cVBC+XigbjxyjZixpZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30949606A328
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30949606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnVf8umOpqi5s+AA--.27324S2;
	Wed, 04 Nov 2026 10:27:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: delete the new SCO link if linking it fails
Date: Wed,  4 Nov 2026 02:28:07 +0000
Message-Id: <20261104022807.1484114-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnVf8umOpqi5s+AA--.27324S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fuw1xCr1kZry3JFyDAwb_yoW8CrWxpa
	yYgasxZFZ7tr13WFn2ka1kCFZ0vrn7ZFy2krn5Zr4rAwsIqrWFvw4UCF10gr15CrWkJF17
	JF4jqrW29FyDCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUyGYpUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQBA2rqY4LLHAAAs2

hci_connect_sco() adds a fresh SCO/eSCO connection with
hci_conn_add_unset(), which leaves its hold counter at zero and takes a
reference on the controller. If hci_conn_link() then fails, for example
because the link cannot be allocated, the error path calls
hci_conn_drop() on a connection nobody holds. The counter goes below
zero, the delayed deletion work is never armed, and the connection stays
in the hash with its controller reference until the controller is
unregistered.

Use hci_conn_del() for a connection created here, as the other
hci_conn_add_unset() error paths do, and keep the drop for a connection
that was found in the hash.

Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/bluetooth/hci_conn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29da3fe2b953..660eaf5adf96 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1896,6 +1896,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 	struct hci_link *link;
+	bool new_sco = false;
 
 	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING,
 			      CONN_REASON_SCO_CONNECT, timeout);
@@ -1909,12 +1910,19 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			hci_conn_drop(acl);
 			return sco;
 		}
+
+		new_sco = true;
 	}
 
 	link = hci_conn_link(acl, sco);
 	if (!link) {
 		hci_conn_drop(acl);
-		hci_conn_drop(sco);
+
+		if (new_sco)
+			hci_conn_del(sco);
+		else
+			hci_conn_drop(sco);
+
 		return ERR_PTR(-ENOLINK);
 	}
 
-- 
2.34.1

