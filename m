Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FC3D1CBE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847524; cv=none; b=IARiBeb6UWSleTA5jMb4Wau6nON73a/RIvFyuqBJm52+414okze3LYELjt1prgkVS5dUWVmdAo5dpYvbIk9DKMkv+SE6WmIvFEbnynVcdyuU9G0O4isYU5UJDVoH0QpW/Dkl+zJE2oUG8D0j05XkeWJKE1DAtiuHjVDGPwvs+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847524; c=relaxed/simple;
	bh=RFe+2Ln1hK/gT2PaniCmj8RN7ND2JflwfesIwzKUolc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MOIpQPu4AWxTfLeyWNWs5gH5XXBEJOAcmal2FXFoDQmYEIZp2BSmqkeqxU8darW3c62+e8SI7nfWc0ExLsijFNEql/2i60oT6Ejb9gtAv+0X4F3ajBVHimA6LzL4VZQ9DlDuuIX84oyOyITOQkGYvhHeqBelkucIxmwu6o1Ctxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50F023ED46
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:45:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/3] avrcp: Split off name parsing from parse_*_element()
Date: Tue,  4 Aug 2026 14:44:48 +0200
Message-ID: <20260804124511.2212066-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
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
X-GND-Cause: dmFkZTEWsn2kwUcJhnz3LDIYWgUn56qvNNUU0XjuiWHr6bSWfe/awYzFZwyLh43oY5GP/rt6rs77AVVBv+9Vl+HLSrFMG5FVoRO/9MRuhxqjmvV4gKYyCUETupT+Ig7c3PwfpplGG1W8KPeUUANVmx4VKQ8nYkZWf+xLH+k69yMzTkDRBwFzGfXSDkYhitZjP6F0NSCFO9gBGgxmRJM9fohfMJ9oqlNd0br6Ny78TB8/KofqqpK7B81MVh4MP4tVSDBNH5hnYeUKcslZ3MYuTasqlYC2AzySHifsI0ruj1/Y5arl2A1usYDqlyUFgQ/aOChGP97MeaPN4S2RgHxcrH3apuvMnqTC9wz1lo43UqcBs+lzyNse7RAE4GfdBxWjoXchah23zZrv9P9vkEKgyCWKo7f891i3q9CCKYL3iaUkP+tTAfWLEfNkMGEXghKnZnk4S3kSy3rYfz6yTg/tuD3hXNvsv4zguhiafxGo+dWfGuNrVAQRyInF4KjKG3kIx7E2eyTis7ZK4iVIban3zWrbt7o1gqV/vR0ihKat7WZvvRHbn6VMhKXrv1YBNJqLNZn59QXxwhzZ0Nbh2wuS/A4gYEncgwTR1Khm0uth/WdvBnw/FeB4MEVKWHr9J4iB5OMUlmUWC8NeEyYTxN2Mvjgko7ZwwM9beHg7isvKhdbBmnKC3Q

This will allow us to use the name extraction code in
parse_media_element() and parse_folder_element() separately, such
as in tests.
---
 Makefile.plugins             |  1 +
 profiles/audio/avrcp-parse.c | 47 ++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp-parse.h | 18 ++++++++++++++
 profiles/audio/avrcp.c       | 26 +++++---------------
 4 files changed, 72 insertions(+), 20 deletions(-)
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
index 000000000000..d98aab4b2eee
--- /dev/null
+++ b/profiles/audio/avrcp-parse.h
@@ -0,0 +1,18 @@
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

