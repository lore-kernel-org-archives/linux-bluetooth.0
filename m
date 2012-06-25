Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 2/3] telephony-ofono: Fix listening for signals
Date: Mon, 25 Jun 2012 12:44:41 -0300
Message-Id: <1340639082-10347-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
 <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should listen for signals only on oFono bus name.
---
 audio/telephony-ofono.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 961fedd..67eb87b 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -742,7 +742,7 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 
 	vc = g_new0(struct voice_call, 1);
 	vc->obj_path = g_strdup(path);
-	vc->watch = g_dbus_add_signal_watch(connection, NULL, path,
+	vc->watch = g_dbus_add_signal_watch(connection, OFONO_BUS_NAME, path,
 					OFONO_VC_INTERFACE, "PropertyChanged",
 					handle_vc_property_changed, vc, NULL);
 
-- 
1.7.11

