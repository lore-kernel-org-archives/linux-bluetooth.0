Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio: Add Volume property to A2DP transport GetProperties
Date: Tue, 22 May 2012 17:00:54 +0300
Message-Id: <1337695255-9197-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that volume is being handled by SetProperty it should also be
available in GetProperties.
---
 audio/transport.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index b4af0e7..3bc7a36 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -78,7 +78,7 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;		/* Transport delay (a2dp only) */
 	unsigned int		nrec_id;	/* Transport nrec watch (headset only) */
-	uint8_t			volume;		/* Transport volume */
+	int8_t			volume;		/* Transport volume */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -857,6 +857,10 @@ static void get_properties_a2dp(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
 	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &transport->delay);
+
+	if (transport->volume >= 0)
+		dict_append_entry(dict, "Volume", DBUS_TYPE_BYTE,
+							&transport->volume);
 }
 
 static void get_properties_headset(struct media_transport *transport,
@@ -1012,6 +1016,7 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	transport->size = size;
 	transport->path = g_strdup_printf("%s/fd%d", device->path, fd++);
 	transport->fd = -1;
+	transport->volume = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
-- 
1.7.7.6

