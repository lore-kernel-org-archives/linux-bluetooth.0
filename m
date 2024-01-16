Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF821BDE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq6AoN3v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0F11C43142;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=IzvUTumHXOfkV/ry8X9/6+DvfQ+Xg4pAZnneqSWRREk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gq6AoN3vQWw38kdu8RGEzRrKnIuG9+BQDtVKMj9jNIRtjtiIUzgbpFnLZcVtYXomZ
	 +geGfYISf+NHEP2zMU+JTeJfrthV8pam35Ik3cKRVdxG3lIpUjLL1woSD25a0vx+Ut
	 BmInnGMSNCbm0Mi8KAYr97YkDVqdBTvumTz6iqQ2xGO4KqjiQf6ZfOhUvj92lBn5ix
	 QJ3IKUee7ZJzxaxo566ilQ4yek2sg8WU+wjt/0+WBys2zzl2RdejtYwjqydqIP3UaF
	 E4excrkBSi5pOU44uBU67CAmkfz5pj79o3DTVWvD89aGBYPFBXnasQA3Hz/1XpDfLK
	 nGEe6geuhBUcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED0BC47DA6;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:38 +0000
Subject: [PATCH BlueZ 13/20] lib: const annotate tupla instances and API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-13-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=2511;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=jDi4yeZBNrEVszZnWoWgZxRy4Pha0pVHgMKoCcz3L8I=;
 b=oElQ0FaEz0C869vXKMWPjsbjXYUTIwNGgSZni9WiZK5IhI+4OqCrU7V8exHYsioHzC1td2d/T
 81CI9qrwPPGDzuax5h/DEmc7gI3DK7eEi2x8CoMLyeZegekZT32hO8m
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 lib/sdp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index dfc06b6df..5475c7eba 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -47,7 +47,7 @@
 #define SDPDBG(fmt...)
 #endif
 
-static uint128_t bluetooth_base_uuid = {
+static const uint128_t bluetooth_base_uuid = {
 	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
 };
@@ -65,10 +65,10 @@ static int sdp_gen_buffer(sdp_buf_t *buf, sdp_data_t *d);
 /* Message structure. */
 struct tupla {
 	int index;
-	char *str;
+	const char *str;
 };
 
-static struct tupla Protocol[] = {
+static const struct tupla Protocol[] = {
 	{ SDP_UUID,		"SDP"		},
 	{ UDP_UUID,		"UDP"		},
 	{ RFCOMM_UUID,		"RFCOMM"	},
@@ -97,7 +97,7 @@ static struct tupla Protocol[] = {
 	{ 0 }
 };
 
-static struct tupla ServiceClass[] = {
+static const struct tupla ServiceClass[] = {
 	{ SDP_SERVER_SVCLASS_ID,		"SDP Server"			},
 	{ BROWSE_GRP_DESC_SVCLASS_ID,		"Browse Group Descriptor"	},
 	{ PUBLIC_BROWSE_GROUP,			"Public Browse Group"		},
@@ -176,9 +176,9 @@ static struct tupla ServiceClass[] = {
 
 #define Profile ServiceClass
 
-static char *string_lookup(struct tupla *pt0, int index)
+static const char *string_lookup(const struct tupla *pt0, int index)
 {
-	struct tupla *pt;
+	const struct tupla *pt;
 
 	for (pt = pt0; pt->index; pt++)
 		if (pt->index == index)
@@ -187,7 +187,7 @@ static char *string_lookup(struct tupla *pt0, int index)
 	return "";
 }
 
-static char *string_lookup_uuid(struct tupla *pt0, const uuid_t *uuid)
+static const char *string_lookup_uuid(const struct tupla *pt0, const uuid_t *uuid)
 {
 	uuid_t tmp_uuid;
 
@@ -209,9 +209,9 @@ static char *string_lookup_uuid(struct tupla *pt0, const uuid_t *uuid)
  * Prints into a string the Protocol UUID
  * coping a maximum of n characters.
  */
-static int uuid2str(struct tupla *message, const uuid_t *uuid, char *str, size_t n)
+static int uuid2str(const struct tupla *message, const uuid_t *uuid, char *str, size_t n)
 {
-	char *str2;
+	const char *str2;
 
 	if (!uuid) {
 		snprintf(str, n, "NULL");
@@ -2763,7 +2763,7 @@ uuid_t *sdp_uuid_to_uuid128(const uuid_t *uuid)
  */
 int sdp_uuid128_to_uuid(uuid_t *uuid)
 {
-	uint128_t *b = &bluetooth_base_uuid;
+	const uint128_t *b = &bluetooth_base_uuid;
 	uint128_t *u = &uuid->value.uuid128;
 	uint32_t data;
 	unsigned int i;

-- 
2.43.0

