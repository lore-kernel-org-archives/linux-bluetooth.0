Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 01/10] Add a_header struct for additional header data
Date: Sun, 19 Jun 2011 02:59:37 +0200
Message-Id: <1308445186-27135-2-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-xfer.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
index 5a88b13..9bc832d 100644
--- a/gwobex/obex-xfer.h
+++ b/gwobex/obex-xfer.h
@@ -82,6 +82,12 @@ struct gw_obex_xfer {
     GSource                 *idle_source;
 };
 
+struct a_header {
+    uint8_t hi;
+    obex_headerdata_t hv;
+    uint32_t hv_size;
+};
+
 struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
 
 void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
-- 
1.7.0.4

