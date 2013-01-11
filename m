Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 04/11] transport: Get volume from transport
Date: Fri, 11 Jan 2013 17:25:27 -0300
Message-Id: <1357935934-20033-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 6 ++++++
 profiles/audio/transport.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f3caa1b..4a81d85 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -849,6 +849,12 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
+uint16_t media_transport_get_volume(struct media_transport *transport)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	return a2dp->volume;
+}
+
 void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index a6b71e5..0fe8973 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -32,6 +32,7 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 struct audio_device *media_transport_get_dev(struct media_transport *transport);
+uint16_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
-- 
1.7.11.7

