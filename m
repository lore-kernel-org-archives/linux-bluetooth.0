Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add sysfs battery & speed attributes for wacom bluetooth
 tablet
From: Przemo Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping <pinglinux@gmail.com>
Content-Type: multipart/mixed; boundary="=-RltzgGBJGq1WPQ58HrbP"
Date: Sun, 28 Feb 2010 20:39:13 +0000
Message-ID: <1267389553.24791.22.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-RltzgGBJGq1WPQ58HrbP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,
I need your opinion if reporting battery condition/changing reporting
speed of a bluetooth device through sysfs is an acceptable practice.

[PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet

The patch creates 2 sysfs attributes:
The battery attribute is read-only and it appears in:
/sys/bus/hid/devices/{btaddr}/battery
/sys/class/bluetooth/hci*:*/{btaddr}/battery
/sys/class/hidraw/hidraw*/device/battery
Capacity values are in %, zero value means AC plug is connected.

The speed attribute allows to poke reporting speed of wacom tablet.
This attribute is RW, valid values are: 5 for low speed, 6 is high
speed. High speed is the default value. Using low speed is
a workaround if you experience big delay between move of stylus on
the tablet and move of cursor on screen.

--
Kind regards,
Przemo

--=-RltzgGBJGq1WPQ58HrbP
Content-Disposition: attachment; filename*0=0001-Add-sysfs-battery-speed-attributes-for-wacom-bluetoo.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Add-sysfs-battery-speed-attributes-for-wacom-bluetoo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From d61bb3eb0fd8109c235ade904a8d7184fc96b68a Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Sat, 20 Feb 2010 12:58:41 +0000
Subject: [PATCH] Add sysfs battery & speed attributes for wacom bluetooth tablet

The patch creates 2 sysfs attributes:
The battery attribute is read-only and it appears in:
/sys/bus/hid/devices/{btaddr}/battery
/sys/class/bluetooth/hci*:*/{btaddr}/battery
/sys/class/hidraw/hidraw*/device/battery
Capacity values are in %, zero value means AC plug is connected.

The speed attribute allows to poke reporting speed of wacom tablet.
This attribute is RW, valid values are: 5 for low speed, 6 is high
speed. High speed is the default value. Using low speed is
a workaround if you experience big delay between move of stylus on
the tablet and move of cursor on screen.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Acked-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/hid-wacom.c |  113 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 89 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 8d3b46f..ce2782c 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -24,11 +24,86 @@
 
 #include "hid-ids.h"
 
+#define WACOM_SPEED_LO	0X05
+#define WACOM_SPEED_HI	0x06
+
 struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
+	unsigned char battery;
 };
 
+/* Battery capacity, 0 value means AC connected */
+static unsigned short batcap[8] = { 1, 15, 25, 35, 50, 70, 100, 0 };
+
+static void wacom_poke(struct hid_device *hdev, u8 data)
+{
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
+	int limit;
+	int ret;
+	char rep_data[2];
+
+	/*
+	 * Note that if the raw queries fail, it's not a hard failure and it
+	 * is safe to continue
+	 */
+	rep_data[0] = 0x03 ; rep_data[1] = 0x00;
+	limit = 3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
+				HID_FEATURE_REPORT);
+	} while (ret < 0 && limit-- > 0);
+	if (ret >= 0)
+		rep_data[0] = data ; rep_data[1] = 0x00;
+		limit = 3;
+		do {
+			ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
+					HID_FEATURE_REPORT);
+		} while (ret < 0 && limit-- > 0);
+	if (ret >= 0) {
+		wdata->speed = data;
+		return;
+	}
+
+	dev_warn(&hdev->dev, "failed to poke device, command %d, err %d\n",
+				data, ret);
+}
+
+static ssize_t wacom_show_battery(struct device *dev, struct device_attribute
+				*attr, char *buf)
+{
+	struct wacom_data *wdata = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%i\n", batcap[wdata->battery]);
+}
+
+static DEVICE_ATTR(battery, S_IRUGO, wacom_show_battery, NULL);
+
+static ssize_t wacom_show_speed(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct wacom_data *wdata = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%i\n", wdata->speed);
+}
+
+static ssize_t wacom_store_speed(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	int new_speed;
+
+	sscanf(buf, "%1d", &new_speed);
+	if (new_speed == WACOM_SPEED_HI || new_speed == WACOM_SPEED_LO) {
+		wacom_poke(hdev, new_speed);
+		return strnlen(buf, PAGE_SIZE);
+	} else
+		return -EINVAL;
+}
+
+static DEVICE_ATTR(speed, S_IRUGO | S_IWUGO,
+		wacom_show_speed, wacom_store_speed);
+
 static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *raw_data, int size)
 {
@@ -147,6 +222,11 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		input_sync(input);
 	}
 
+	/* Store current battery capacity */
+	rw = (data[7] >> 2 & 0x07);
+	if (rw != wdata->battery)
+		wdata->battery = rw;
+
 	return 1;
 }
 
@@ -156,9 +236,7 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
-	char rep_data[2];
 	int ret;
-	int limit;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (wdata == NULL) {
@@ -181,30 +259,17 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	/*
-	 * Note that if the raw queries fail, it's not a hard failure and it
-	 * is safe to continue
-	 */
+	ret = device_create_file(&hdev->dev, &dev_attr_battery);
+	if (ret)
+		dev_warn(&hdev->dev,
+			"can't create sysfs battery attribute err: %d\n", ret);
 
-	/* Set Wacom mode2 */
-	rep_data[0] = 0x03; rep_data[1] = 0x00;
-	limit = 3;
-	do {
-		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
-				HID_FEATURE_REPORT);
-	} while (ret < 0 && limit-- > 0);
-	if (ret < 0)
-		dev_warn(&hdev->dev, "failed to poke device #1, %d\n", ret);
+	ret = device_create_file(&hdev->dev, &dev_attr_speed);
+	if (ret)
+		dev_warn(&hdev->dev,
+			"can't create sysfs speed attribute err: %d\n", ret);
 
-	/* 0x06 - high reporting speed, 0x05 - low speed */
-	rep_data[0] = 0x06; rep_data[1] = 0x00;
-	limit = 3;
-	do {
-		ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
-				HID_FEATURE_REPORT);
-	} while (ret < 0 && limit-- > 0);
-	if (ret < 0)
-		dev_warn(&hdev->dev, "failed to poke device #2, %d\n", ret);
+	wacom_poke(hdev, WACOM_SPEED_HI);
 
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
-- 
1.6.6.1


--=-RltzgGBJGq1WPQ58HrbP--
