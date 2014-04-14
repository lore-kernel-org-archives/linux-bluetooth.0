Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBd_sJ0Q17BV1Q8z9zr8mQd=iuj8GMPQcnVB=x7FRg_05w@mail.gmail.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
	<1397027234-12003-2-git-send-email-marcin.kraglak@tieto.com>
	<CAKT1EBd_sJ0Q17BV1Q8z9zr8mQd=iuj8GMPQcnVB=x7FRg_05w@mail.gmail.com>
Date: Mon, 14 Apr 2014 21:15:13 +0200
Message-ID: <CABD6X-K=u9jN0P6ZoxYwhaEftt=XVD9kbgY8VwxbN8qPjvfb7w@mail.gmail.com>
Subject: Re: [RFC 01/16] gatt: Add skeleton of gatt-db
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On 14 April 2014 16:12, Claudio Takahasi <claudio.takahasi@openbossa.org> wrote:
> Hi Marcin,
>
> On Wed, Apr 9, 2014 at 4:06 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
>> This change adds new() and destroy() fuctions for gatt_db,
>> which will be used for storing local attributes.
>> ---
>>  android/Android.mk   |  1 +
>>  android/Makefile.am  |  1 +
>>  src/shared/gatt-db.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/gatt-db.h | 27 +++++++++++++++++++++++++++
>>  4 files changed, 76 insertions(+)
>>  create mode 100644 src/shared/gatt-db.c
>>  create mode 100644 src/shared/gatt-db.h
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index 5f4e70c..4c9cfb5 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -51,6 +51,7 @@ LOCAL_SRC_FILES := \
>>         bluez/src/shared/queue.c \
>>         bluez/src/shared/ringbuf.c \
>>         bluez/src/shared/hfp.c \
>> +       bluez/src/shared/gatt-db.c \
>>         bluez/src/shared/io-glib.c \
>>         bluez/src/sdpd-database.c \
>>         bluez/src/sdpd-service.c \
>> diff --git a/android/Makefile.am b/android/Makefile.am
>> index c51cce2..70e1dec 100644
>> --- a/android/Makefile.am
>> +++ b/android/Makefile.am
>> @@ -29,6 +29,7 @@ android_bluetoothd_SOURCES = android/main.c \
>>                                 src/shared/mgmt.h src/shared/mgmt.c \
>>                                 src/shared/ringbuf.h src/shared/ringbuf.c \
>>                                 src/shared/hfp.h src/shared/hfp.c \
>> +                               src/shared/gatt-db.h src/shared/gatt-db.c \
>>                                 android/bluetooth.h android/bluetooth.c \
>>                                 android/hidhost.h android/hidhost.c \
>>                                 android/ipc-common.h \
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> new file mode 100644
>> index 0000000..e56b381
>> --- /dev/null
>> +++ b/src/shared/gatt-db.c
>> @@ -0,0 +1,47 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#include "src/shared/util.h"
>> +#include "src/shared/gatt-db.h"
>> +
>> +struct gatt_db {
>> +       uint16_t next_handle;
>> +};
>> +
>> +struct gatt_db *gatt_db_new(void)
>> +{
>> +       struct gatt_db *db;
>> +
>> +       db = new0(struct gatt_db, 1);
>> +       if (!db)
>> +               return NULL;
>> +
>> +       db->next_handle = 0x0001;
>> +
>> +       return db;
>> +}
>
> Are you considering to use the same function to allocate/create a
> database to represent the remote "virtual" database?
> My point is: the same infra-structure could be used to represent a
> local database(per adapter maybe) or remote database.
>

We could add argument to new() like type: remote or local. What you
think about it?
> <snip>
>
> Regards,
> Claudio
