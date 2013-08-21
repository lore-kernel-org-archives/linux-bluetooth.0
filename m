Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix emitting empty Device1.UUIDs property
Date: Wed, 21 Aug 2013 15:17:21 +0300
Message-Id: <1377087441-11020-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case there is a incoming connection but services has not been
resolved the UUID of the profile being connected is automatically added
using btd_device_add_uuid which does update uuids not eir_uuids which is
used if svc_resolved is false.

To fix this the code will now fallback to uuids field whenever eir_uuids is
empty so uuids added with btd_device_add_uuid previous to services being
resolved should appear in UUIDs property.
---
 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f854ed9..457ab64 100644
--- a/src/device.c
+++ b/src/device.c
@@ -911,7 +911,9 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_TYPE_STRING_AS_STRING, &entry);
 
-	if (!device->svc_resolved)
+	if (device->svc_resolved)
+		l = device->uuids;
+	else if (device->eir_uuids)
 		l = device->eir_uuids;
 	else
 		l = device->uuids;
-- 
1.8.3.1

