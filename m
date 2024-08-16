Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130C17BEB5;
	Fri, 16 Aug 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806932; cv=none; b=V5ChCAUjzeTRm6gYuOBqp/8r2xYolOQgQ5QMxFvoggbDKrfHpmorGIf+Zm9vPQKvdrn+b7xVZEaJihuUEm75l8TRloQiWNC5OsGTHJUxohuZPOs8dwtUNE4H1mwFMYZfocWC1dnkos9I0wPCQalRZFQZVS1BfsXGqPB+e05zaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806932; c=relaxed/simple;
	bh=X/NC8Fn35SuJ+/Zgd8nVnQApdeQjzg11aXOWQ5rYbC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SlHSxJnmgb+yVyDt7l1iRR1rhFaAU+mskTinExRH6e0eJALMFE0HnZ6eJ6JDpImpFmx/UfFbO74QeGOu7Zkia1u/iJdGCFjPSe05VSCvf074Nmz2TW1qldcZPmoiSPnyiBdAFMaUV7XufRDybTsneNGXIOYxPhAdcFqdT53/vJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 777F4202D02;
	Fri, 16 Aug 2024 13:15:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D7DA202D07;
	Fri, 16 Aug 2024 13:15:29 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 88B1A181D0FF;
	Fri, 16 Aug 2024 19:15:27 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v2 1/2] Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h
Date: Fri, 16 Aug 2024 16:43:08 +0530
Message-Id: <20240816111309.287515-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds ISO packet support in h4_recv.h, which was created before ISO
packet handling was added to hci_h4.c and hci_uart.c

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/h4_recv.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
index 4f2c89742245..647d37ca4cdd 100644
--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -38,6 +38,13 @@ struct h4_recv_pkt {
 	.lsize = 1, \
 	.maxlen = HCI_MAX_EVENT_SIZE
 
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE
+
 static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
 					  struct sk_buff *skb,
 					  const unsigned char *buffer,
-- 
2.34.1

