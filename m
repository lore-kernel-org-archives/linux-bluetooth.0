Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FB38553A
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076345; cv=none; b=R1LBTL85zMxzQ57bwbL2yDWLVgjYvspVxFfSm3bnlb0VeVCLIEGyUxQyi4pY1HA6e3bRAWbYV0Sh44BnSDkGBELVxPKgWS5x6FYniCnWwfSdLA7FkwOUoVxhMFHJtO61eafBRA3uO0+Xbyk/iVYHjvNSQVjzJncWS/Wry89avZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076345; c=relaxed/simple;
	bh=t4yum3+6fWLqsT3pJ7NYdiE55EHU4Ekk9arXbt5kKtE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKx2JMmc2XF7Gx6gY8moooAjMarsXqLBOYCMv/S/jiSTPzI+PWdE/4E4l3z8s6uIiHNpjx9y6oyaxGsp+SDNbmKVM+/ycK1tOgst7X/HgRfDpgQud0t/Wnvsgr7UFXVnNeqsfIBciCVFCK16bP8IYWEkGWlUr61LaNY/fUyBKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4B4220D5E
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:45:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] all: Remove redundant MIN/MAX macro definitions
Date: Wed,  1 Apr 2026 22:45:06 +0200
Message-ID: <20260401204527.148077-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401204527.148077-1-hadess@hadess.net>
References: <20260401204527.148077-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGeEuQyRG5oHDvNy6jeCHwyrujYFEMfD8u3Qlr9Zz7ygBG2OFrIbNBTgeSGoDJMZB+MB/5Joy6c8alqelHeqnYRIVlCgh6RFBeR3Jkvg7tpNQQm50ylqp3EavUUpdj0ITxnLE0Gk++Xx3IwO/WqGSxWdd+23zqQH3A0PE09DPnFNQGhpYlvUAL18dTissHAWmsVp7QimUIOOdO8x0CeEsvz++9m8AGmiGBi7gmbkrq4L5NB+W42hVY+wlThPDmkkouCTi1+OsM5HDBwh9o7dIqXmyUi/525tRYYcke6ZxqZFpFrXB8kE1dLZTdBd+OqdlRJusJ63RcBXfKuiqS3XNBiblHnTxlieldzAAt1xthsvmG2UPW4d6MRXhZdQIVXXFvkuHp/NJ92GQSTa8obhekC9psJJfmsyZyvrQcpD8xR/qyDniqJeV0g/cJuRJrpcAh3RDpDq2gP0BfD7PCOongjDnsmbE/YJg+uirKmzP34e6nXSX0TkQbrONvnMx808JxvsHlDmZRBaD0oTqqrnZ2azozGdk5SI8X2IpaHPIQ0VM4oHod1VQ12VfP6S0ZBTYR/yFF/fSwhn8xp2ThJAg/TNYbR7sATDX/maVJVp20Wq6o4jV5PKp4xvV+1dDUtHD91eEVpBbZU+ouMsajjaVB9jiogtjth1S/QtkL8WFvaoA

