Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] gdbus: Fix incorrectly discarded signals
Date: Tue, 22 May 2012 14:12:36 +0200
Message-Id: <1337688756-1938-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Signals with no arguments were incorrectly filtered out due to the NULL
inequality check.
---
 gdbus/object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2dd7c0e..c33df57 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -616,7 +616,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 		}
 	}
 
-	if (*args == NULL) {
+	if (!signal || !signal->name) {
 		error("No signal named %s on interface %s", name, interface);
 		return FALSE;
 	}
-- 
1.7.7.6

