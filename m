Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth
 tablet
From: Przemo Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <1268926624.21548.1478.camel@localhost.localdomain>
References: <1268925902.12672.25.camel@pldmachine>
	 <1268926015.12672.27.camel@pldmachine>
	 <1268926624.21548.1478.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-ueUmwO0nRqH0vTdyR+S4"
Date: Thu, 18 Mar 2010 19:12:21 +0000
Message-ID: <1268939541.3639.13.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ueUmwO0nRqH0vTdyR+S4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dnia 2010-03-18, czw o godzinie 15:37 +0000, Bastien Nocera pisze:
> On Thu, 2010-03-18 at 15:26 +0000, Przemo Firszt wrote:
> 
> > +       unsigned char speed;
> 
> Could you add some comments as to what values represent what speed?
I changed name from 'speed' to 'high_speed' as per your comment below,
so I think there is no need (unless you think otherwise). 
> 
> > +static ssize_t wacom_store_speed(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +       struct hid_device *hdev = container_of(dev, struct hid_device,
> > dev);
> > +       int new_speed;
> > +
> > +       sscanf(buf, "%1d", &new_speed);
> 
> You should check the retval of sscanf as well.
Done, see attached patch.
> > +       if (new_speed == 0 || new_speed == 1) {
> > +               wacom_poke(hdev, new_speed);
> > +               return strnlen(buf, PAGE_SIZE);
> > +       } else
> > +               return -EINVAL;
> > +} 
> 
> > 
> > +static DEVICE_ATTR(speed, S_IRUGO | S_IWUGO,
> > +               wacom_show_speed, wacom_store_speed);
> 
> If there's only 2 speeds available, and it's actually a boolean, I'd
> rather you used a name like "high_speed".
> 
> Furthermore, wdata->speed doesn't look like it's initialised.
It is initialised by the very first call of wacom_poke from wacom_probe
function. Can you advise if it's enough?
> 
> Did you test whether speed switching works after the device has been
> started up?
Yes, it works like a charm, both ways. 
[przemo@pldmachine ~]$ echo 0 > /sys/class/hidraw/hidraw1/device/speed
and lag is gone,
[przemo@pldmachine ~]$ echo 1 > /sys/class/hidraw/hidraw1/device/speed
and "rubber band" effect is back.

Thanks for your comments,
Przemo


--=-ueUmwO0nRqH0vTdyR+S4
Content-Disposition: attachment; filename*0=0002-Add-sysfs-speed-attribute-for-wacom-bluetooth-tablet.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-Add-sysfs-speed-attribute-for-wacom-bluetooth-tablet.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From ec2c13649c3d7188199bfddc06b4211170c28b1c Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Thu, 18 Mar 2010 14:34:34 +0000
Subject: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth tablet

The attribute allows to change reporting speed of tablet from userspace through
sysfs file. The attribute is RW, valid values: 0 is low speed, 1 is high speed.
High speed is the default setting. Using low speed is a workaround if you
experience lag when using the tablet.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index f9d4939..97ef626 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -30,6 +30,7 @@
 struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
+	unsigned char high_speed;
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
+			wdata->high_speed = speed;
 			return;
+		}
 	}
 
 	/*
@@ -141,6 +145,35 @@ static void wacom_poke(struct hid_device *hdev, u8 speed)
 	return;
 }
 
+static ssize_t wacom_show_speed(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct wacom_data *wdata = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%i\n", wdata->high_speed);
+}
+
+static ssize_t wacom_store_speed(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	int new_speed;
+
+	if (sscanf(buf, "%1d", &new_speed ) != 1)
+		return -EINVAL;
+
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
@@ -297,6 +330,11 @@ static int wacom_probe(struct hid_device *hdev,
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


--=-ueUmwO0nRqH0vTdyR+S4--
