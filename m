Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA863C76A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842681; cv=none; b=Bz2LAJH8LB4Gz3u2h32yxqleTJWHE69oOIPH6dDaylhJqY4ZkNF9eILgo4bzmIfkCyShB+CLSTy46gLd4tH/GAAStUul77elRmI0pveDY8Y0tjnwscN/MPmmy+M8Ifv6lcLwh/nN4tczenQQN5zEcRkx8PLKUHheVuSzQJOavfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842681; c=relaxed/simple;
	bh=vssYs2cXPFzGirZhFnOtIfyltLL53GEB/HP8tE3vRJ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g4Dxv4AUU4+lgSNY6mEX1zHjvIcRyYdNgHEkaDJ/FTxWd/EZ0nlYlFaGUAdZkp7S6PaI8ZAJAG/LQ0ISghLKB4qY589xWAfHmTS2ttULNI1IzaiKZef238YdQcB56D+IooaE4XZQuNukdhB3MrQApDExvR/3JlORPXAw/D9J0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE0A83E98F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:57:50 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
Date: Thu, 27 Aug 2026 16:57:38 +0200
Message-ID: <20260827145742.1568129-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE0+DRKOEJsvnh+ZUaP+Y29RQNBEDwZyeYuLFBNakSMBcg2EmpRRWIS73ooesbGng0y3HBSBFlpuLbs8PVwSochGp+vlcnwiyZ1+eqovq2azDwEPJwg45l9Vyn4INsBCeOlLvPV5Bzt99XOmsxvPhL+nsjadTjiynsjbPLGl69ZJ+IHs7xzuzykvKEtzDYhuPqBP3oa3NcLNoJ2yr0LuAg5Oq4SEivTr/iYKQKC5U48ge9XaQONexSixf3IRtnyijRyZwrF/hrwSO3rn5oGG8xa9lXl+mEPDj4bxeeuWXRsMdg3HS3dkMsOeG35suovKN70BeBo95X8uKMzDtVgeayDscoeNMpy998hU5iIKaqVye1j4ltc+3iVKMFVxbNKx/ziFsrN6TnL3TuBKx92cq9ufxSAeSxBQTcxEvTR3qIyfCbvYO6MKVeX3AA0MCdYRLsaSZ0X6+hs4XVnaKDOKeJx+YV2mScZbXmaq3ArpcHtxXv5u4T9L7b3Mt/qbA5A+ywXwxyJVdpArlBORPA66Ch8iloi9aDoXqmeHGE7KnUPkrm1ReyEcc3OjCk1aOdrvMZ+Js/eZqP3HXDWCjaSXERG6pbrYJQwNsTHhanFkPm6MadaG2fTqkI9PuAzQpSUUDd4L8lHBekXrXBcolZ6XTRTs8X7AbIRduaJLCVSwRzKfA
X-GND-State: clean
X-GND-Score: 0

It's "illegal" not "ilegal".
---
 monitor/avctp.c        | 6 +++---
 profiles/audio/avrcp.c | 2 +-
 profiles/audio/avrcp.h | 2 +-
 tools/parser/avrcp.c   | 6 +++---
 unit/avrcp-lib.c       | 8 ++++----
 unit/avrcp-lib.h       | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 6309275f6efd..0db352f18ffd 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -141,7 +141,7 @@
 #define AVRCP_PACKET_TYPE_END		0x03
 
 /* player attributes */
-#define AVRCP_ATTRIBUTE_ILEGAL		0x00
+#define AVRCP_ATTRIBUTE_ILLEGAL		0x00
 #define AVRCP_ATTRIBUTE_EQUALIZER	0x01
 #define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
