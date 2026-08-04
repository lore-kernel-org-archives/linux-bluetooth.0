Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDF3D412B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847525; cv=none; b=HU6Hs8fA1a0KdCUsIjbalP2Nc0r2stRCVpc6JOylmHj2WaAwC76AQ7k4KHAzzP3AeBWLCWHI/D0M/C/gLNNq5neqWtOgrWfUxhnE9K+kbteKnqkMlHBkMeaasC3ZnjXsHLI8zasc0RZq/yHO3Ry5Pkow79YKsKfxNNrdA1vLPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847525; c=relaxed/simple;
	bh=Azzhr0x048hipd4WfogQzHU4cl6NBA1DDE5CNy4+N+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBQpGx6uLAtdQT5ZyPt1v70AsjgZ+kfB892Q4VPLs/AboD1l6YIbT+qm0fZcbzSkRLOBWgKilDru/suKZaryzAS7ulq+FzyPSSoPyLIJVHA0HwcYdmKC6DM1azR/M1egjZdIVoce6oEhIsAMhVySNvm4mLPOxV9NHqom/ZlbAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 887563ED50;
	Tue,  4 Aug 2026 12:45:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ 2/3] unit: Adapt poc_*_oob.c test into a new test
Date: Tue,  4 Aug 2026 14:44:49 +0200
Message-ID: <20260804124511.2212066-2-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804124511.2212066-1-hadess@hadess.net>
References: <20260804124511.2212066-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGkNgIp5rJedV+62E+6uPUTVGQ4JjZZz7SXztVtyFpdW5b/CCoqIv1nXhFBqFK8vpKGkVGnlNCZzAtOE4Dwbystc9HAzXLdBCIbQ2wM/kgxIFyh2qFpzMJ3wRzypABCNsRaiOMLXtrPVSU0AXyZHRfuWrHDJNba2wYsUm1cavNw1hG8OwowBUvTpoynXjWRqcjn5sX15wnPNIPoKHsGAx5P5feIfhPWZPpAdUj4esE1XYnXgLdxC1oMZUQwnP0d6LUjpXcEmNE0Cd0MNgl/2TYpC4UdvU7xUccND9Y+PXSTbFTSBu0QhwksGmYtF/MPmQg1k7gHHzOynhsMPUzkrn25pl5d3mv8ZIWTgtJST65mWRduvr5mxM3jZr13fy1QCBzWyF6QdA5AExORAz6L1Pq7Mur7al5/RXfCj3VddlUPWRSJ7KCKfF/T/ZMqnXyObDzmuAml5TWSIgnvEprK82S9sNcb93I0M46SztIL1LVeo7OR9cWdobTlka9rpzpU5N6Cmg265gryYgQoU0yMQhSORjAVCmLUtK/NAQZkeFNRksjo/NuXScamp+mStGiSQqY4q3mm/m0SF+7XYm4L0jsauXezQggoFttRWtNVWQ4XBWzpD5puvKLKW5FgbJo4+I/mQEaqbQtS2DzxN3R/wBeY7OdwDh4o/6+kSKuhGDA+9g

Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.

Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>
---
 Makefile.am           |  9 +++++
 unit/test-avrcp-sec.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 unit/test-avrcp-sec.c

diff --git a/Makefile.am b/Makefile.am
index 19c468d3a504..e3baa4155c1f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -660,6 +660,15 @@ unit_test_avrcp_SOURCES = unit/test-avrcp.c \
 unit_test_avrcp_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-avrcp-sec
+
+unit_test_avrcp_sec_SOURCES = unit/test-avrcp-sec.c \
+			profiles/audio/avrcp-parse.c \
+			profiles/audio/avrcp-parse.h \
+			src/log.h src/log.c
+unit_test_avrcp_sec_LDADD = lib/libbluetooth-internal.la \
+				src/libshared-glib.la $(GLIB_LIBS)
+
 unit_tests += unit/test-hfp
 
 unit_test_hfp_SOURCES = unit/test-hfp.c
diff --git a/unit/test-avrcp-sec.c b/unit/test-avrcp-sec.c
new file mode 100644
index 000000000000..a100b2d68e35
--- /dev/null
+++ b/unit/test-avrcp-sec.c
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

