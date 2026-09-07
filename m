Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84089309F09;
	Tue,  8 Sep 2026 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847600; cv=none; b=bWclzr53gNjG5Dj1qox5lSNEM/EzzRiib+s44hd3hxahZ4RzGAGxSW8QIREhPY4MZZLd5uCQwN/XnL2vYKpGl495P3xnJpDrmMASnNcinKgH9cg/qso3iJjApHT8apaNvoTNiImDKcdePCt0hejKgOIVMLZ6p0d8Mh9txyEK87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847600; c=relaxed/simple;
	bh=dvvmaxumsJ3WpibiIOCL+v9HIUJMJEqp0vm8KiPVNB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJImMBsanUKX7O2vGAOwor8NiGWn0/Pfx7UtcS5xQqpikmE9VkAmK6K0pHgLYoVyDDWtPY/EV6wdSQCLH2A7gKBYYNF0eCU5bPlQYpoMi0G6zVRLCQbDSCp76L7Pyg/8EkXL0YBsRZSV4QfQE+nLBfJlthXZ8pNmEQlmb4kd8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz4t1788847577tf356e9f0
X-QQ-Originating-IP: CwIG5X9KpIxULWvCayf6O2AtbJDNXKmELnXdu/1tZBw=
Received: from localhost.localdomain ( [39.144.190.97])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 14:06:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9097658671958455160
EX-QQ-RecipientCnt: 5
From: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Subject: [PATCH] Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
Date: Mon,  7 Sep 2026 23:10:15 +0800
Message-ID: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MaHg5zel0g/XAqMamSNaGE3lRAmxhprl1DloXYUrSBgFJ+P9tcOEByWK
	bxGgwxDJ7Sw8IhzoBRMaXpM++RjL5DZMoXogrXZl1io8J9zxVbEK2i/yM8tRmShIiL9q5mT
	XV0qGlydn2KhEXo2Ik+tUy5D/I40P/qn1nKGY/yU4xuGkkJSCWPOMvT7pSBBkGwzC2MDHPu
	p7+cUlGNnNVJECVp+/4ODYYyGKqKjYddq3hS8aJ5cCLSKW/XPaQ4A5oVdC9RPTtIekcCmoz
	pMAGOEI3UO90M7HoYzHMW2TZTSYLBEcPg66BIqMKlxcOK9jaLwuKJ4oSb7a4MFdlxH/oJmj
	7sQWLorJuWN3o/lQNa/JNaKSNYAyLdA9U2s3BFIGxp2yF0SZoERMCKODr0OTLlymgCPJIdP
	e4vcibNCNMotjWE2ap0WHxvRe9K8xa3nFV4XSkytzz6NslCCasWN6FzBO9o831AriwC1V/H
	HbBlZ8yxxpTW0FE7Q5HOpelwtI7q9lRgUrwxuEj8Qg9hFw3l+yAoupTEn6CvPwQd3JzDFdt
	WaInVBI6t79KezoYxCYwGWbvwrwy8x3xlO18yUgMMxd8KViVME40z5BbGk3EZlxkNrZgg/X
	yaT52EfzPvVx620Q3+GmjlASXq0D0C09APeqXlnaiPqQHXFJjZkz6AyN47sJZvibFyG9gMo
	tZFuOG2H7k5b/pRY4scVTCvRoPxrvbNpgp2uMwOajcpHKi04902YjFb/7L6WR2yIDt7/NRO
	DFPp1h08ur2cd+MnUsC46BSJevmXWVR9LBE2Oy9nhntF+B/2K9txYBovxJsf9WJ+j6sjVUg
	696lET0EEO+KFSHQfnaRqIGvIiVTQ6Aq5Tgdp1XcZ8s4Jf8rH3CWvsZ+RNbIaQww/fIuh1o
	DrBeS3yOHVwh3JOfiJsKwGyocvd9qSK2Mp/FbNfN0ImhLIZsDcQWS8diruiilXJXDDXCv/n
	kb/lcCPsdrCF1O91kB67Ms/nFR6V1lYQIAiYHKEqUiwFjOrTQEmux7wgCyTqxxYAgwsjxLo
	wWu3IqbXxHBtw/RYLboAzAFMkgQw9SUICqtALQp6XscAN+G6vNaQLb1lroDUZD9QXCWc+01
	xz5wW/zz1cB5q2wD3vdsa8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

bcsp_crc_update() processes each byte as two nibbles, requiring two
dependent table lookups for every header and payload byte when CRC is
enabled.

The existing crc_ccitt_byte() helper implements the same reflected
polynomial with one lookup per byte. Use it instead of the private
nibble-based implementation and select CRC_CCITT for BCSP-only UART
configurations as well. The initial CRC value and final bit reversal
remain unchanged.

This replaces the private 16-entry table with the shared 256-entry table,
trading table size for fewer dependent lookups. An exhaustive comparison
of all 65536 CRC states and 256 input bytes matches both the old code and
a bitwise reference implementation.

Signed-off-by: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
---
 drivers/bluetooth/Kconfig    |  1 +
 drivers/bluetooth/hci_bcsp.c | 26 +++-----------------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e8c24d757e9..2d6a3117e387 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -151,6 +151,7 @@ config BT_HCIUART_BCSP
 	bool "BCSP protocol support"
 	depends on BT_HCIUART
 	select BITREVERSE
+	select CRC_CCITT
 	help
 	  BCSP (BlueCore Serial Protocol) is serial protocol for communication
 	  between Bluetooth device and host. This protocol is required for non
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 0323db21c428..ef71a349e777 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -25,6 +25,7 @@
 #include <linux/ioctl.h>
 #include <linux/skbuff.h>
 #include <linux/bitrev.h>
+#include <linux/crc-ccitt.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -75,34 +76,13 @@ struct bcsp_struct {
 
 /* ---- BCSP CRC calculation ---- */
 
-/* Table for calculating CRC for polynomial 0x1021, LSB processed first,
- * initial value 0xffff, bits shifted in reverse order.
- */
-
-static const u16 crc_table[] = {
-	0x0000, 0x1081, 0x2102, 0x3183,
-	0x4204, 0x5285, 0x6306, 0x7387,
-	0x8408, 0x9489, 0xa50a, 0xb58b,
-	0xc60c, 0xd68d, 0xe70e, 0xf78f
-};
-
 /* Initialise the crc calculator */
 #define BCSP_CRC_INIT(x) x = 0xffff
 
-/* Update crc with next data byte
- *
- * Implementation note
- *     The data byte is treated as two nibbles.  The crc is generated
- *     in reverse, i.e., bits are fed into the register from the top.
- */
+/* Update crc with next data byte */
 static void bcsp_crc_update(u16 *crc, u8 d)
 {
-	u16 reg = *crc;
-
-	reg = (reg >> 4) ^ crc_table[(reg ^ d) & 0x000f];
-	reg = (reg >> 4) ^ crc_table[(reg ^ (d >> 4)) & 0x000f];
-
-	*crc = reg;
+	*crc = crc_ccitt_byte(*crc, d);
 }
 
 /* ---- BCSP core ---- */
-- 
2.43.0

