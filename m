Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 08/15] android: Add adapter and device struct for BlueZ daemon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010123638.GL23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 14:40:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <712DEE67-E6FE-4C4C-AD34-48A1308AC3A5@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-9-git-send-email-Andrei.Emeltchenko.news@gmail.com> <02A1A12C-50FA-4B1E-A85F-979EE842C2D4@holtmann.org> <20131010123638.GL23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> Adapter structure in BlueZ daemon keeps track of default adapter
>>> and device structure keeps track about found devices.
>>> ---
>>> android/bt_adapter.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++
>>> android/bt_adapter.h |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 116 insertions(+)
>>> create mode 100644 android/bt_adapter.c
>>> create mode 100644 android/bt_adapter.h
>>> 
>>> diff --git a/android/bt_adapter.c b/android/bt_adapter.c
>>> new file mode 100644
>>> index 0000000..e21d50c
>>> --- /dev/null
>>> +++ b/android/bt_adapter.c
>>> @@ -0,0 +1,56 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
>>> + *
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modify
>>> + *  it under the terms of the GNU General Public License as published by
>>> + *  the Free Software Foundation; either version 2 of the License, or
>>> + *  (at your option) any later version.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program; if not, write to the Free Software
>>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>> + *
>>> + */
>>> +
>>> +#include "bt_adapter.h"
>> 
>> the include of its own header should always be the last one. Never the first one.
>> 
>> 
>>> +#include "log.h"
>>> +#include "src/shared/mgmt.h"
>>> +
>>> +struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
>>> +{
>>> +	struct bt_adapter *adapter;
>>> +
>>> +	adapter = g_try_new0(struct bt_adapter, 1);
>>> +	if (!adapter)
>>> +		return NULL;
>> 
>> Since this all brand new code, use g_new0 and we just exit on memory allocation failures for our own data structures.
>> 
> 
> Do you mean exit(1)?

please understand on how g_new0 works.

> 
>>> +
>>> +	adapter->dev_id = index;
>>> +	adapter->mgmt = mgmt_ref(mgmt_if);
>>> +
>>> +	return adapter;
>>> +}
>>> +
>>> +void adapter_start(struct bt_adapter *adapter)
>> 
>> Why does this now have no bt_ prefix?
>> 
>>> +{
>>> +	DBG("enabled %u", adapter->dev_id);
>>> +
>>> +	/* TODO: CB: report scan mode */
>>> +
>>> +	/* TODO: SDP start here */
>>> +
>>> +	/* TODO: CB: report state on */
>>> +}
>>> +
>>> +void adapter_stop(struct bt_adapter *adapter)
>>> +{
>>> +	DBG("disabled %u", adapter->dev_id);
>>> +}
>>> diff --git a/android/bt_adapter.h b/android/bt_adapter.h
>>> new file mode 100644
>>> index 0000000..6877cc7
>>> --- /dev/null
>>> +++ b/android/bt_adapter.h
>>> @@ -0,0 +1,60 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
>>> + *
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modify
>>> + *  it under the terms of the GNU General Public License as published by
>>> + *  the Free Software Foundation; either version 2 of the License, or
>>> + *  (at your option) any later version.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program; if not, write to the Free Software
>>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>> + *
>>> + */
>>> +
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> +#include <glib.h>
>>> +
>>> +#include "lib/bluetooth.h"
>>> +
>>> +struct bt_device {
>>> +	int refcnt;
>>> +
>>> +	bdaddr_t bdaddr;
>>> +	uint8_t bdaddr_type;
>>> +	uint32_t cod;
>>> +	char *name;
>>> +};
>> 
>> Why is bt_device declared in bt_adapter.
>> And why are these public in the first place. Please hide these details.
> 
> So do you want it to be added in main.c? Those structs are public also in
> BlueZ.

struct bt_adapter;

Just forward declare them in the header. The actual fields do not need to be public. As I said before, this is new code and not BlueZ code that is many years old. We follow brand new style here and not copy old mistakes.

Regards

Marcel

