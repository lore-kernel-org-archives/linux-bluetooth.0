Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AC332EBD
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022570; cv=none; b=HEUnIdiz95FihnPQQFyS0hTQANRS84UnCenTIHF1T97AUTXlNSylRxLea4w5FDlYOtE367JUeQjmXLvp6Yy+p5B+/88tMcN5WO8kmR1s1fFXui8wpg2D1ivVJLNoiGsz2OdvrmFVuQYpDpD1YV4NlCJnOOjZVo34s5BKO8+T45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022570; c=relaxed/simple;
	bh=t37ZIVaf4SA3IX/yD9feVmBlfFhbzX4lw5kikVvTThc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOBCu0Vt/+7N4zvFe1M5D1linrA4Cd2mG/+cuYtZYHm/pRCakdw5NQj0wXS1liHlN24EIdXOjmi8RJS/EtaxhBV+WzPkrLuZEjchA2XDS81EtsV4vSVYQLSnEvcLuvTAehT5g1Ttv86N0vQ0Yfgo04Mqk5mp8SfSp7uKwYk5JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47C573F4F3;
	Thu,  6 Aug 2026 13:22:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ, v3 4/5] unit: Adapt poc_*_oob.c test into a new test
Date: Thu,  6 Aug 2026 15:21:05 +0200
Message-ID: <20260806132231.3052523-5-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806132231.3052523-1-hadess@hadess.net>
References: <20260806132231.3052523-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTExch6bGo9l+F+n8sWi19Tdp5I+JHuPU4b4FC3pRSRTSdDWqDXtBA3BgWCtk2JbCRjP+dM+NsZ86mVZl088WvtADKxh7M4lUpzCDjar8B+R7Hlg9qjBk2zMO26fY1RnZ8biX1NnpTgbwSH+2sf6o23tWaf9gfXzV9BckuSJO1rv8bZqQ27Xgg82IyetnXphbsHmmVTxo1szBTUYz4KekaoZ086g+nbGOHUMPXkYqxuVAfBOuM5QhrOtGu+nUhw2AT1dnN/j/VSoqMQXMw/7h7iewvJLLeQs+D3uujuUs0djzQnI0MzXah2j9MXkAJ0OpQ7VPxJVTdaoWGhMZU31W//ZoVRIEiiVRoXf0B3WpBq1D8Q9dHieyz3Y2AOs9fa3j9mQUzyVACJA/ES8xVlL85aB3QDts2rLqIDEie96LBG+y/WjWwJ/4jyiqCuKEa4KzwcMroZedsntwia9Tqa/UjUE7+89OOko+aRyEjvf+vGvI9cgXsErdZazlkHu/RwI/LtBfLCZ+hD4Zkk2rIFULKh9eyrJ4CgGCgnzrDrxW3iTZvyt0hdxY/lwKfw0NdVYLkSpPOTMcKM2cTcVDz0OussI0ryaCsWtZ4y/9QiaAhapvZDWLcGHcI+njYe/S25CTz+81RkD+DUMDqEJ1sxSgSFw3tqbaDUgJfDh0iLtpvFRWw
X-GND-State: clean
X-GND-Score: -100

Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.

Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>
---
 Makefile.am       |  9 ++++++
 unit/test-avrcp.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 unit/test-avrcp.c

diff --git a/Makefile.am b/Makefile.am
index f4f638323c79..72b7862ef2e8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -651,6 +651,15 @@ unit_test_avctp_SOURCES = unit/test-avctp.c \
 				unit/avctp.c unit/avctp.h
 unit_test_avctp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-avrcp
+
+unit_test_avrcp_SOURCES = unit/test-avrcp.c \
+			profiles/audio/avrcp-parse.c \
+			profiles/audio/avrcp-parse.h \
+			src/log.h src/log.c
+unit_test_avrcp_LDADD = lib/libbluetooth-internal.la \
+				src/libshared-glib.la $(GLIB_LIBS)
+
 unit_tests += unit/test-hfp
 
 unit_test_hfp_SOURCES = unit/test-hfp.c
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
new file mode 100644
index 000000000000..a100b2d68e35
--- /dev/null
+++ b/unit/test-avrcp.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Red Hat Inc.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/log.h"
+
+#include "profiles/audio/avrcp-parse.h"
+
+static void avrcp_element_name_oob(gconstpointer data)
+{
+	char name[255];
+	uint16_t namesize;
+	gboolean ret;
+
+	/* Crafting a malicious payload.
+	 * Actual packet length (len) = 14 bytes */
+	uint8_t malicious_packet[14] = {0};
+
+	/* Specify namesize = 1000 (0x03E8 in Big Endian) at offset 11 */
+	malicious_packet[11] = 0x03;
+	malicious_packet[12] = 0xE8;
+
+	/* Launching the PoC. We transmit a 14-byte packet, but namesize=1000... */
+	ret = parse_media_element_name(malicious_packet, sizeof(malicious_packet),
+				       name, &namesize);
+	if (ret)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+static void avrcp_folder_name_oob(gconstpointer data)
+{
+	char name[255];
+	gboolean ret;
+
+	/* Crafting a malicious payload.
+	 * Actual packet length (len) = 14 bytes */
+	uint8_t malicious_packet[14] = {0};
+
+	/* Specify namesize = 1000 (0x03E8 in Big Endian) at offset 12 */
+	malicious_packet[12] = 0x03;
+	malicious_packet[13] = 0xE8;
+
+	/* Launching the PoC. We transmit a 14-byte packet, but namesize=1000... */
+	ret = parse_media_folder_name(malicious_packet, sizeof(malicious_packet),
+				      name);
+	if (ret)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/avrcp-element-name-oob", NULL, NULL, avrcp_element_name_oob, NULL);
+	tester_add("/avrcp-folder-name-oob", NULL, NULL, avrcp_folder_name_oob, NULL);
+
+	return tester_run();
+}
-- 
2.55.0

