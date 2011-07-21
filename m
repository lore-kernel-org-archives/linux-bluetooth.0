Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Fix finding mime driver by type
Date: Thu, 21 Jul 2011 12:56:39 +0200
Message-Id: <1311245799-8662-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

IrOBEX specification chap. 2.2.3 states that the Type header is an ASCII
null-terminated string which values are case insensitive (as it is also
defined by RFC 1521).
---
 src/mimetype.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/mimetype.c b/src/mimetype.c
index 078d97c..4e3573c 100644
--- a/src/mimetype.c
+++ b/src/mimetype.c
@@ -135,7 +135,14 @@ static struct obex_mime_type_driver *find_driver(const uint8_t *target,
 		if (memncmp0(who, who_size, driver->who, driver->who_size))
 			continue;
 
-		if (g_strcmp0(mimetype, driver->mimetype) == 0)
+		if (mimetype == NULL || driver->mimetype == NULL) {
+			if (mimetype == driver->mimetype)
+				return driver;
+			else
+				continue;
+		}
+
+		if (g_ascii_strcasecmp(mimetype, driver->mimetype) == 0)
 			return driver;
 	}
 
-- 
1.7.4.1