@@ -462,7 +462,7 @@ static const char *pt2str(uint8_t pt)
 static const char *attr2str(uint8_t attr)
 {
 	switch (attr) {
-	case AVRCP_ATTRIBUTE_ILEGAL:
+	case AVRCP_ATTRIBUTE_ILLEGAL:
 		return "Illegal";
 	case AVRCP_ATTRIBUTE_EQUALIZER:
 		return "Equalizer ON/OFF Status";
@@ -480,7 +480,7 @@ static const char *attr2str(uint8_t attr)
 static const char *value2str(uint8_t attr, uint8_t value)
 {
 	switch (attr) {
-	case AVRCP_ATTRIBUTE_ILEGAL:
+	case AVRCP_ATTRIBUTE_ILLEGAL:
 		return "Illegal";
 	case AVRCP_ATTRIBUTE_EQUALIZER:
 		switch (value) {
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 028c1c254b82..3271b84782e8 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2413,7 +2413,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 
 	for (i = 0; len > 0; len--, i++) {
 		/* Don't query invalid attributes */
-		if (pdu->params[i + 1] == AVRCP_ATTRIBUTE_ILEGAL ||
+		if (pdu->params[i + 1] == AVRCP_ATTRIBUTE_ILLEGAL ||
 				pdu->params[i + 1] > AVRCP_ATTRIBUTE_LAST)
 			continue;
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index b5381b4df234..21351a4bc422 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -10,7 +10,7 @@
  */
 
 /* player attributes */
-#define AVRCP_ATTRIBUTE_ILEGAL		0x00
+#define AVRCP_ATTRIBUTE_ILLEGAL		0x00
 #define AVRCP_ATTRIBUTE_EQUALIZER	0x01
 #define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index 9f0c1596b4b9..7da9b0d07b3c 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -145,7 +145,7 @@
 #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED		0x16
 
 /* player attributes */
-#define AVRCP_ATTRIBUTE_ILEGAL		0x00
+#define AVRCP_ATTRIBUTE_ILLEGAL		0x00
 #define AVRCP_ATTRIBUTE_EQUALIZER	0x01
 #define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
@@ -471,7 +471,7 @@ static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t l
 static const char *attr2str(uint8_t attr)
 {
 	switch (attr) {
-	case AVRCP_ATTRIBUTE_ILEGAL:
+	case AVRCP_ATTRIBUTE_ILLEGAL:
 		return "Illegal";
 	case AVRCP_ATTRIBUTE_EQUALIZER:
 		return "Equalizer ON/OFF Status";
@@ -512,7 +512,7 @@ static void avrcp_list_player_attributes_dump(int level, struct frame *frm,
 static const char *value2str(uint8_t attr, uint8_t value)
 {
 	switch (attr) {
-	case AVRCP_ATTRIBUTE_ILEGAL:
+	case AVRCP_ATTRIBUTE_ILLEGAL:
 		return "Illegal";
 	case AVRCP_ATTRIBUTE_EQUALIZER:
 		switch (value) {
diff --git a/unit/avrcp-lib.c b/unit/avrcp-lib.c
index 720775fd2603..1549f8145d5f 100644
--- a/unit/avrcp-lib.c
+++ b/unit/avrcp-lib.c
@@ -717,7 +717,7 @@ static bool check_attributes(uint8_t number, const uint8_t *attrs)
 
 	for (i = 0; i < number; i++) {
 		if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
-					attrs[i] == AVRCP_ATTRIBUTE_ILEGAL)
+					attrs[i] == AVRCP_ATTRIBUTE_ILLEGAL)
 			return false;
 	}
 
@@ -765,7 +765,7 @@ static ssize_t list_values(struct avrcp *session, uint8_t transaction,
 
 	req = (void *) params;
 	if (req->attr > AVRCP_ATTRIBUTE_LAST ||
-					req->attr == AVRCP_ATTRIBUTE_ILEGAL)
+					req->attr == AVRCP_ATTRIBUTE_ILLEGAL)
 		return -EINVAL;
 
 	if (!player->ind || !player->ind->list_values)
@@ -828,7 +828,7 @@ static ssize_t get_value_text(struct avrcp *session, uint8_t transaction,
 		return -EINVAL;
 
 	if (req->number > AVRCP_ATTRIBUTE_LAST ||
-					req->number == AVRCP_ATTRIBUTE_ILEGAL)
+					req->number == AVRCP_ATTRIBUTE_ILLEGAL)
 		return -EINVAL;
 
 	if (!check_value(req->attr, req->number, req->values))
@@ -3138,7 +3138,7 @@ int avrcp_get_player_attribute_text_rsp(struct avrcp *session,
 		uint8_t len = 0;
 
 		if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
-					attrs[i] == AVRCP_ATTRIBUTE_ILEGAL)
+					attrs[i] == AVRCP_ATTRIBUTE_ILLEGAL)
 			return -EINVAL;
 
 		if (text[i])
diff --git a/unit/avrcp-lib.h b/unit/avrcp-lib.h
index 5adb321880e8..3979dcaa13a4 100644
--- a/unit/avrcp-lib.h
+++ b/unit/avrcp-lib.h
@@ -69,7 +69,7 @@
 #define CAP_EVENTS_SUPPORTED			0x03
 
 /* Player Attributes */
-#define AVRCP_ATTRIBUTE_ILEGAL			0x00
+#define AVRCP_ATTRIBUTE_ILLEGAL			0x00
 #define AVRCP_ATTRIBUTE_EQUALIZER		0x01
 #define AVRCP_ATTRIBUTE_REPEAT_MODE		0x02
 #define AVRCP_ATTRIBUTE_SHUFFLE			0x03
-- 
2.55.0

