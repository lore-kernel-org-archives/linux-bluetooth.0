Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 13/16] android/socket: Send RFCOMM channel to framework
Date: Mon, 18 Nov 2013 10:26:16 +0200
Message-Id: <1384763179-2218-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Framework expects channel to be send.
---
 android/socket.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 063681e..39935e8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -477,6 +477,11 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	if (write(rfslot->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		goto fail;
+	}
+
 	rfslot->real_sock = g_io_channel_unix_get_fd(io);
 	rfslot->channel = chan;
 	rfcomm_connected_list = g_list_append(rfcomm_connected_list, rfslot);
-- 
1.7.10.4

