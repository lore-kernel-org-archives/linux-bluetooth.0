Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEA36F91D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022566; cv=none; b=N1rm12csiNXRr15/SKbF9+q3HVAdaoCdc08IBkncnjT5/fGK5yttuxpIiB9iwk8Skl4XIqS/o1t806PeAxI7HAgcpXMY6RmrStlESLURmF6hcESsPAw0pLk5gebbHZuJnz9sBUGHbDt1NSPGeP1o6AHmiA8wsFMfQw00PvqpOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022566; c=relaxed/simple;
	bh=3SWSycorHXv0USIP8zeAzRKKJNwp86p2nkOfuFKLQIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIhAHzokYWTHmi2cLc98EN6QSq60BtLzUSxuX/ZDGUw6PkeA1tGDhZ7zs0tLpoOPwwf9zZZ6jN893ECrDOrIhbV9grEG/HV/yUMEgdMWChIYruvvMcV1F6U6GacvHYd25Nl81+DlMMklRm0DS+b/xxzx6JPpVKj7ahazXm+MTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16C403E962
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 3/5] avrcp: Split off name parsing from parse_*_element()
Date: Thu,  6 Aug 2026 15:21:04 +0200
Message-ID: <20260806132231.3052523-4-hadess@hadess.net>
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
X-GND-Cause: dmFkZTFWaOHj/GAi5A4lKgxKmCkINabAwOMxUGBBbO8ob8OUq9jkBRd4zNumNMG1Cx1WH8f19orjYuPZVkPMBDrOOqLuBVeGpTGA3CNBQnQRRgmx5enIDRLfef0uqyOfCwKpuV82VU3Do7V7sBXJaXu83HRs2q1oqNeks0mzE51BOYCdkWmoOS0EwXaGXO8tpZFJ25IhzdCch0vCCYuyxnhT1nmBlIqm/KiXKv3IkCDWofjPi9xo+2dwxr/Urt9ZWyEUlNNahuNIcX64ZcHSguzvVBMV1KsTHXaCFSqrA0QWUsJDwgN9rjaHLV2PgBdVpPSAckoDXQwYkOhmZWWVT+LMUNXlSAI5yKKd7D6H9CfIbwxaj49O1FpZ3ueGHIWjZGrbWHj2ImeuVyhPXa4Kfg9ExbsFkyGmkO52ZCyIvLJk3FTgxLYzFEpulMShqgDyf4yohpbiRMabqNfYjipyjvcl58CdVzVLcvEhnygFj31qrnEP7SL4HpEW1GkPXchpRJtkM7RtptCli1fR7rwKDZEXWt1nUX0b0UnKwtezO7vhIk9fkVn8cxRQ20c6RFfNE3M7ZB76L3x/GJUvcMuysG0IXJ5MJG7e1D66HbROyGSOjiolLD7dSHKAL0TZGA+kQBGhvpi1w+muXtKWdeK+89LnqmjiQkv7UyfmIjBrwkYAB6yAKA
X-GND-State: clean
X-GND-Score: 0

This will allow us to use the name extraction code in
parse_media_element() and parse_folder_element() separately, such
as in tests.
---
 Makefile.plugins             |  1 +
 profiles/audio/avrcp-parse.c | 47 ++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp-parse.h | 19 +++++++++++++++
 profiles/audio/avrcp.c       | 26 +++++---------------
 4 files changed, 73 insertions(+), 20 deletions(-)
 create mode 100644 profiles/audio/avrcp-parse.c
 create mode 100644 profiles/audio/avrcp-parse.h

diff --git a/Makefile.plugins b/Makefile.plugins
index ac667beda847..a505fcd6691f 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -37,6 +37,7 @@ builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/avrcp-parse.h profiles/audio/avrcp-parse.c \
 			profiles/audio/avrcp-player.c
 endif
 
diff --git a/profiles/audio/avrcp-parse.c b/profiles/audio/avrcp-parse.c
new file mode 100644
index 000000000000..d3d0a070a4da
--- /dev/null
+++ b/profiles/audio/avrcp-parse.c
@@ -0,0 +1,47 @@
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
+#include "avrcp-parse.h"
+#include "src/shared/util.h"
+
+gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
+					 char *name, uint16_t *namesize)
+{
+	uint16_t namelen;
+
+	if (len < 13)
+		return FALSE;
+
+	memset(name, 0, NAME_MAX_LEN);
+	*namesize = get_be16(&operands[11]);
+	namelen = MIN(*namesize, NAME_MAX_LEN - 1);
+	if (namelen > 0) {
+		memcpy(name, &operands[13], namelen);
+		strtoutf8(name, namelen);
+	}
+
+	return TRUE;
+}
+
+gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
+					char *name)
+{
+	uint16_t namelen;
+
+	if (len < 12)
+		return FALSE;
+
+	memset(name, 0, NAME_MAX_LEN);
+	namelen = MIN(get_be16(&operands[12]), NAME_MAX_LEN - 1);
+	if (namelen > 0)
+		memcpy(name, &operands[14], namelen);
+
+	return TRUE;
+}
diff --git a/profiles/audio/avrcp-parse.h b/profiles/audio/avrcp-parse.h
new file mode 100644
index 000000000000..f7a33c854442
--- /dev/null
+++ b/profiles/audio/avrcp-parse.h
@@ -0,0 +1,19 @@
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
+#include <glib.h>
+#include <inttypes.h>
+
+#define NAME_MAX_LEN 255
+
+gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
+					 char *name, uint16_t *namesize);
+gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
+					char *name);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2194a913580f..af3c72174764 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -52,6 +52,7 @@
 
 #include "avctp.h"
 #include "avrcp.h"
+#include "avrcp-parse.h"
 #include "control.h"
 #include "media.h"
 #include "player.h"
@@ -2614,24 +2615,15 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	struct avrcp_player *player;
 	struct media_player *mp;
 	struct media_item *item;
-	uint16_t namelen, namesize;
-	char name[255];
+	uint16_t namesize;
+	char name[NAME_MAX_LEN];
 	uint64_t uid;
 	uint8_t count;
 
-	if (len < 13)
+	if (!parse_media_element_name(operands, len, name, &namesize))
 		return NULL;
 
 	uid = get_be64(&operands[0]);
-
-	memset(name, 0, sizeof(name));
-	namesize = get_be16(&operands[11]);
-	namelen = MIN(namesize, sizeof(name) - 1);
-	if (namelen > 0) {
-		memcpy(name, &operands[13], namelen);
-		strtoutf8(name, namelen);
-	}
-
 	count = operands[13 + namesize];
 
 	player = session->controller->player;
@@ -2655,24 +2647,18 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	struct media_item *item;
-	uint16_t namelen;
-	char name[255];
+	char name[NAME_MAX_LEN];
 	uint64_t uid;
 	uint8_t type;
 	uint8_t playable;
 
-	if (len < 12)
+	if (!parse_media_folder_name(operands, len, name))
 		return NULL;
 
 	uid = get_be64(&operands[0]);
 	type = operands[8];
 	playable = operands[9];
 
-	memset(name, 0, sizeof(name));
-	namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
-	if (namelen > 0)
-		memcpy(name, &operands[14], namelen);
-
 	item = media_player_create_folder(mp, name, type, uid);
 	if (!item)
 		return NULL;
-- 
2.55.0

