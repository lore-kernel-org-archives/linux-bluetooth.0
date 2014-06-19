Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Fix using address of array instead of size
Date: Thu, 19 Jun 2014 16:55:36 +0300
Message-Id: <1403186136-30041-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 src/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index a9b644b..2003c7f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -595,7 +595,11 @@ static gboolean dev_property_get_name(const GDBusPropertyTable *property,
 	struct btd_device *device = data;
 	const char *empty = "", *ptr;
 
-	ptr = device->name ?: empty;
+	if (strlen(device->name) > 0)
+		ptr = device->name;
+	else
+		ptr = empty;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
 
 	return TRUE;
-- 
1.8.3.2

