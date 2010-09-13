Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Remove local cache for nrec and inband
Date: Mon, 13 Sep 2010 17:15:36 +0300
Message-Id: <1284387337-18822-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Those can be acessed directly from device/headset.
---
 audio/transport.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 0da99e8..6d08677 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -72,8 +72,6 @@ struct media_transport {
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;		/* Transport delay (a2dp only) */
-	gboolean		nrec;		/* Transport nrec (hfp only) */
-	gboolean		inband;		/* Transport inband ringtone support (hfp only) */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -519,10 +517,13 @@ static void get_properties_a2dp(struct media_transport *transport,
 static void get_properties_headset(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
-	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &transport->nrec);
+	gboolean nrec, inband;
 
-	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN,
-							&transport->inband);
+	nrec = headset_get_nrec(transport->device);
+	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &nrec);
+
+	inband = headset_get_inband(transport->device);
+	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
 }
 
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
-- 
1.7.1

