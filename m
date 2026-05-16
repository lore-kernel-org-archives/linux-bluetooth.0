Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDC3D34B3
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930104; cv=pass; b=edTXDQI5Lak45mGFCjddellmHSHhk8PvlfYFlmv1hsP/oxIfbrKxfOXOZogYyMuC7hKqYJbs3yiJveRtV8GXbLcmA8ApEy4aN2PYlfOH6zQYqEav1fidby39pTNIsEb33GCbGXpz0PV9p1YKt7kEhJvS3/efRs3WAmadG1IT4ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930104; c=relaxed/simple;
	bh=31qOIp7NiCUq5KrXYInky5eefaE25D9HzjbRjn0fB0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXV6jkvhHQCXkyH+A0fRwcgRWUvMm5cToSRk6aAajZj+Egem3IBUphIkiDqQf7WP12gE5yKYcCHqPASwy1T6KkY4H0ZlfBKaOHqnhe1GTdvYHhquSEOyZVaFQ1AoqJDoFKRAwU8k3kKzPvucTitKzMP54arRlOIJ7zaKPCDNpVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DpttR1Gr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DpttR1Gr"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL66ySqzyck;
	Sat, 16 May 2026 14:14:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIwOMKP4zakXT0AEi1XGiiXd5Pdk2RpfKOm6d3J9Yz4=;
	b=DpttR1Gr2GrDYvzJa9iUAPFWv/kwDb1DUhzhSr89wLg8r40D6SWNP6iMQ/ZhQDcbAw+YOm
	b/7WJjOX/y51y1tff4sJLT1yTxZ+EIugwYvpRBHWfcbAF+Olvxtyg+PCS5m4k3mhRhhtzs
	tatnJplUxTtromv8JIDHzhGyiy5sD+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIwOMKP4zakXT0AEi1XGiiXd5Pdk2RpfKOm6d3J9Yz4=;
	b=faLIXpc02F7JBwi56rvnq3TuvPt/+1iOfftr666a7mTW67n+3IKniIxl5mYabgXTnxqCWs
	r9q/U5ivHGEsEPhVjnTpWzfiXzwXj7XlY6Y0L0Jot3mtY4IeL/u9Sk+GvLsaSvG/TYBwzh
	Eb2fJW40JK7LSP2IppwKfgpKV84/vIs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930095;
	b=exGaA7JQaOLbs4bdlKzobUjD4Pm2FO4JGi3ck2JwoLvRx8AVpDoQAt6itnsJ+Nck1P58zu
	cqYMHrY0Urp/7HC9sY4E0QAc/ZohdUmb0Husuz/ucJQChTPos9Knc6/wOeRNMCyA9MaauO
	yEohzjRojW/vT4EuncDIs5p4r9URqS0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 2/5] Bluetooth: hci_core: Add minimal context analysis annotations
Date: Sat, 16 May 2026 14:14:34 +0300
Message-ID: <b3ac1e9212d7dac1c9b1e0421188a544a8470a85.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
References: <cover.1778930064.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal compiler context analysis annotations, required for
compilation to pass.

compiler-context-analysis.h doesn't have tools to deal with the
conditional SRCU locking on return value used here, so just disable the
analysis in places.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c46c1236ebfa..fa87cb0bcf7b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -65,6 +65,7 @@ static DEFINE_IDA(hci_index_ida);
 /* Get HCI device by index.
  * Device is held on return. */
 static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -92,11 +93,13 @@ struct hci_dev *hci_dev_get(int index)
 }
 
 static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+	__context_unsafe(/* conditional locking vs return */)
 {
 	return __hci_dev_get(index, srcu_index);
 }
 
 static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+	__context_unsafe(/* conditional locking vs return */)
 {
 	srcu_read_unlock(&hdev->srcu, srcu_index);
 	hci_dev_put(hdev);
-- 
2.54.0

