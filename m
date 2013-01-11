Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 09/11] transport: Update volume passing only audio_device
Date: Fri, 11 Jan 2013 17:25:32 -0300
Message-Id: <1357935934-20033-10-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 19 +++++++++++++++++++
 profiles/audio/transport.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9419af0..c344a92 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -896,3 +896,22 @@ uint8_t media_transport_get_device_volume(struct audio_device *dev)
 
 	return 128;
 }
+
+void media_transport_update_device_volume(struct audio_device *dev,
+								uint8_t volume)
+{
+	GSList *l;
+
+	if (dev == NULL)
+		return;
+
+	for (l = transports; l; l = l->next) {
+		struct media_transport *transport = l->data;
+		if (transport->device != dev)
+			continue;
+
+		/* Volume is A2DP only */
+		if (media_endpoint_get_sep(transport->endpoint))
+			media_transport_update_volume(transport, volume);
+	}
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index cbbd0b6..b8cbf1f 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -42,3 +42,5 @@ void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
 uint8_t media_transport_get_device_volume(struct audio_device *dev);
+void media_transport_update_device_volume(struct audio_device *dev,
+								uint8_t volume);
-- 
1.7.11.7

