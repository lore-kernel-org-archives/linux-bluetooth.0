Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] audio: Add Volume property to A2DP transport GetProperties
Date: Fri, 25 May 2012 18:02:48 +0300
Message-Id: <1337958168-9875-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that volume is being handled by SetProperty it should also be
available in GetProperties.
---
 audio/transport.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index bf86390..4273282 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -858,6 +858,10 @@ static void get_properties_a2dp(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
 	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &transport->delay);
+
+	if (transport->volume <= 127)
+		dict_append_entry(dict, "Volume", DBUS_TYPE_UINT16,
+							&transport->volume);
 }
 
 static void get_properties_headset(struct media_transport *transport,
@@ -1013,6 +1017,7 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	transport->size = size;
 	transport->path = g_strdup_printf("%s/fd%d", device->path, fd++);
 	transport->fd = -1;
+	transport->volume = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
-- 
1.7.7.6

