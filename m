Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] attrib: Fix compilation errors when compiled without optimization
Date: Tue,  8 Jan 2013 11:46:27 -0400
Message-Id: <1357659987-4219-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix these build errors:

attrib/att.c: In function ‘dec_read_by_grp_req’:
attrib/att.c:165:10: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
attrib/att.c:170:10: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
attrib/att.c: In function ‘dec_read_by_type_req’:
attrib/att.c:393:10: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
attrib/att.c:402:10: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
---
 attrib/att.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index de11811..fe66821 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -151,7 +151,7 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 						uint16_t *end, bt_uuid_t *uuid)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
 
 	if (pdu == NULL)
 		return 0;
@@ -382,7 +382,7 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 						uint16_t *end, bt_uuid_t *uuid)
 {
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
 
 	if (pdu == NULL)
 		return 0;
-- 
1.7.9.5

