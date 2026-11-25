Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599196;
	b=CcRKi/AsutlpMGghZRucZuTvR1J+NUJqWdeGU6MNK8eKeyorJ2nvAcgguyn8NXyFOkHE
	 N3TIllbjZ8Q3hFuFAMCqUwp8juuI/nhcttgVOhlpNCNJRiU6EiMxPtZM5fHKQziGxvsme
	 hbDAe0+d8Yrs/d1a0mus0r3jq4cewlErY+ufJ0X0GOTBMN0rMDPURVwdleMB5ecBJzs7j
	 X6r8QfUR19sjc1hOVM40DzB3KE3c2XAp55cyp1n66zrp4GUA9wkm5NIkOEHST979Fc225
	 AyRRg9NdmxrMGUtsTR7oqXZfBf3hKy5y4S9S6k8DdJTRWmEwdifa4zHHFFqOOJ1y4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
	b=XBYon1GYl9ezuF7p0yLCCUp3oir8UxCnfXWiOwiHWdhyCfplyovNtBxRCtxpi2iF5FDU
	 95td8Lrpg+GdbcK9q0dpwNQfKHMs1st0sxBvj0rukGG92+bjvzffGhvN57/8veCwDfI9D
	 qAlSJo2De7UKq3wCjlDXmc5WyRzS3+VBf8dRkinkaoYgvPFmcY+vC6fkQfv0bDv5LfgAy
	 rB0IZSbvRkt4Qb3v3MQTTV2f4Rmgpyn7gs9eLqnsjV0939/51rgU1ZSrvX/kpwoS/tVR2
	 Q4R66H5RBKGRPLU8cdAVUOSjrEW9AAy94sRNjSWQ/cRc2+E6imlqIXRpfF+G5IYa7Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t+jv/z5h";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C2606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3C2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+jv/z5h
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3803468f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599194; x=1796203994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
        b=t+jv/z5hjGeEZm/mbVnKGhsbkhkJJWeN8VnCFyULn7VO4KiVYiknQKEAtQ8MsVmYf8
         LKvx/zvmxcc21se1l+Wa9RJLJFBNW117WZ4wfoKsn5OH5xoVeJKZs5TC5ThbYb9vRwUe
         rBV8Njv/LcIDpW/kBFSl60hriN9wJCmov81Eejzr8mVtlDL4I8n9hnJECpQ6dVk7Gu68
         doyBYGFzRrL4NCp/QaVBrtM75SP7fZo+GWRCWjr66yv6meracAZe3ebRVg95IqQru9tI
         GNL0uj/OG+xDvfjUdPt6eXAOjG0Q9eNUGVizx+bnpv/A67Ch+WOYm8Ocm6jd++GL3hl4
         eK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599194; x=1796203994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
        b=GIdVgSFyMQd0t3SMIvGUt74C6yMiEe6vGEqAZpuIjudpPk8hAQWX3eTZw3BENexloN
         WG0Idn68w6oqHb0a60VECDMWb/F2cilWQeTmOVJ81krq7n3LbWMQza/CtAKwG0BMXMLi
         Qe609SsROC/hJNi5PJZXc4LsNtcsRsS+LDvgCJttNYjxP/JwC2HS5NHFrExaaRhWXTNG
         GKJZtiEUukNNQSwpHy5KcJMUteHSSIqMqMNZ/iPyn9mlC7JMRwM6dbiWO4IIaGHpbAV8
         AsmKKsDpsliIRQrjU+dIguYkepXDaPWaI4XmLeY8sBHlqgnzfbXaFrHqm7Yue+57VzrU
         uGpA==
X-Forwarded-Encrypted: i=1; AL+hErE3Y/X6LjzQoNIEe9m5tXbj5LYelPbvlHgrAcrr0w0bHpUWf5v0qbIRJoAF7L4EZ6hOkyMI4PaHzhKQ57eaQCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hMfhBa6uPqo2sEdEAj5/6NleGKcxz40JikukfJaLNlGSAQO+p
	+tgklbxvJ7FsCoAojWz57dr6WKFBhKDgBJGcwCp4qgppQ6LB9s0zaxMx
X-Gm-Gg: AZFdTZeBto+GWDPe9m3LoZdWCNQPOUoZjBpcwvx5UveWGH/RL1Se+sjmV9TaoRtgslc
	aCOCp/XOeLZo+sLz+Oad3u4Cd3QnRCCYlmiHSTI4VwmhhU6wdiGUHObC3zBRBd7FtNXTNQGGt7N
	jzUaxB9PwFIqc8/U5R2wpqA60mJ0fpbHHidsMTnaK7hppi0Sf7/vO1E4N6IbDOYboffOuOG1ufn
	xxQOw9YpbYkxcYQwtCFIObs6SwN3rDGCMQwJlAq/Yz0PYOx6bVuBrcsf7UuYlyjguPukpg3d696
	fgKN6KbEJgYWRfUKFWRit6lD4RLRM6BqOjx1p/TPlVV81424vo72vfkq5wd3aaJjhc4eEma33WA
	A5G2ZZcmbteDYL3CBNPtvba3YBYUTlJvq+zmSUo2anI+dZ4EnAQGrdQ+C4uYIouQ3aCJzoBY67p
	2p846LukktE4S35k5fLXnIakIsVN84gugKyqPiveQ1fNjIO1TrDOrjkrBwxvmJuH/IH7D/YjMF7
	Y8X/X6k4ArovoOSLb6zhJ+hWFjS8kR5kBKs6A7DdUOIXf6wzeawUxb/LNWzuDPGT4hrQw9Ra4gh
	lf7/bNNiAMvg1ObeCECe
X-Received: by 2002:a05:6000:491d:b0:4ab:f5b0:a7fa with SMTP id ffacd0b85a97d-4b598a60967mr13697952f8f.33.1795599194330;
        Wed, 25 Nov 2026 01:33:14 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm32077607f8f.36.2026.11.25.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:33:13 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:33:01 +0700
Message-ID: <20261125093302.225552-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 59437cbb5781227567dec226aaa88c66a09ccc5a upstream.

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Petr: add Fixes tag ]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 60b1dd16ab0d..0ebfab2c26cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4819,18 +4819,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -4848,6 +4852,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0

