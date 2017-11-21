Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gdbus: Fix not emiting PropertiesChanged
Date: Tue, 21 Nov 2017 22:04:36 +0200
Message-Id: <20171121200436.17576-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If and interface is removed while properties are pending it would cause
process_properties_from_interface to clear data->pending_prop when it
should only clear the iface->pending_prop.
---
 gdbus/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index afb458764..5c8ad7a55 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1659,8 +1659,6 @@ static void process_properties_from_interface(struct generic_data *data,
 	DBusMessageIter iter, dict, array;
 	GSList *invalidated;
 
-	data->pending_prop = FALSE;
-
 	if (iface->pending_prop == NULL)
 		return;
 
@@ -1722,6 +1720,8 @@ static void process_property_changes(struct generic_data *data)
 {
 	GSList *l;
 
+	data->pending_prop = FALSE;
+
 	for (l = data->interfaces; l != NULL; l = l->next) {
 		struct interface_data *iface = l->data;
 
-- 
2.13.6

