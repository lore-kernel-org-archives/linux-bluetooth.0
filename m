Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 04/18] Add a way to store the remote device type
Date: Tue, 21 Dec 2010 19:26:26 -0200
Message-Id: <1292966800-6264-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because we need to know the device type (LE, Basic Rate or Dual Mode)
to be able to fully restore the device from storage, we have to store
and load this information to permanent storage.

Note: due to "device_type_t" usage in storage.h, some header includes
needed to be reordered in files which include storage.h.
---
 input/device.c   |    4 ++--
 plugins/hciops.c |    2 +-
 serial/port.c    |    2 ++
 src/storage.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 src/storage.h    |    3 +++
 5 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/input/device.c b/input/device.c
index d735028..8a17966 100644
--- a/input/device.c
+++ b/input/device.c
@@ -46,11 +46,11 @@
 #include "textfile.h"
 #include "uinput.h"
 
-#include "../src/storage.h"
 #include "../src/adapter.h"
+#include "../src/device.h"
+#include "../src/storage.h"
 #include "../src/manager.h"
 #include "../src/dbus-common.h"
-#include "../src/device.h"
 
 #include "device.h"
 #include "error.h"
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 131df1a..43e3d93 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -41,11 +41,11 @@
 #include "hcid.h"
 #include "sdpd.h"
 #include "adapter.h"
+#include "device.h"
 #include "plugin.h"
 #include "log.h"
 #include "storage.h"
 #include "event.h"
-#include "device.h"
 #include "manager.h"
 
 static int child_pipe[2] = { -1, -1 };
diff --git a/serial/port.c b/serial/port.c
index 233e317..7d56faa 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -53,6 +53,8 @@
 
 #include "error.h"
 #include "manager.h"
+#include "adapter.h"
+#include "device.h"
 #include "storage.h"
 #include "port.h"
 
diff --git a/src/storage.c b/src/storage.c
index 06b36f1..fb6e401 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -45,6 +45,8 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "textfile.h"
+#include "adapter.h"
+#include "device.h"
 #include "glib-helper.h"
 #include "storage.h"
 
@@ -1391,3 +1393,41 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 
 	return textfile_foreach(filename, func, data);
 }
+
+int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
+						device_type_t type)
+{
+	char filename[PATH_MAX + 1], addr[18], chars[3];
+
+	create_filename(filename, PATH_MAX, sba, "types");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(dba, addr);
+
+	snprintf(chars, sizeof(chars), "%2.2X", type);
+
+	return textfile_put(filename, addr, chars);
+}
+
+device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba)
+{
+	char filename[PATH_MAX + 1], addr[18], *chars;
+	device_type_t type;
+
+	create_filename(filename, PATH_MAX, sba, "types");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(dba, addr);
+
+	chars = textfile_caseget(filename, addr);
+	if (chars == NULL)
+		return DEVICE_TYPE_UNKNOWN;
+
+	type = strtol(chars, NULL, 16);
+
+	free(chars);
+
+	return type;
+}
diff --git a/src/storage.h b/src/storage.h
index c7e342c..f36cefb 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -91,6 +91,9 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
+int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
+						device_type_t type);
+device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.3.4

