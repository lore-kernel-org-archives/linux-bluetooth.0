Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 05/14] Convert to network order before use it on sdp_uuid128_to_uuid
Date: Fri, 18 Feb 2011 20:29:24 -0200
Message-Id: <1298068173-16518-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index d5f8984..3c4cd50 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2713,18 +2713,19 @@ uuid_t *sdp_uuid_to_uuid128(const uuid_t *uuid)
 int sdp_uuid128_to_uuid(uuid_t *uuid)
 {
 	uint128_t *b = &bluetooth_base_uuid;
-	uint128_t *u = &uuid->value.uuid128;
+	uint128_t u;
 	uint32_t data;
 	unsigned int i;
 
+	hton128(&uuid->value.uuid128, &u);
 	if (uuid->type != SDP_UUID128)
 		return 1;
 
 	for (i = 4; i < sizeof(b->data); i++)
-		if (b->data[i] != u->data[i])
+		if (b->data[i] != u.data[i])
 			return 0;
 
-	memcpy(&data, u->data, 4);
+	memcpy(&data, u.data, 4);
 	data = htonl(data);
 	if (data <= 0xffff) {
 		uuid->type = SDP_UUID16;
-- 
1.7.4.1