---
 client/mgmt.c             | 4 ----
 mesh/prov-initiator.c     | 3 +--
 src/device.c              | 4 ----
 src/gatt-database.c       | 4 ----
 src/shared/gatt-client.c  | 8 --------
 src/shared/gatt-helpers.c | 4 ----
 src/shared/ringbuf.c      | 4 ----
 src/shared/uhid.c         | 4 ----
 src/shared/vcp.h          | 8 --------
 tools/advtest.c           | 3 ---
 tools/btgatt-server.c     | 4 ----
 tools/hcitool.c           | 4 ----
 tools/parser/rfcomm.h     | 2 --
 13 files changed, 1 insertion(+), 55 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 71fcd21ffeb6..50558a313866 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -67,10 +67,6 @@ static struct {
 
 static int pending_index = 0;
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 static void mgmt_menu_pre_run(const struct bt_shell_menu *menu);
 
 #define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "> "
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index d46081c7ae19..29c0be71392f 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -18,6 +18,7 @@
 
 #include "src/shared/ad.h"
 #include "src/shared/ecc.h"
+#include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
@@ -34,8 +35,6 @@
 #include "mesh/agent.h"
 #include "mesh/error.h"
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 /* Quick size sanity check */
 static const uint16_t expected_pdu_size[] = {
 	2,	/* PROV_INVITE */
diff --git a/src/device.c b/src/device.c
index cfbde307bcc9..0e8ca28d3809 100644
--- a/src/device.c
+++ b/src/device.c
@@ -72,10 +72,6 @@
 #define DISCOVERY_TIMER		1
 #define INVALID_FLAGS		0xff
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define RSSI_THRESHOLD		8
 #define AUTH_FAILURES_THRESHOLD	3
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5819c252900c..20d28357abc7 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -54,10 +54,6 @@
 #define UUID_GATT	0x1801
 #define UUID_DIS	0x180a
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct gatt_record {
 	struct btd_gatt_database *database;
 	uint32_t handle;
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df1541b88fdb..a6abe8ac2fa4 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -25,14 +25,6 @@
 #include <limits.h>
 #include <sys/uio.h>
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
 
 #define GATT_SVC_UUID	0x1801
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 8dee34a9e398..b3d5d8f1a483 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -20,10 +20,6 @@
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct bt_gatt_result {
 	uint8_t opcode;
 	void *pdu;
diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 957d355f9b36..7460dd483d8c 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -21,10 +21,6 @@
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
 
-#ifndef MIN
-#define MIN(x,y) ((x)<(y)?(x):(y))
-#endif
-
 struct ringbuf {
 	void *buffer;
 	size_t size;
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 207afa55e3f8..919618a71b00 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -26,10 +26,6 @@
 
 #define UHID_DEVICE_FILE "/dev/uhid"
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 struct uhid_replay {
 	bool active;
 	struct queue *out;
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 89efaa09cfce..e031beafdd0c 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -23,14 +23,6 @@
 #define BT_VCP_UNMUTE			0x05
 #define BT_VCP_MUTE			0x06
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct bt_vcp;
 
 typedef void (*bt_vcp_destroy_func_t)(void *user_data);
diff --git a/tools/advtest.c b/tools/advtest.c
index 7e744dca8021..a67a03c43b10 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -39,9 +39,6 @@
 			"\xe1\x23\x99\xc1\xca\x9a\xc3\x31"
 #define SCAN_IRK	"\xfa\x73\x09\x11\x3f\x03\x37\x0f" \
 			"\xf4\xf9\x93\x1e\xf9\xa3\x63\xa6"
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
 
 static struct mgmt *mgmt;
 static uint16_t index1 = MGMT_INDEX_NONE;
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 449c342031a5..18e8b9542ab7 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -48,10 +48,6 @@
 		print_prompt(); \
 	} while (0)
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_GREEN	"\x1B[0;92m"
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 834f83e7a036..1903d859bff1 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -34,10 +34,6 @@
 
 #include "src/oui.h"
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 /* Unofficial value, might still change */
 #define LE_LINK		0x80
 
diff --git a/tools/parser/rfcomm.h b/tools/parser/rfcomm.h
index b1cb1741c453..d1b093a902c7 100644
--- a/tools/parser/rfcomm.h
+++ b/tools/parser/rfcomm.h
@@ -33,8 +33,6 @@
 /* Returns the P/F-bit */
 #define GET_PF(ctr) (((ctr) >> 4) & 0x1)
 
-#define MIN(a, b) (((a) < (b)) ? (a) : (b))
-
 /* Endian-swapping macros for structs */
 #define swap_long_frame(x) ((x)->h.length.val = le16_to_cpu((x)->h.length.val))
 #define swap_mcc_long_frame(x) (swap_long_frame(x))
-- 
2.53.0

