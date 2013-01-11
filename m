Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 06/11] transport: Get volume passing only audio_device
Date: Fri, 11 Jan 2013 17:25:29 -0300
Message-Id: <1357935934-20033-7-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 20 ++++++++++++++++++++
 profiles/audio/transport.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c3e26f4..9419af0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -876,3 +876,23 @@ void media_transport_update_volume(struct media_transport *transport,
 					transport->path,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
+
+uint8_t media_transport_get_device_volume(struct audio_device *dev)
+{
+	GSList *l;
+
+	if (dev == NULL)
+		return 128;
+
+	for (l = transports; l; l = l->next) {
+		struct media_transport *transport = l->data;
+		if (transport->device != dev)
+			continue;
+
+		/* Volume is A2DP only */
+		if (media_endpoint_get_sep(transport->endpoint))
+			return media_transport_get_volume(transport);
+	}
+
+	return 128;
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 0fe8973..78c6fa7 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -39,3 +39,5 @@ void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
+
+uint8_t media_transport_get_device_volume(struct audio_device *dev);
-- 
1.7.11.7

