Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Expose wacom pen tablet battery and ac thru
 power_supply class
From: Przemo Firszt <przemo@firszt.eu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
In-Reply-To: <alpine.LNX.2.00.1003151454110.18642@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>
	 <1267531337.23521.14275.camel@localhost.localdomain>
	 <1267531889.23521.14301.camel@localhost.localdomain>
	 <1268161944.3632.21.camel@pldmachine> <1268162757.3632.33.camel@pldmachine>
	 <alpine.LNX.2.00.1003092220160.17799@pobox.suse.cz>
	 <1268247817.3632.41.camel@pldmachine>
	 <alpine.LNX.2.00.1003151454110.18642@pobox.suse.cz>
Content-Type: multipart/mixed; boundary="=-LbK6yLIqm9waoM0DNMBU"
Date: Mon, 15 Mar 2010 22:00:54 +0000
Message-ID: <1268690454.3452.7.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-LbK6yLIqm9waoM0DNMBU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dnia 2010-03-15, pon o godzinie 14:54 +0100, Jiri Kosina pisze:
> On Wed, 10 Mar 2010, Przemo Firszt wrote:
[..]
> > Does it make sense to add a line to Kconfig to explain that
> > CONFIG_POWER_SUPPLY/CONFIG_POWER_SUPPLY_MODULE is required to enable
> > monitoring battery/ac state?
> 
> Either that, or introducing separate CONFIG sub-option for the Wacom 
> driver might be reasonable option as well.
Hi Jiri,
Thanks for help - next time I'll know how to do it :-)
I went the CONFIG sub-option way - see attached.

thanks,
Przemo



--=-LbK6yLIqm9waoM0DNMBU
Content-Disposition: attachment; filename*0=0001-Expose-wacom-pen-tablet-battery-and-ac-thru-power_su.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Expose-wacom-pen-tablet-battery-and-ac-thru-power_su.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From d6ec58bc114bdf0dd01bc0407f5f7bbb8161e45e Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Mon, 15 Mar 2010 19:16:23 +0000
Subject: [PATCH] Expose wacom pen tablet battery and ac thru power_supply class

This patch exposes wacom pen tablet battery capacity and ac state thru
power_supply class is sysfs.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/Kconfig     |    8 +++
 drivers/hid/hid-wacom.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 71d4c07..8e1b505 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -357,6 +357,14 @@ config HID_WACOM
 	---help---
 	Support for Wacom Graphire Bluetooth tablet.
 
+config HID_WACOM_POWER_SUPPLY
+	bool "Wacom Bluetooth devices power supply status support"
+	depends on HID_WACOM
+	select POWER_SUPPLY
+	---help---
+	  Say Y here if you want to enable power supply status monitoring for
+	  Wacom Bluetooth devices.
+
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support" if EMBEDDED
 	depends on USB_HID
diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 8d3b46f..4d2d2a2 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -21,14 +21,88 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+#include <linux/power_supply.h>
+#endif
 
 #include "hid-ids.h"
 
 struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+	int battery_capacity;
+	struct power_supply battery;
+	struct power_supply ac;
+#endif
 };
 
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+/*percent of battery capacity, 0 means AC online*/
+static unsigned short batcap[8] = { 1, 15, 25, 35, 50, 70, 100, 0 };
+
+static enum power_supply_property wacom_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY
+};
+
+static enum power_supply_property wacom_ac_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE
+};
+
+static int wacom_battery_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct wacom_data *wdata = container_of(psy,
+					struct wacom_data, battery);
+	int power_state = batcap[wdata->battery_capacity];
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		/* show 100% battery capacity when charging */
+		if (power_state == 0)
+			val->intval = 100;
+		else
+			val->intval = power_state;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int wacom_ac_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct wacom_data *wdata = container_of(psy, struct wacom_data, ac);
+	int power_state = batcap[wdata->battery_capacity];
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		/* fall through */
+	case POWER_SUPPLY_PROP_ONLINE:
+		if (power_state == 0)
+			val->intval = 1;
+		else
+			val->intval = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+#endif
+
 static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *raw_data, int size)
 {
@@ -147,6 +221,12 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		input_sync(input);
 	}
 
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+	/* Store current battery capacity */
+	rw = (data[7] >> 2 & 0x07);
+	if (rw != wdata->battery_capacity)
+		wdata->battery_capacity = rw;
+#endif
 	return 1;
 }
 
@@ -206,6 +286,45 @@ static int wacom_probe(struct hid_device *hdev,
 	if (ret < 0)
 		dev_warn(&hdev->dev, "failed to poke device #2, %d\n", ret);
 
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+	wdata->battery.properties = wacom_battery_props;
+	wdata->battery.num_properties = ARRAY_SIZE(wacom_battery_props);
+	wdata->battery.get_property = wacom_battery_get_property;
+	wdata->battery.name = "wacom_battery";
+	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+	wdata->battery.use_for_apm = 0;
+
+	ret = power_supply_register(&hdev->dev, &wdata->battery);
+	if (ret) {
+		dev_warn(&hdev->dev,
+			"can't create sysfs battery attribute, err: %d\n", ret);
+		/*
+		 * battery attribute is not critical for the tablet, but if it
+		 * failed then there is no need to create ac attribute
+		 */
+		goto move_on;
+	}
+
+	wdata->ac.properties = wacom_ac_props;
+	wdata->ac.num_properties = ARRAY_SIZE(wacom_ac_props);
+	wdata->ac.get_property = wacom_ac_get_property;
+	wdata->ac.name = "wacom_ac";
+	wdata->ac.type = POWER_SUPPLY_TYPE_MAINS;
+	wdata->ac.use_for_apm = 0;
+
+	ret = power_supply_register(&hdev->dev, &wdata->ac);
+	if (ret) {
+		dev_warn(&hdev->dev,
+			"can't create ac battery attribute, err: %d\n", ret);
+		/*
+		 * ac attribute is not critical for the tablet, but if it
+		 * failed then we don't want to battery attribute to exist
+		 */
+		power_supply_unregister(&wdata->battery);
+	}
+
+move_on:
+#endif
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
@@ -250,7 +369,15 @@ err_free:
 
 static void wacom_remove(struct hid_device *hdev)
 {
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
+#endif
 	hid_hw_stop(hdev);
+
+#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
+	power_supply_unregister(&wdata->battery);
+	power_supply_unregister(&wdata->ac);
+#endif
 	kfree(hid_get_drvdata(hdev));
 }
 
-- 
1.7.0.1


--=-LbK6yLIqm9waoM0DNMBU--
