Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/9] avctp: Convert avctp_get to accept audio_device
Date: Wed, 5 Dec 2012 11:10:19 +0100
Message-ID: <1354702224-15895-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use addresses taken from btd_dev reference in audio_device to get
session source and destination.
---
 profiles/audio/avctp.c   |    8 +++++++-
 profiles/audio/avctp.h   |    2 +-
 profiles/audio/avrcp.c   |    2 +-
 profiles/audio/control.c |    2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6752cef..a7daef3 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1671,7 +1671,13 @@ void avctp_disconnect(struct avctp *session)
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
-struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst)
+struct avctp *avctp_get(struct audio_device *device)
 {
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
+	src = adapter_get_address(device_get_adapter(device->btd_dev));
+	dst = device_get_address(device->btd_dev);
+
 	return avctp_get_internal(src, dst);
 }
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 7314a04..2597e6e 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -94,7 +94,7 @@ int avctp_register(const bdaddr_t *src, gboolean master);
 void avctp_unregister(const bdaddr_t *src);
 
 struct avctp *avctp_connect(struct audio_device *device);
-struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst);
+struct avctp *avctp_get(struct audio_device *device);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f6a5ac9..d5f23da 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2265,7 +2265,7 @@ void avrcp_disconnect(struct audio_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_get(&dev->src, &dev->dst);
+	session = avctp_get(dev);
 	if (!session)
 		return;
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 5b16e17..fea49b6 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -110,7 +110,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (control->session)
 			break;
 
-		control->session = avctp_get(&dev->src, &dev->dst);
+		control->session = avctp_get(dev);
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-- 
1.7.9.5

