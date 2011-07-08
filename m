Return-Path: <cyrus@holtmann.org>
From: lukasz.rymanowski@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: pkorn@gmx.net, luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Subject: [PATCH] Fix for headset state callback
Date: Fri,  8 Jul 2011 08:12:49 +0200
Message-Id: <1310105569-23441-1-git-send-email-lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>

Headset watch is not registered per device.
Therefore, when headset disconnects, there is need to
check for which audio device it is called.
---
 audio/media.c     |    7 ++++++-
 audio/transport.c |    5 +++++
 audio/transport.h |    1 +
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 3978a17..57bf7c9 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -167,7 +167,12 @@ static void headset_state_changed(struct audio_device *dev,
 
 	switch (new_state) {
 	case HEADSET_STATE_DISCONNECTED:
-		media_endpoint_clear_configuration(endpoint);
+		if (endpoint->transport &&
+			media_transport_get_dev(endpoint->transport) == dev) {
+
+			DBG("Clear endpoint %p", endpoint);
+			media_endpoint_clear_configuration(endpoint);
+		}
 		break;
 	case HEADSET_STATE_CONNECTING:
 		media_endpoint_set_configuration(endpoint, dev, NULL, 0,
diff --git a/audio/transport.c b/audio/transport.c
index 7c99207..cd2de37 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -918,3 +918,8 @@ void media_transport_update_delay(struct media_transport *transport,
 				MEDIA_TRANSPORT_INTERFACE, "Delay",
 				DBUS_TYPE_UINT16, &transport->delay);
 }
+
+struct audio_device *media_transport_get_dev(struct media_transport *transport)
+{
+	return transport->device;
+}
\ No newline at end of file
diff --git a/audio/transport.h b/audio/transport.h
index be4d666..1f86cde 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -32,6 +32,7 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
+struct audio_device *media_transport_get_dev(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void transport_get_properties(struct media_transport *transport,
-- 


