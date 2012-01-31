Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/6] device: Fix not using the same way for pairing LE devices
Date: Tue, 31 Jan 2012 14:10:51 -0300
Message-Id: <1328029853-21134-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that both backends (hciops and mgmtops) are capable
of pairing LE devices, we don't have to force the procedure.
---
 src/adapter.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d5075db..25f70ff 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1578,15 +1578,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 			return btd_error_failed(msg, strerror(-err));
 	}
 
-	if (device_is_bredr(device))
-		return device_create_bonding(device, conn, msg,
-							agent_path, cap);
-
-	err = device_browse_primary(device, conn, msg, TRUE);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	return NULL;
+	return device_create_bonding(device, conn, msg, agent_path, cap);
 }
 
 static gint device_path_cmp(struct btd_device *device, const gchar *path)
-- 
1.7.8.1

