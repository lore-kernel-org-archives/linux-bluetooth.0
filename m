Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 13/16] android/hal-sock: Send RFCOMM channel to framework
Date: Fri, 15 Nov 2013 16:37:55 +0200
Message-Id: <1384526278-26260-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Framework expects channel to be send.
---
 android/socket.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index c3ce4f0..cc1bbb7 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -472,6 +472,11 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
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

