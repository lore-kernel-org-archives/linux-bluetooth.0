Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 12/19] android/socket: Send RFCOMM channel to framework
Date: Tue, 19 Nov 2013 15:30:02 +0200
Message-Id: <1384867809-18135-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Framework expects channel to be send.
---
 android/socket.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index ad09a2c..e620d10 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -493,6 +493,11 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		goto fail;
+	}
+
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
 	rfsock->channel = chan;
 	connections = g_list_append(connections, rfsock);
-- 
1.7.10.4

