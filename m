Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] convert error to btd_error_busy()
Date: Wed,  8 Dec 2010 18:25:58 -0200
Message-Id: <1291839961-14940-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/source.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/audio/source.c b/audio/source.c
index a6fd8e7..9b9dab7 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -425,8 +425,7 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 		return btd_error_not_connected(msg);
 
 	if (source->connect || source->disconnect)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(EBUSY));
+		return btd_error_busy(msg);
 
 	if (source->stream_state < AVDTP_STATE_OPEN) {
 		DBusMessage *reply = dbus_message_new_method_return(msg);
-- 
1.7.3.2

