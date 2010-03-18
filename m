Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 1/2] Add separate mode switching function wacom bluetooth
 pen tablet.
From: Przemo Firszt <przemo@firszt.eu>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, marcel <marcel@holtmann.org>, Ping <pinglinux@gmail.com>,  Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jkosina@suse.cz>
Content-Type: multipart/mixed; boundary="=-rX0f/+wYfsh/c5rNR3e6"
Date: Thu, 18 Mar 2010 15:25:02 +0000
Message-ID: <1268925902.12672.25.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-rX0f/+wYfsh/c5rNR3e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,
Two patches to allow switching of reporting speed of wacom bluetooth
tablet from userspace through sysfs. 

kind reagrds,
Przemo

--=-rX0f/+wYfsh/c5rNR3e6
Content-Disposition: attachment; filename*0=0001-Add-separate-mode-switching-function-wacom-bluetooth.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Add-separate-mode-switching-function-wacom-bluetooth.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From ac9a87b92cf2f8cc27a1d29123c5fa1a8bebd71a Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Thu, 18 Mar 2010 11:58:22 +0000
Subject: [PATCH 1/2] Add separate mode switching function wacom bluetooth pen tablet.

wacom_poke function allows to switch tablet reporting speed. The patch
dosen't add any new functionality, but it's preparation for user-space
speed switching through sysfs.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |   66 ++++++++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 4d2d2a2..f9d4939 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -103,6 +103,44 @@ static int wacom_ac_get_property(struct power_supply *psy,
 }
 #endif
 
+static void wacom_poke(struct hid_device *hdev, u8 speed)
+{
+	int limit, ret;
+	char rep_data[2];
+
+	rep_data[0] = 0x03 ; rep_data[1] = 0x00;
+	limit = 3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
+				HID_FEATURE_REPORT);
+	} while (ret < 0 && limit-- > 0);
+
+	if (ret >= 0) {
+		if (speed == 0)
+			rep_data[0] = 0x05;
+		else
+			rep_data[0] = 0x06;
+
+		rep_data[1] = 0x00;
+		limit = 3;
+		do {
+			ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
+					HID_FEATURE_REPORT);
+		} while (ret < 0 && limit-- > 0);
+
+		if (ret >= 0)
+			return;
+	}
+
+	/*
+	 * Note that if the raw queries fail, it's not a hard failure and it
+	 * is safe to continue
+	 */
+	dev_warn(&hdev->dev, "failed to poke device, command %d, err %d\n",
+				rep_data[0], ret);
+	return;
+}
+
 static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *raw_data, int size)
 {
@@ -236,9 +274,7 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
-	char rep_data[2];
 	int ret;
-	int limit;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (wdata == NULL) {
@@ -261,30 +297,8 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	/*
-	 * Note that if the raw queries fail, it's not a hard failure and it
-	 * is safe to continue
-	 */
-
-	/* Set Wacom mode2 */
-	rep_data[0] = 0x03; rep_data[1] = 0x00;
-	limit = 3;
-	do {
-		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
-				HID_FEATURE_REPORT);
-	} while (ret < 0 && limit-- > 0);
-	if (ret < 0)
-		dev_warn(&hdev->dev, "failed to poke device #1, %d\n", ret);
-
-	/* 0x06 - high reporting speed, 0x05 - low speed */
-	rep_data[0] = 0x06; rep_data[1] = 0x00;
-	limit = 3;
-	do {
-		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
-				HID_FEATURE_REPORT);
-	} while (ret < 0 && limit-- > 0);
-	if (ret < 0)
-		dev_warn(&hdev->dev, "failed to poke device #2, %d\n", ret);
+	/* Set Wacom mode 2 with high reporting speed */
+	wacom_poke(hdev, 1);
 
 #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	wdata->battery.properties = wacom_battery_props;
-- 
1.7.0.1


--=-rX0f/+wYfsh/c5rNR3e6--
