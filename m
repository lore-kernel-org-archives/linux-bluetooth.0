Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 2/4] gobex: make default response function public
Date: Wed, 21 Dec 2011 02:41:01 +0100
Message-Id: <1324431663-3800-3-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
References: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow response functions outside gobex to fall back
to the default behavior if desired.
---
 gobex/gobex-transfer.c |    2 +-
 gobex/gobex.h          |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 57eb37b..2595128 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -171,7 +171,7 @@ static gboolean handle_get_body(GObexTransfer *transfer, GObexPacket *rsp,
 	return ret;
 }
 
-static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	GObexTransfer *transfer = user_data;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 3403444..b07e8df 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -120,6 +120,9 @@ guint g_obex_get_rsp(GObex *obex, GObexDataProducer data_func,
 
 gboolean g_obex_cancel_transfer(guint id);
 
+void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data);
+
 const char *g_obex_strerror(guint8 err_code);
 
 #endif /* __GOBEX_H */
-- 
1.7.4.1

