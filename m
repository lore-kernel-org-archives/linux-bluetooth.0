Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/9] avrcp: Don't use audio_device src field
Date: Wed, 5 Dec 2012 11:10:23 +0100
Message-ID: <1354702224-15895-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use address from btd_dev reference in audio_device to get source
address.
---
 profiles/audio/avrcp.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d5f23da..06b524e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2217,8 +2217,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
+	const bdaddr_t *src;
 
-	server = find_server(servers, &dev->src);
+	src = adapter_get_address(device_get_adapter(dev->btd_dev));
+
+	server = find_server(servers, src);
 	if (!server)
 		return;
 
@@ -2445,8 +2448,11 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 	struct avrcp *session;
 	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
 	struct avrcp_header *pdu = (void *) buf;
+	const bdaddr_t *src;
 
-	server = find_server(servers, &dev->src);
+	src = adapter_get_address(device_get_adapter(dev->btd_dev));
+
+	server = find_server(servers, src);
 	if (server == NULL)
 		return -EINVAL;
 
-- 
1.7.9.5

