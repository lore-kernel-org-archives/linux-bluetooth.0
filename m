Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 4/7] media: Add Codecs property to MediaTransport
Date: Thu, 22 Mar 2012 17:37:52 +0100
Message-Id: <1332434275-25394-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/transport.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 7bf7309..38e44c2 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -840,7 +840,36 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 static void get_properties_a2dp(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
+	struct audio_device *device = transport->device;
+	uint8_t codecs[8];
+	void *pcodecs = codecs;
+	int ncodecs = 0, seid = 1;
+	struct avdtp_remote_sep *sep;
+	struct avdtp_service_capability *cap;
+	struct avdtp_media_codec_capability *ccap;
+
 	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &transport->delay);
+
+	if (transport->session == NULL)
+		transport->session = avdtp_get(&device->src, &device->dst);
+
+	if (transport->session == NULL)
+		return;
+
+	sep = avdtp_get_remote_sep(transport->session, seid);
+	while (sep) {
+		cap = avdtp_get_codec(sep);
+		ccap = (struct avdtp_media_codec_capability *) cap->data;
+
+		codecs[ncodecs++] = ccap->media_codec_type;
+
+		seid++;
+		sep = avdtp_get_remote_sep(transport->session, seid);
+	}
+
+	if (ncodecs > 0)
+		dict_append_array(dict, "Codecs",
+					DBUS_TYPE_BYTE, &pcodecs, ncodecs);
 }
 
 static void get_properties_headset(struct media_transport *transport,
-- 
1.7.5.4

