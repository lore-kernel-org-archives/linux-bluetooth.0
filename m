Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Steve Beard <stevieboy10@gmail.com>
Date: Fri, 23 Mar 2018 15:43:42 +0000
Message-ID: <CAH4oaOeD+b_YGD6Pz9Joz2xkHXP_96qVgQTk7f0kP9+tCkFZLw@mail.gmail.com>
Subject: Manufacturer data in both LE advertisement and scan response
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

During testing of bluez (5.48) with a simple BLE temperature sensor
beacon device (bluemaestro tempo disc) I have had difficulties
obtaining the manufacturer data send in the advertisement packet. This
device sends different manufacturer data in the advertisement than in
the scan response packet. As far as I can tell this is perfectly
within the bluetooth specification.

My investigation of the issue has led me to the following methods in
the bluez source code (src/device.c):

static void add_manufacturer_data(void *data, void *user_data)
{
struct eir_msd *msd = data;
struct btd_device *dev = user_data;

if (!bt_ad_add_manufacturer_data(dev->ad, msd->company, msd->data,
msd->data_len))
return;

g_dbus_emit_property_changed(dbus_conn, dev->path,
DEVICE_INTERFACE, "ManufacturerData");
}

void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
bool duplicate)
{
if (duplicate)
bt_ad_clear_manufacturer_data(dev->ad);

g_slist_foreach(list, add_manufacturer_data, dev);
}

device_set_manufacturer_data iterates over the manufacturer data
received (in my case there are typically 2 results - one for
advertisement, the other for the scan response) setting the results on
the manufacturer data dbus property for the device. My experience is
that the g_dbus_emit_property_changed results in dbus only notifying
for the last result (the scan response manufacturer data).

Having read through the gdbus/gdbus.h header file I found this comment:

/*
 * Note that when multiple properties for a given object path are changed
 * in the same mainloop iteration, they will be grouped with the last
 * property changed. If this behaviour is undesired, use
 * g_dbus_emit_property_changed_full() with the
 * G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH flag, causing the signal to ignore
 * any grouping.
 */
void g_dbus_emit_property_changed(DBusConnection *connection,
                const char *path, const char *interface,
                const char *name);
void g_dbus_emit_property_changed_full(DBusConnection *connection,
                const char *path, const char *interface,
                const char *name,
                GDbusPropertyChangedFlags flags);

This suggests that using g_dbus_emit_property_changes_full with the
flag G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH will ignore the grouping.

I have tested with the following change to the bluez source code for
device.c and can confirm that this solves my issue (now receive both
manufacturer data - tested with bluetoothctl command line tool):

diff --git a/src/device.c b/src/device.c
index 72f18b3..bc16ed4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1630,20 +1630,21 @@ void device_add_eir_uuids(struct btd_device
*dev, GSList *uuids)
 static void add_manufacturer_data(void *data, void *user_data)
 {
        struct eir_msd *msd = data;
        struct btd_device *dev = user_data;

        if (!bt_ad_add_manufacturer_data(dev->ad, msd->company, msd->data,
                                                                msd->data_len))
                return;

-       g_dbus_emit_property_changed(dbus_conn, dev->path,
-                                       DEVICE_INTERFACE, "ManufacturerData");
+       g_dbus_emit_property_changed_full(dbus_conn, dev->path,
+                                       DEVICE_INTERFACE, "ManufacturerData",
+                                       G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }

 void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
                                                                bool duplicate)
 {
        if (duplicate)
                bt_ad_clear_manufacturer_data(dev->ad);

        g_slist_foreach(list, add_manufacturer_data, dev);

I therefore ask that this issue described be considered for fixing in
future release and that the proposed change be considered for merging
into the source.

Kind regards,

Steven Beard
