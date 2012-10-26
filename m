Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 4/5] input: Retrieve device name from device object
Date: Fri, 26 Oct 2012 11:25:04 +0200
Message-Id: <1351243505-20702-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351243505-20702-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351243505-20702-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index fbc3d6f..108be39 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -777,7 +777,7 @@ static struct input_device *input_device_new(struct btd_device *device,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
-	char name[249], src_addr[18], dst_addr[18];
+	char name[HCI_MAX_NAME_LENGTH + 1];
 
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, adapter_get_address(adapter));
@@ -787,11 +787,8 @@ static struct input_device *input_device_new(struct btd_device *device,
 	idev->handle = handle;
 	idev->disable_sdp = disable_sdp;
 
-	ba2str(&idev->src, src_addr);
-	ba2str(&idev->dst, dst_addr);
-
-	if (read_device_name(src_addr, dst_addr, device_get_addr_type(device),
-				name) == 0)
+	device_get_name(device, name, HCI_MAX_NAME_LENGTH);
+	if (strlen(name) > 0)
 		idev->name = g_strdup(name);
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
-- 
1.7.9.5

