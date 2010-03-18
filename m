Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth tablet
From: Przemo Firszt <przemo@firszt.eu>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <1268925902.12672.25.camel@pldmachine>
References: <1268925902.12672.25.camel@pldmachine>
Content-Type: multipart/mixed; boundary="=-kyL8XAAljFKwhJskS8fH"
Date: Thu, 18 Mar 2010 15:26:55 +0000
Message-ID: <1268926015.12672.27.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-kyL8XAAljFKwhJskS8fH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch 2/2
--
Przemo


--=-kyL8XAAljFKwhJskS8fH
Content-Disposition: attachment; filename*0=0002-Add-sysfs-speed-attribute-for-wacom-bluetooth-tablet.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-Add-sysfs-speed-attribute-for-wacom-bluetooth-tablet.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 92b0a06c748ea0a853c369595444dd411b32f314 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Thu, 18 Mar 2010 14:34:34 +0000
Subject: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth tablet

The attribute allows to change reporting speed of tablet from userspace through
sysfs file. The attribute is RW, valid values: 0 is low speed, 1 is high speed.
High speed is the default setting. Using low speed is a workaround if you
experience lag when using the tablet.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index f9d4939..34d96e0 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -30,6 +30,7 @@
 struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
+	unsigned char speed;
 #ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	int battery_capacity;
 	struct power_supply battery;
@@ -105,6 +106,7 @@ static int wacom_ac_get_property(struct power_supply *psy,
 
 static void wacom_poke(struct hid_device *hdev, u8 speed)
 {
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
 	int limit, ret;
 	char rep_data[2];
 
@@ -128,8 +130,10 @@ static void wacom_poke(struct hid_device *hdev, u8 speed)
 					HID_FEATURE_REPORT);
 		} while (ret < 0 && limit-- > 0);
 
-		if (ret >= 0)
+		if (ret >= 0) {
+			wdata->speed = speed;
 			return;
+		}
 	}
 
 	/*
@@ -141,6 +145,33 @@ static void wacom_poke(struct hid_device *hdev, u8 speed)
 	return;
 }
 
+static ssize_t wacom_show_speed(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct wacom_data *wdata = dev_get_drvdata(dev);
+
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
+	if (new_speed == 0 || new_speed == 1) {
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
@@ -297,6 +328,11 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	ret = device_create_file(&hdev->dev, &dev_attr_speed);
+	if (ret)
+		dev_warn(&hdev->dev,
+			"can't create sysfs speed attribute err: %d\n", ret);
+
 	/* Set Wacom mode 2 with high reporting speed */
 	wacom_poke(hdev, 1);
 
-- 
1.7.0.1


--=-kyL8XAAljFKwhJskS8fH--
