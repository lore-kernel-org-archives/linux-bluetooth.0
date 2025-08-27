Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0904246BB2
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269205; cv=none; b=qiZIaOWu7d5Y8+UfvMHVEXivcFmUEdYCmtuZgyGkER4JID3ERFadghfGdet3fGCyDVavCJ0+b5xGT63ROimeP3FvCUjZFKLqt/l/1YEe/yN1+oJdlIafFh56xT1/iM2s2KKEekVqvE4boPQZbIopZBqaYr6cpHP2wmdy5yqmA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269205; c=relaxed/simple;
	bh=3bQUggs1dz2lXC5HEhH3WckpGVBZUfB1XMP6X6RhnGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G99ZBp5MT4Dkv/xuqOyVfTI/e3ub0L1d8gZH9viLWIE5sdJxIWm6GikCccJa9FXgfwDj/+WDC+sbxMlD873XHyqEc4HKMaSetBrbsh0zLSStdOv7nWczCUy3p4Albr7U1annWTbZtO/bCUzdjnEJ49xFjZETHsmo1D2/ITgpBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=D9leVfTY; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="D9leVfTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9rOBB/o71xl0ikIjLsjC7srjUMkDatat+eZgYGtvux4=; t=1756269203; x=1757133203; 
	b=D9leVfTYhD5YypcEJdCo3NGNxOEkJYbBuDFbZE3BMjCeEjUwgWCdTXPUU9YkF1X7GTU7eRj+xBP
	YW4q4ZopHf2KjF3XmE/SHcGO63Z1fvZyc83Vz3oey+IK0b6/fVQVmq+ZCaFOKCCe3XTXVAu/f94uN
	cs1ue/v3Guiw6DCbHuC/u0o7HyTdLQkO4jkdCiguCa1VctjFULNiHkPF8/JPLuFd4SA3bA3LuHEHJ
	kZ7Lip75dJq2Autkgp6q6YinI5YAyzLWfNXZZ+kMQZGsoTkB9F9XOxyf+Hh+mjvL/yxUjeoB7qovo
	NhSjN/gdTdm+iZbXSJ/UgOgUniBPHNYZUj4A==;
Received: from 135-180-5-199.fiber.dynamic.sonic.net ([135.180.5.199]:53481 helo=macbookair.lan)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <jgnieto@cs.stanford.edu>)
	id 1ur7qc-0003X1-AN; Tue, 26 Aug 2025 21:33:23 -0700
From: Javier Nieto <jgnieto@cs.stanford.edu>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Nieto <jgnieto@cs.stanford.edu>
Subject: [PATCH] Bluetooth: hci_h5: implement CRC data integrity
Date: Tue, 26 Aug 2025 21:32:54 -0700
Message-Id: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 255d2abca2c607fc06a55785d004a2f5

The UART-based H5 protocol supports CRC data integrity checks for
reliable packets. The host sets bit 5 in the configuration field of the
CONFIG link control message to indicate that CRC is supported. The
controller sets the same bit in the CONFIG RESPONSE message to indicate
that CRC may be used from then on.

Signed-off-by: Javier Nieto <jgnieto@cs.stanford.edu>
---

Tested on a MangoPi MQ-Pro with a Realtek RTL8723DS Bluetooth controller
using the tip of the bluetooth-next tree.

It would be nice to have this feature available for somewhat more reliable
communication over UART, especially if RTS/CTS is disabled, as this is the
primary benefit of the H5 protocol. Thanks!

---
 drivers/bluetooth/hci_h5.c | 42 ++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d0d4420c1a0f..7faafc62666b 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -7,6 +7,8 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitrev.h>
+#include <linux/crc-ccitt.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
@@ -58,6 +60,7 @@ enum {
 	H5_TX_ACK_REQ,		/* Pending ack to send */
 	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
 	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
+	H5_CRC,			/* Use CRC */
 };
 
 struct h5 {
@@ -141,8 +144,8 @@ static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
 
 static u8 h5_cfg_field(struct h5 *h5)
 {
-	/* Sliding window size (first 3 bits) */
-	return h5->tx_win & 0x07;
+	/* Sliding window size (first 3 bits) and CRC request (fifth bit). */
+	return (h5->tx_win & 0x07) | 0x10;
 }
 
 static void h5_timed_event(struct timer_list *t)
@@ -360,8 +363,10 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 		h5_link_control(hu, conf_rsp, 2);
 		h5_link_control(hu, conf_req, 3);
 	} else if (memcmp(data, conf_rsp, 2) == 0) {
-		if (H5_HDR_LEN(hdr) > 2)
+		if (H5_HDR_LEN(hdr) > 2) {
 			h5->tx_win = (data[2] & 0x07);
+			assign_bit(H5_CRC, &h5->flags, data[2] & 0x10);
+		}
 		BT_DBG("Three-wire init complete. tx_win %u", h5->tx_win);
 		h5->state = H5_ACTIVE;
 		hci_uart_init_ready(hu);
@@ -425,7 +430,24 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 
 static int h5_rx_crc(struct hci_uart *hu, unsigned char c)
 {
-	h5_complete_rx_pkt(hu);
+	struct h5 *h5 = hu->priv;
+	const unsigned char *hdr = h5->rx_skb->data;
+	u16 crc;
+	__be16 crc_be;
+
+	crc = crc_ccitt(0xffff, hdr, 4 + H5_HDR_LEN(hdr));
+	crc = bitrev16(crc);
+
+	crc_be = cpu_to_be16(crc);
+
+	if (memcmp(&crc_be, hdr + 4 + H5_HDR_LEN(hdr), 2) != 0) {
+		bt_dev_err(hu->hdev, "Received packet with invalid CRC");
+		h5_reset_rx(h5);
+	} else {
+		/* Remove CRC bytes */
+		skb_trim(h5->rx_skb, 4 + H5_HDR_LEN(hdr));
+		h5_complete_rx_pkt(hu);
+	}
 
 	return 0;
 }
@@ -556,6 +578,7 @@ static void h5_reset_rx(struct h5 *h5)
 	h5->rx_func = h5_rx_delimiter;
 	h5->rx_pending = 0;
 	clear_bit(H5_RX_ESC, &h5->flags);
+	clear_bit(H5_CRC, &h5->flags);
 }
 
 static int h5_recv(struct hci_uart *hu, const void *data, int count)
@@ -686,6 +709,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
 	struct h5 *h5 = hu->priv;
 	struct sk_buff *nskb;
 	u8 hdr[4];
+	u16 crc;
 	int i;
 
 	if (!valid_packet_type(pkt_type)) {
@@ -713,6 +737,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
 	/* Reliable packet? */
 	if (pkt_type == HCI_ACLDATA_PKT || pkt_type == HCI_COMMAND_PKT) {
 		hdr[0] |= 1 << 7;
+		hdr[0] |= (test_bit(H5_CRC, &h5->flags) && 1) << 6;
 		hdr[0] |= h5->tx_seq;
 		h5->tx_seq = (h5->tx_seq + 1) % 8;
 	}
@@ -732,6 +757,15 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
 	for (i = 0; i < len; i++)
 		h5_slip_one_byte(nskb, data[i]);
 
+	if (H5_HDR_CRC(hdr)) {
+		crc = crc_ccitt(0xffff, hdr, 4);
+		crc = crc_ccitt(crc, data, len);
+		crc = bitrev16(crc);
+
+		h5_slip_one_byte(nskb, (crc >> 8) & 0xff);
+		h5_slip_one_byte(nskb, crc & 0xff);
+	}
+
 	h5_slip_delim(nskb);
 
 	return nskb;
-- 
2.43.0

