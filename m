Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 16/22] network: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:01 -0300
Message-Id: <1328910007-25604-17-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 network/server.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/network/server.c b/network/server.c
index 6e0ce09..67d81e3 100644
--- a/network/server.c
+++ b/network/server.c
@@ -322,13 +322,13 @@ static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
 
 	switch (req->uuid_size) {
 	case 2: /* UUID16 */
-		*dst_role = ntohs(bt_get_unaligned((uint16_t *) dest));
-		*src_role = ntohs(bt_get_unaligned((uint16_t *) source));
+		*dst_role = bt_get_be16(dest);
+		*src_role = bt_get_be16(source);
 		break;
 	case 4: /* UUID32 */
 	case 16: /* UUID128 */
-		*dst_role = ntohl(bt_get_unaligned((uint32_t *) dest));
-		*src_role = ntohl(bt_get_unaligned((uint32_t *) source));
+		*dst_role = bt_get_be32(dest);
+		*src_role = bt_get_be32(source);
 		break;
 	default:
 		return BNEP_CONN_INVALID_SVC;
-- 
1.7.8.1

