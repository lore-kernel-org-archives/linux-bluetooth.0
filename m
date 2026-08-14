Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA73502A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716134; cv=none; b=E1OhR1oN+uUfJy3KgeeXZhgPVNXqompF6R+1mjmyfz4q6NH3RmCA4JT814hVtO9OcBuhgzSOQY0MNDOHUeblphJMh9+ZK21dOu9hcJqzTqBptVY9xjO4o+fuv4WezQpPX3TKy5zYR4aFZe4w4zt7DTFAnT/HR33buOG/VAtj9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716134; c=relaxed/simple;
	bh=xh82+Jm0NUTr6k9ShpyZatN16eyeZ7OvQGaFDvPxE2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGCcBlF9wgZ58Q5+ZCcE068b6+wDM5qgYx4eDPsvTAxJt5Bj4B+HI+6rJuvtfiWtO3RfDuE7RIr/8e2VWsuQ2x2MnNsZR6GZR325XmdkQMZeQ0OAh1/ZIRJLUKTVgP3mgGCND4vLrZHqBTggcb/nvXVp1KygbulsrM48q9/TMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C76173EDDE;
	Fri, 14 Aug 2026 14:02:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Elman Shahbazov <shahbazovelman97@gmail.com>
Subject: [BlueZ, v4] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Fri, 14 Aug 2026 16:01:18 +0200
Message-ID: <20260814140155.3155081-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEsmni5kVUgIrGxR6BiKNetUVryFs052QiPScEqtW+YjKTEby7E+F5TsJQ8ED3fRvhG1YkLAtn/6LJZ/EX+TqkPV2Yy2BvwnvQvnA/jYa51OOL+ZOzulrQMLXc6UFG2YK4itLbYqkG0WLE5jc8DROcbNx8CAfgmgymZ0tw/G5cghlABgeljJUmwRUB+oGzOB5yGVaw4oxEtqFNrl/vkgXn0iOdPoM7aoOkQ6XO0W3JZO++CCrO2kYmSCQbGHcp1KKlx3oW2sVu3HeiHDa1HL+zfYcUgY4Y3xMh9UJUiUW0dL3ZjFBL7FJ6ErlBU0Zy9OZMffw8kZmjiO8QrKpxpeG3apmCP+FatI81aWtfhwrlq1yBnOfEuk6Fc2VQEnUtt+Rmkf7v3OA6pxRa60kmtTwKMFrCao7Gv2lheyqmkPuHDkuKLVkoXs+2bY+xUX+jCCAqcrQKPrxlNsY5NKSaojFcuDiSYX3QbskmSr8O0wnusgVs53rVZ7kTfrnSEgfYjZuVc2luFZgzRnrjtNHCxcI0et69TnKLhXi4aSKmmdvv6iKY9uQhCAmrx7GRxyx3WA6fiqd+I5dmopnSc1nnJity7QqymeEHBL9LOdPMCdzQYAhywGz9+JfVM2caGdH0g9/nKnFotFTgL8Co9oA+24ubCfj/ldZw5lkj7mh8nJco1kA
X-GND-State: clean
X-GND-Score: -100

If the "Displayable Name Length" is much longer than the size of the PDU
packet we receive, then we might try to memcpy() past the end of the PDU
packet.

Be careful about clamping the name copying to the smallest of:
- length specified in the PDU
- left-over packet after the length field
- size of the string we'll copy it into

Reported-by: Elman Shahbazov <shahbazovelman97@gmail.com>
---
 profiles/audio/avrcp.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2194a913580f..23e959c76917 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -145,6 +145,8 @@
 #define AVRCP_SCOPE_SEARCH				0x02
 #define AVRCP_SCOPE_NOW_PLAYING			0x03
 
+#define NAME_MAX_LEN 255
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -2608,30 +2610,45 @@ static const char *subtype_to_string(uint32_t subtype)
 	return "None";
 }
 
+static gboolean parse_media_name(uint8_t *operands, uint16_t len,
+				size_t name_len_offset,
+				char *name, uint16_t *namelen)
+{
+	uint16_t namesize;
+
+	if (len < name_len_offset + 2)
+		return FALSE;
+
+	memset(name, 0, NAME_MAX_LEN);
+	namesize = MIN(get_be16(&operands[name_len_offset]),
+			len - name_len_offset - 2);
+	namesize = MIN(namesize, NAME_MAX_LEN - 1);
+	if (*namelen > 0) {
+		if (len < name_len_offset + 2 + namesize)
+			return FALSE;
+		memcpy(name, &operands[name_len_offset + 2], namesize);
+		strtoutf8(name, namesize);
+	}
+	if (namelen)
+		*namelen = namesize;
+	return TRUE;
+}
+
 static struct media_item *parse_media_element(struct avrcp *session,
 					uint8_t *operands, uint16_t len)
 {
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
+	if (!parse_media_name(operands, len, 11, name, &namesize))
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
@@ -2655,24 +2672,18 @@ static struct media_item *parse_media_folder(struct avrcp *session,
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
+	if (!parse_media_name(operands, len, 12, name, NULL))
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

