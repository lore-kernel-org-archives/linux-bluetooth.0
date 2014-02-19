Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] core: Fix device_get_name()
Message-Id: <20140219004413.4361A1005F0@puck.mtv.corp.google.com>
Date: Tue, 18 Feb 2014 16:44:13 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix device_get_name() to null-terminate the name string it returns.
Modify all callers as needed.
---
 plugins/wiimote.c       | 1 -
 profiles/input/device.c | 2 +-
 src/device.c            | 5 ++++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index c23607f..bd8820e 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -90,7 +90,6 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 	product = btd_device_get_product(device);
 
 	device_get_name(device, name, sizeof(name));
-	name[sizeof(name) - 1] = 0;
 
 	for (i = 0; i < G_N_ELEMENTS(wii_ids); ++i) {
 		if (vendor == wii_ids[i][0] && product == wii_ids[i][1])
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 10c3d5c..d6e97c7 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -822,7 +822,7 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev->handle = rec->handle;
 	idev->disable_sdp = is_device_sdp_disable(rec);
 
-	device_get_name(device, name, HCI_MAX_NAME_LENGTH);
+	device_get_name(device, name, sizeof(name));
 	if (strlen(name) > 0)
 		idev->name = g_strdup(name);
 
diff --git a/src/device.c b/src/device.c
index 41a6fc8..eabbe0a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2272,7 +2272,10 @@ void btd_device_device_set_name(struct btd_device *device, const char *name)
 
 void device_get_name(struct btd_device *device, char *name, size_t len)
 {
-	strncpy(name, device->name, len);
+	if (name != NULL && len > 0) {
+		strncpy(name, device->name, len - 1);
+		name[len - 1] = '\0';
+	}
 }
 
 bool device_name_known(struct btd_device *device)
-- 
1.9.0.rc1.175.g0b1dcb5

