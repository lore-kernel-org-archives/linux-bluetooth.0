Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 4/6] obex: get src and dst address and store it
Date: Tue, 28 May 2013 14:45:21 -0300
Message-Id: <1369763123-17949-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This commit creates src and dst members in obex_session to later use them
to export via Session D-Bus API.
---
 obexd/src/obex-priv.h | 2 ++
 obexd/src/obex.c      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/obexd/src/obex-priv.h b/obexd/src/obex-priv.h
index 41854bc..355a7f8 100644
--- a/obexd/src/obex-priv.h
+++ b/obexd/src/obex-priv.h
@@ -27,6 +27,8 @@ struct obex_session {
 	uint32_t id;
 	uint8_t cmd;
 	uint8_t action_id;
+	char *src;
+	char *dst;
 	char *name;
 	char *destname;
 	char *type;
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 7a1d612..8a7a8a3 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -252,6 +252,9 @@ static void obex_session_free(struct obex_session *os)
 	if (os->obex)
 		g_obex_unref(os->obex);
 
+	g_free(os->src);
+	g_free(os->dst);
+
 	g_free(os);
 }
 
@@ -1134,6 +1137,9 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 	os->obex = obex;
 	os->io = g_io_channel_ref(io);
 
+	obex_getsockname(os, &os->src);
+	obex_getpeername(os, &os->dst);
+
 	sessions = g_slist_prepend(sessions, os);
 
 	return 0;
-- 
1.8.1.4

