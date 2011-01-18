Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Add Routing property to MediaTransport interface
Date: Tue, 18 Jan 2011 12:00:14 +0200
Message-Id: <1295344815-1404-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should indicate to the endpoint what routing the transport is using
---
 audio/transport.c |    4 ++++
 doc/media-api.txt |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index d575590..b5a9e48 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -599,12 +599,16 @@ static void get_properties_headset(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
 	gboolean nrec, inband;
+	const char *routing;
 
 	nrec = headset_get_nrec(transport->device);
 	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &nrec);
 
 	inband = headset_get_inband(transport->device);
 	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
+
+	routing = headset_get_sco_hci(transport->device) ? "HCI" : "PCM";
+	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
 }
 
 void transport_get_properties(struct media_transport *transport,
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 92b8b3f..84903d6 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -152,3 +152,9 @@ Properties	object Device [readonly]
 			Optional. Indicates if the transport support sending
 			ringtones, this property is only writeable when the
 			transport was acquired by the sender.
+
+		string Routing [readonly]
+
+			Optional. Indicates where is the transport being routed
+
+			Possible Values: "HCI" or "PCM"
-- 
1.7.1

