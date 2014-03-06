Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
Subject: [PATCH 1/3] input: Remove input_device.name
To: linux-bluetooth@vger.kernel.org
Message-Id: <20140306230023.022CD100A0D@puck.mtv.corp.google.com>
Date: Thu,  6 Mar 2014 15:00:22 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove input_device.name and use input_device.device to get the device name.
---
 profiles/input/device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d6e97c7..5235dfd 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -78,7 +78,6 @@ struct input_device {
 	struct hidp_connadd_req *req;
 	guint			dc_id;
 	bool			disable_sdp;
-	char			*name;
 	enum reconnect_mode_t	reconnect_mode;
 	guint			reconnect_timer;
 	uint32_t		reconnect_attempt;
@@ -100,7 +99,6 @@ static void input_device_free(struct input_device *idev)
 
 	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
-	g_free(idev->name);
 	g_free(idev->path);
 
 	if (idev->ctrl_watch > 0)
@@ -420,8 +418,8 @@ static int hidp_add_connection(struct input_device *idev)
 	req->product = btd_device_get_product(idev->device);
 	req->version = btd_device_get_version(idev->device);
 
-	if (idev->name)
-		strncpy(req->name, idev->name, sizeof(req->name) - 1);
+	if (device_name_known(idev->device))
+		device_get_name(idev->device, req->name, sizeof(req->name));
 
 	/* Encryption is mandatory for keyboards */
 	if (req->subclass & 0x40) {
@@ -808,7 +806,6 @@ static struct input_device *input_device_new(struct btd_service *service)
 	const sdp_record_t *rec = btd_device_get_record(device, p->remote_uuid);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
-	char name[HCI_MAX_NAME_LENGTH + 1];
 
 	if (!rec)
 		return NULL;
@@ -822,10 +819,6 @@ static struct input_device *input_device_new(struct btd_service *service)
 	idev->handle = rec->handle;
 	idev->disable_sdp = is_device_sdp_disable(rec);
 
-	device_get_name(device, name, sizeof(name));
-	if (strlen(name) > 0)
-		idev->name = g_strdup(name);
-
 	/* Initialize device properties */
 	extract_hid_props(idev, rec);
 
-- 
1.9.0.279.gdc9e3eb

