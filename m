Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE5202C40
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426912; cv=none; b=BK4ztQq/siIR4NA7P5CGuilWlhgu6h4Ho7j6EY+4DgJ8A8/TtdWT2mHYmCkqiW4ch9KOrG9Z7xat5nSOONr15QMjfsFj6p+iP1BZZ1KBvnL8s4da203p3+HHtRqMQf/NuGFTVVeEgYyWQ2IAU3pWcY4rH8iilNkwELaoQ/O+BMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426912; c=relaxed/simple;
	bh=g25dOdAIsn7hvzwtAgPgy3LhrMdbM2O3w8w+IjJkQ8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=iKMoTH2jAE332HAGjjNiHF/xqpbnDbBme4yjfd1TiITlIYirMi2WnKuJxZ9Rv3Fs2CIrQmwmVL5Kh5BiOFRnFfU6M7oxwUB5zN4a+Zk6yIk6AcoOE6IGCYP1qF6vCoQ2+b6edWH2vXJILxcqltef7CFH+RRcrF0DuiTGe1wBMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VmcKPNxd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VmcKPNxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743426908;
	bh=g25dOdAIsn7hvzwtAgPgy3LhrMdbM2O3w8w+IjJkQ8o=;
	h=From:To:Subject:Date:From;
	b=VmcKPNxdWChgevdb6pFKGVbFWq6GktGFWirT1ZuQXvXw+XiZQXAruuvl37Jvf+/nd
	 vbPpfz5xygJKzmJSEZk+sUhE32EeqTXDLDr6jdxFEEkffFIH/dXRnclsa3VzqaQ7fx
	 XQQSlRCVGJ+UvR7Y8U4u4hUuKwAIrP7wbCywKbFirqrVyuMaS+Lwrta0ceSfiycHsB
	 TRmJ/6W1+Mxm3Q/FdFL89D0NeCUCzZKWuVvufsf1CTLdzmby16Vr/KTFROeY1i7ASM
	 8wjlIRZoRfbIp395rxQUY/iLcW1SnN4wEgKhYkxwRZ84XbMjESYOsCtSYNboVURZmV
	 hP3KqAY5Sy90A==
Received: from fdanis-XPS-13-9370.. (2A02-8428-af44-1001-1A63-3db9-41B7-AcE4.rev.sfr.net [IPv6:2a02:8428:af44:1001:1a63:3db9:41b7:ace4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93CD417E0215
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 15:15:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: rfcomm: Accept any XON/XOFF char
Date: Mon, 31 Mar 2025 15:15:03 +0200
Message-ID: <20250331131503.63375-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The latest version of PTS test RFCOMM/DEVA-DEVB/RFC/BV-17-C
(RFCOMM v11.7.6.3) used unusual chars for XON (0x28 instead of
0x11) and XOFF (0xC8 instead of 0x13) and expect a reply with RPN
parameters set for XON and XOFF.

Current btmon traces:
> ACL Data RX: Handle 11 flags 0x02 dlen 18
      Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0x70
         MCC Message type: Remote Port Negotiation Command CMD (0x24)
           Length: 8
           dlci 32
           br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
           rtri 0 rtro 0 rtci 0 rtco 0 xon 40 xoff 200
           pm 0xff7f
< ACL Data TX: Handle 11 flags 0x00 dlen 18
      Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x01 cr 0 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0xaa
         MCC Message type: Remote Port Negotiation Command RSP (0x24)
           Length: 8
           dlci 32
           br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
           rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
           pm 0x3f1f

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/rfcomm/core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ad5177e3a69b..0c0525939aa0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1562,23 +1562,15 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
 		}
 	}
 
-	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON)) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON))
 		xon_char = rpn->xon_char;
-		if (xon_char != RFCOMM_RPN_XON_CHAR) {
-			BT_DBG("RPN XON char mismatch 0x%x", xon_char);
-			xon_char = RFCOMM_RPN_XON_CHAR;
-			rpn_mask ^= RFCOMM_RPN_PM_XON;
-		}
-	}
+	else
+		rpn_mask ^= RFCOMM_RPN_PM_XON;
 
-	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF)) {
+	if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF))
 		xoff_char = rpn->xoff_char;
-		if (xoff_char != RFCOMM_RPN_XOFF_CHAR) {
-			BT_DBG("RPN XOFF char mismatch 0x%x", xoff_char);
-			xoff_char = RFCOMM_RPN_XOFF_CHAR;
-			rpn_mask ^= RFCOMM_RPN_PM_XOFF;
-		}
-	}
+	else
+		rpn_mask ^= RFCOMM_RPN_PM_XOFF;
 
 rpn_out:
 	rfcomm_send_rpn(s, 0, dlci, bit_rate, data_bits, stop_bits,
-- 
2.43.0

