Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 12/14] thermometer: Fix whitespace
Date: Tue, 25 Sep 2012 16:52:41 +0200
Message-ID: <1348584763-22824-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f42ab7d..7c9cd0e 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -634,7 +634,7 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static void write_interval_cb (guint8 status, const guint8 *pdu, guint16 len,
+static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct tmp_interval_data *data = user_data;
-- 
1.7.11.3

