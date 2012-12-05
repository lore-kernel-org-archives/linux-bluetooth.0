Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/9] avctp: Convert avctp_connect to accept audio_device
Date: Wed, 5 Dec 2012 11:10:18 +0100
Message-ID: <1354702224-15895-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use addresses taken from btd_dev reference in audio_device to get
session source and destination.
---
 profiles/audio/avctp.c   |    7 ++++++-
 profiles/audio/avctp.h   |    2 +-
 profiles/audio/avrcp.c   |    4 ++--
 profiles/audio/control.c |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index dcffb05..6752cef 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1594,11 +1594,16 @@ gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
-struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
+struct avctp *avctp_connect(struct audio_device *device)
 {
 	struct avctp *session;
 	GError *err = NULL;
 	GIOChannel *io;
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
+	src = adapter_get_address(device_get_adapter(device->btd_dev));
+	dst = device_get_address(device->btd_dev);
 
 	session = avctp_get_internal(src, dst);
 	if (!session)
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index c00a3fc..7314a04 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -93,7 +93,7 @@ gboolean avctp_remove_state_cb(unsigned int id);
 int avctp_register(const bdaddr_t *src, gboolean master);
 void avctp_unregister(const bdaddr_t *src);
 
-struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst);
+struct avctp *avctp_connect(struct audio_device *device);
 struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2517df8..f6a5ac9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2173,7 +2173,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	session = g_new0(struct avrcp, 1);
 	session->server = server;
-	session->conn = avctp_connect(&dev->src, &dev->dst);
+	session->conn = avctp_connect(dev);
 	session->dev = dev;
 
 	server->sessions = g_slist_append(server->sessions, session);
@@ -2254,7 +2254,7 @@ gboolean avrcp_connect(struct audio_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_connect(&dev->src, &dev->dst);
+	session = avctp_connect(dev);
 	if (session)
 		return FALSE;
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 7299b7e..5b16e17 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -141,7 +141,7 @@ int control_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	if (control->connect)
 		return -EINPROGRESS;
 
-	control->session = avctp_connect(&dev->src, &dev->dst);
+	control->session = avctp_connect(dev);
 	if (!control->session)
 		return -EIO;
 
-- 
1.7.9.5

