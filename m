Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/9] avctp: Don't use audio_device src and dst in avctp_control_confirm
Date: Wed, 5 Dec 2012 11:10:20 +0100
Message-ID: <1354702224-15895-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use src and dst addresses from btd_dev reference.
---
 profiles/audio/avctp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index a7daef3..e29527f 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1055,6 +1055,9 @@ static struct avctp *avctp_get_internal(const bdaddr_t *src,
 static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 						struct audio_device *dev)
 {
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
 	if (session->control != NULL) {
 		error("Control: Refusing unexpected connect");
 		g_io_channel_shutdown(chan, TRUE, NULL);
@@ -1064,7 +1067,10 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 	session->control = avctp_channel_create(session, chan);
 
-	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
+	src = adapter_get_address(device_get_adapter(dev->btd_dev));
+	dst = device_get_address(dev->btd_dev);
+
+	session->auth_id = btd_request_authorization(src, dst,
 							AVRCP_TARGET_UUID,
 							auth_cb, session);
 	if (session->auth_id == 0)
-- 
1.7.9.5

