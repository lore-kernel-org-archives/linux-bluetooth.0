Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Expose wacom pen tablet battery and ac thru power_supply
 class
From: Przemo Firszt <przemo@firszt.eu>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
In-Reply-To: <1267531889.23521.14301.camel@localhost.localdomain>
References: <1267389553.24791.22.camel@pldmachine>
	 <1267531337.23521.14275.camel@localhost.localdomain>
	 <1267531889.23521.14301.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-8r/j0PgEKt8qJ976O88N"
Date: Tue, 09 Mar 2010 19:12:24 +0000
Message-ID: <1268161944.3632.21.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-8r/j0PgEKt8qJ976O88N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dnia 2010-03-02, wto o godzinie 12:11 +0000, Bastien Nocera pisze:
[..]
> > A couple of comments:
> <snip>
> > - isn't there a more kernel-y way to export that data, so that it's
> > automatically picked up by things like upower (n=C3=A9 DeviceKit-power)=
?
>=20
> I've been told it should use the power_supply class, so it would work
> pretty much out-of-the-box with things like upower and
> gnome-power-manager.
Thanks for the comments - it was exactly that what I was looking
for! :-)
Please find attached revamped patch - this time battery & ac patch only.
Speed switching isn't yet ready for release.

For some reason gnome-power-manager isn't updating the values properly,
despite of that they are OK in:
/sys/class/power_supply/wacom_{ac,battery}/uevent

I'm not sure if it's a result of lack of .external_power_changed (it's
missing in some drivers using power_supply) or something else. Any
hints?

Cheers,
Przemo

--=-8r/j0PgEKt8qJ976O88N
Content-Disposition: attachment; filename*0=0001-Expose-wacom-pen-tablet-battery-and-ac-thru-power_su.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Expose-wacom-pen-tablet-battery-and-ac-thru-power_su.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c56101ee1fe781a46e43de930b94ee3397b08b69 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Fri, 5 Mar 2010 17:19:44 +0000
Subject: [PATCH] Expose wacom pen tablet battery and ac thru power_supply class

This patch exposes wacom pen tablet battery capacity and ac state thru
power_supply class is sysfs.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |  150 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 8d3b46f..e5fa473 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -21,14 +21,118 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 
 #include "hid-ids.h"
 
 struct wacom_data {
 	__u16 tool;
 	unsigned char butstate;
+	int battery_capacity;
+	struct power_supply battery;
+	struct power_supply ac;
 };
 
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
+
+static void wacom_poke(struct hid_device *hdev, u8 data)
+{
+	int limit;
+	int ret;
+	char rep_data[2];
+	/*
+	 * data has to be one of those:
+	 * 0x05 - low reporting speed
+	 * 0x06 - high reporting speed
+	 */
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
+	if (ret >= 0) {
+		rep_data[0] = data ; rep_data[1] = 0x00;
+		limit = 3;
+		do {
+			ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
+							HID_FEATURE_REPORT);
+		} while (ret < 0 && limit-- > 0);
+		if (ret < 0)
+			dev_warn(&hdev->dev,
+				"failed to poke device, command %d, err %d\n"
+				, data, ret);
+	}
+
+}
+
 static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *raw_data, int size)
 {
@@ -147,6 +251,11 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 		input_sync(input);
 	}
 
+	/* Store current battery capacity */
+	rw = (data[7] >> 2 & 0x07);
+	if (rw != wdata->battery_capacity)
+		wdata->battery_capacity = rw;
+
 	return 1;
 }
 
@@ -206,6 +315,43 @@ static int wacom_probe(struct hid_device *hdev,
 	if (ret < 0)
 		dev_warn(&hdev->dev, "failed to poke device #2, %d\n", ret);
 
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
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
@@ -250,7 +396,11 @@ err_free:
 
 static void wacom_remove(struct hid_device *hdev)
 {
+	struct wacom_data *wdata = hid_get_drvdata(hdev);
+
 	hid_hw_stop(hdev);
+	power_supply_unregister(&wdata->battery);
+	power_supply_unregister(&wdata->ac);
 	kfree(hid_get_drvdata(hdev));
 }
 
-- 
1.7.0.1


--=-8r/j0PgEKt8qJ976O88N--
