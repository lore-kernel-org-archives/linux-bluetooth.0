Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 10:28:19 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 09/16] android: Add adapter and device struct for BlueZ
 daemon
Message-ID: <20130930072817.GB10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <C606466F-9DC7-45F0-A73C-FA7940DD7CF1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C606466F-9DC7-45F0-A73C-FA7940DD7CF1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013 at 03:38:39PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Adapter structure in BlueZ daemon keeps track of default adapter
> > and device structure keeps track about found devices.
> > ---
> > android/bt_adapter.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > android/bt_adapter.h |   68 ++++++++++++++++++++++++++
> > 2 files changed, 197 insertions(+)
> > create mode 100644 android/bt_adapter.c
> > create mode 100644 android/bt_adapter.h
> > 
> > diff --git a/android/bt_adapter.c b/android/bt_adapter.c
> > new file mode 100644
> > index 0000000..9f64839
> > --- /dev/null
> > +++ b/android/bt_adapter.c
> > @@ -0,0 +1,129 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + *
> > + */
> > +
> > +#include "bt_adapter.h"
> > +#include "log.h"
> > +#include "src/shared/mgmt.h"
> > +
> > +struct bt_device *bt_device_ref(struct bt_device *device)
> > +{
> > +	DBG("");
> > +
> > +	__sync_fetch_and_add(&device->refcnt, 1);
> > +
> > +	return device;
> > +}
> > +
> > +void bt_device_unref(struct bt_device *device)
> > +{
> > +	DBG("");
> > +
> > +	if (__sync_sub_and_fetch(&device->refcnt, 1))
> > +		return;
> > +
> > +	/* TODO: */
> > +	DBG("%s: Freeing device %p name %s", __func__, device, device->name);
> > +
> > +	free(device->name);
> > +	free(device);
> > +}
> > +
> > +struct bt_adapter *bt_adapter_lookup(uint16_t index)
> > +{
> > +	GList *list;
> > +
> > +	for (list = g_list_first(adapter_list); list;
> > +						list = g_list_next(list)) {
> > +		struct bt_adapter *adapter = list->data;
> > +
> > +		if (adapter->dev_id == index)
> > +			return adapter;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +struct bt_adapter *bt_adapter_ref(struct bt_adapter *adapter)
> > +{
> > +	DBG("");
> > +
> > +	__sync_fetch_and_add(&adapter->refcnt, 1);
> > +
> > +	return adapter;
> > +}
> > +
> > +static void bt_adapter_free(struct bt_adapter *adapter)
> > +{
> > +	DBG("");
> > +
> > +	while (adapter->found_devices) {
> > +		struct bt_device *device = adapter->found_devices->data;
> > +
> > +		adapter->found_devices = g_list_remove(adapter->found_devices,
> > +								device);
> > +		bt_device_unref(device);
> > +	}
> > +
> > +	mgmt_unref(adapter->mgmt);
> > +	free(adapter);
> > +}
> > +
> > +void bt_adapter_unref(struct bt_adapter *adapter)
> > +{
> > +	DBG("");
> > +
> > +	if (__sync_sub_and_fetch(&adapter->refcnt, 1))
> > +		return;
> > +
> > +	bt_adapter_free(adapter);
> > +}
> > +
> > +struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
> > +{
> > +	struct bt_adapter *adapter;
> > +
> > +	adapter = g_try_new0(struct bt_adapter, 1);
> > +	if (!adapter)
> > +		return NULL;
> > +
> > +	adapter->dev_id = index;
> > +	adapter->mgmt = mgmt_ref(mgmt_if);
> > +
> > +	return bt_adapter_ref(adapter);
> > +}
> > +
> > +void adapter_start(struct bt_adapter *adapter)
> > +{
> > +	DBG("enabled %u", adapter->dev_id);
> > +
> > +	/* TODO: CB: report scan mode */
> > +
> > +	/* TODO: SDP start here */
> > +
> > +	/* TODO: CB: report state on */
> > +}
> > +
> > +void adapter_stop(struct bt_adapter *adapter)
> > +{
> > +	DBG("disabled %u", adapter->dev_id);
> > +}
> > diff --git a/android/bt_adapter.h b/android/bt_adapter.h
> > new file mode 100644
> > index 0000000..5634729
> > --- /dev/null
> > +++ b/android/bt_adapter.h
> > @@ -0,0 +1,68 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> > + *
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + *
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <glib.h>
> > +
> > +#include "lib/bluetooth.h"
> > +
> > +struct bt_device {
> > +	int refcnt;
> > +
> > +	bdaddr_t bdaddr;
> > +	uint8_t bdaddr_type;
> > +	uint32_t cod;
> > +	char *name;
> > +};
> > +
> > +struct bt_adapter {
> > +	int refcnt;
> > +
> > +	uint16_t dev_id;
> > +	struct mgmt *mgmt;
> > +	bdaddr_t bdaddr;
> > +	uint32_t dev_class;
> > +
> > +	char *name;
> > +	char *short_name;
> > +
> > +	uint32_t supported_settings;
> > +	uint32_t current_settings;
> > +
> > +	GList *found_devices;
> > +};
> > +
> > +extern GList *adapter_list;
> > +
> > +struct bt_adapter *bt_adapter_lookup(uint16_t index);
> > +struct bt_adapter *bt_adapter_ref(struct bt_adapter *adapter);
> > +void bt_adapter_unref(struct bt_adapter *adapter);
> > +struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if);
> > +
> > +struct bt_device *bt_device_ref(struct bt_device *device);
> > +void bt_device_unref(struct bt_device *device);
> > +
> > +void adapter_start(struct bt_adapter *adapter);
> > +void adapter_stop(struct bt_adapter *adapter);
> 
> since we only support one single controller and will ignore all others,
> why are we building such a complicate abstraction. We could make this
> functionality part of the core daemon and no need to create an adapter
> abstraction.
> 
> Just copying bluetoothd is not helping us here since at its core, it
> works way different. We do not need all that logic here.

I try to use pointer default_adapter which points to the first device
with index 0. For devices we still need some kind of list.

Best regards 
Andrei Emeltchenko 
