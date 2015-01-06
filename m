Return-Path: <cyrus@holtmann.org>
From: Jeroen Sack <maillist@jeroensack.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Jeroen Sack <maillist@jeroensack.nl>
Subject: [PATCH 2/3] tools/sdptool: Fix UUID128 format in tree output
Date: Tue,  6 Jan 2015 23:32:23 +0100
Message-Id: <1420583544-9796-2-git-send-email-maillist@jeroensack.nl>
In-Reply-To: <1420583544-9796-1-git-send-email-maillist@jeroensack.nl>
References: <1420583544-9796-1-git-send-email-maillist@jeroensack.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write UUID128 in format used in the rest of the code when
showing sdp records in tree format.

---
 tools/sdptool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index a65fc95..8057551 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -445,7 +445,7 @@ static void sdp_uuid_printf(uuid_t *uuid, struct attrib_context *context, int in
 			memcpy(&data4, &uuid->value.uuid128.data[10], 4);
 			memcpy(&data5, &uuid->value.uuid128.data[14], 2);
 
-			printf("%.*sUUID128 : 0x%.8x-%.4x-%.4x-%.4x-%.8x-%.4x\n",
+			printf("%.*sUUID128 : %.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
 				indent, indent_spaces,
 				ntohl(data0), ntohs(data1), ntohs(data2),
 				ntohs(data3), ntohl(data4), ntohs(data5));
-- 
2.1.4

