Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] unit: Fix compilation issue with ignored return value
Date: Fri,  4 Jan 2013 09:47:02 -0400
Message-Id: <1357307222-4563-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix this compilation warning:

unit/test-sdp.c: In function ‘send_pdu’:
unit/test-sdp.c:600:7: error: ignoring return value of ‘write’, declared
with attribute warn_unused_result [-Werror=unused-result]
---
 unit/test-sdp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index baa93d0..1a852de 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -596,8 +596,10 @@ struct test_data {
 static gboolean send_pdu(gpointer user_data)
 {
 	struct context *context = user_data;
+	ssize_t len;
 
-	write(context->fd, context->req_data, context->req_size);
+	len = write(context->fd, context->req_data, context->req_size);
+	g_assert(len > 0 && (size_t) len == context->req_size);
 
 	return FALSE;
 }
-- 
1.7.9.5

