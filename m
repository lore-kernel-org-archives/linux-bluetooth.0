Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] gdbus: Remove not needed NULL pointer checks
Date: Wed, 21 Nov 2012 11:21:03 +0100
Message-ID: <1353493263-18191-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_strdup returns NULL if argument passed is NULL and there is no need
to double check that.
---
 gdbus/watch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 07feb61..1cd1211 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -240,8 +240,8 @@ proceed:
 	data = g_new0(struct filter_data, 1);
 
 	data->connection = dbus_connection_ref(connection);
-	data->name = name ? g_strdup(name) : NULL;
-	data->owner = owner ? g_strdup(owner) : NULL;
+	data->name = g_strdup(name);
+	data->owner = g_strdup(owner);
 	data->path = g_strdup(path);
 	data->interface = g_strdup(interface);
 	data->member = g_strdup(member);
-- 
1.7.9.5

