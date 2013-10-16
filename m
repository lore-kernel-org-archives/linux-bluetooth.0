Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] sdp: Check that correct packet received in recv
Date: Wed, 16 Oct 2013 11:46:50 +0300
Message-Id: <1381913215-17957-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-sdp.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 6d699e2..4726b8b 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -145,8 +145,7 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 	struct context *context = user_data;
 	sdp_pdu_hdr_t hdr;
 	void *buf;
-	size_t size;
-	ssize_t len;
+	ssize_t len, size;
 	int fd;
 
 	fd = g_io_channel_unix_get_fd(channel);
@@ -169,7 +168,7 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 		return TRUE;
 
 	len = recv(fd, buf, size, 0);
-	if (len <= 0) {
+	if (len != size) {
 		sdp_svcdb_collect_all(fd);
 		free(buf);
 		return FALSE;
-- 
1.7.10.4

