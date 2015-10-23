Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] audio: Fix mtu input order
Date: Sat, 24 Oct 2015 01:14:27 +0900
Message-id: <1445616867-7008-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes imtu,omtu input order in avdtp_stream_set_transport().
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 9121dab..b0fea7c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1457,7 +1457,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	if (!avdtp_stream_set_transport(setup->stream,
 					g_io_channel_unix_get_fd(io),
-					omtu, imtu))
+					imtu, omtu))
 		goto drop;
 
 	g_io_channel_set_close_on_unref(io, FALSE);
-- 
2.5.0

