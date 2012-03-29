Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "Ganir, Chen" <chen.ganir@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 0/4] Add Property Changed callbacks to btd_device
Date: Thu, 29 Mar 2012 07:44:47 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B467A9E@DNCE02.ent.ti.com>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi,

This patch set comes as a reply to a previous discussion over the DIS plugin, with Claudio Takashi. The main concern Claudio raised was with a race condition which may occur, when HID Service is loaded before DIS is fully updated with the PNP_ID information, which is required for HID Service /dev/uhid configuration. To prevent this a few ideas were raised, and callback mechanism was one of them.

This mechanism will allow a HID Service to check for the validity of the peer device PNP_ID information (version, vendor, vendor src and product version), and if these are still missing, register a callback for those parameters to follow up with its connection to the device. HID Service cannot operate without this information, so there is no point opening a /dev/uhid before you have this information.

The internal mechanism mimics the D-BUS PropertyChanged events and uses the same events.

Currently, only the "Connected" event is implemented, just to show the idea behind this. After this patch set is applied, we can add more events as needed.

To test this, I simply used a small patch on the adapter.c file, creating a callback and printing the events after a device is created :

diff --git a/src/adapter.c b/src/adapter.c
index 7a2214a..5b57de9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1380,6 +1380,16 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
        return dbus_message_new_method_return(msg);
 }
 
+static void dev_prop_changed_cb(uint16_t property, uint8_t *value, uint16_t len,struct btd_device *device)
+{
+       DBG("property:%X len:%d",property,len);
+
+       if (property == DEVICE_PROPERTY_CHANGED_CONNECTED) {
+               struct property_changed_connected *p =(struct property_changed_connected*)value;
+               DBG("Device %p connected state is %d",device,p->connected);
+       }
+}
+
 static struct btd_device *create_device_internal(DBusConnection *conn,
                                                struct btd_adapter *adapter,
                                                const char *address, int *err)
@@ -1401,6 +1411,8 @@ static struct btd_device *create_device_internal(DBusConnection *conn,
        if (!device && err)
                *err = -ENOMEM;
 
+       btd_device_add_prop_changed_cb(device,dev_prop_changed_cb);
+
        return device;
 }

Thanks,
Chen Ganir


> -----Original Message-----
> From: Chen Ganir [mailto:chen.ganir@gmail.com] On Behalf Of Ganir, Chen
> Sent: Wednesday, March 28, 2012 4:46 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Ganir, Chen
> Subject: [PATCH 0/4] Add Property Changed callbacks to btd_device
> 
> From: Chen Ganir <chen.ganir@ti.com>
> 
> Add a callback mechanism for the btd_device, allowing other parts of
> the bluez
> stack to receive notifications for device properties which are changed.
> This
> mechanism is based on the D-BUS API for Device PropertyChanged.
> 
> Chen Ganir (4):
>   Add property changed callback
>   Centralize property changed events
>   Use macros instead of strings
>   Call registered callbacks
> 
>  src/device.c |  223 +++++++++++++++++++++++++++++++++++++++++++++++++-
> --------
>  src/device.h |   93 ++++++++++++++++++++++++
>  2 files changed, 281 insertions(+), 35 deletions(-)
> 
> --
> 1.7.4.1

