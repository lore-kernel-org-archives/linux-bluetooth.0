Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix using address of array instead of size
Date: Mon, 23 Jun 2014 14:19:35 +0300
Message-Id: <1403522375-30438-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20140623075529.GA29804@t440s>
References: <20140623075529.GA29804@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Address of array is always not NULL.
---
 src/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a9b644b..2c9ff92 100644
--- a/src/device.c
+++ b/src/device.c
@@ -593,9 +593,8 @@ static gboolean dev_property_get_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct btd_device *device = data;
-	const char *empty = "", *ptr;
+	const char *ptr = device->name;
 
-	ptr = device->name ?: empty;
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
 	return TRUE;
-- 
1.8.3.2

