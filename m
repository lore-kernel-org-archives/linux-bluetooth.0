Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 1/4] gatt: Add skeleton of gatt-db
Date: Thu, 24 Apr 2014 12:40:57 +0200
Message-ID: <1822306.b06b6dMSrs@leonov>
In-Reply-To: <1397632747-13308-2-git-send-email-marcin.kraglak@tieto.com>
References: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com> <1397632747-13308-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 16 of April 2014 09:19:04 Marcin Kraglak wrote:
> This change adds new() and destroy() fuctions for gatt_db,
> which will be used for storing local attributes.
> ---
>  android/Android.mk   |  1 +
>  android/Makefile.am  |  1 +
>  src/shared/gatt-db.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-db.h | 38 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
>  create mode 100644 src/shared/gatt-db.c
>  create mode 100644 src/shared/gatt-db.h
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 5f4e70c..4c9cfb5 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -51,6 +51,7 @@ LOCAL_SRC_FILES := \
>  	bluez/src/shared/queue.c \
>  	bluez/src/shared/ringbuf.c \
>  	bluez/src/shared/hfp.c \
> +	bluez/src/shared/gatt-db.c \
>  	bluez/src/shared/io-glib.c \
>  	bluez/src/sdpd-database.c \
>  	bluez/src/sdpd-service.c \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index c51cce2..70e1dec 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -29,6 +29,7 @@ android_bluetoothd_SOURCES = android/main.c \
>  				src/shared/mgmt.h src/shared/mgmt.c \
>  				src/shared/ringbuf.h src/shared/ringbuf.c \
>  				src/shared/hfp.h src/shared/hfp.c \
> +				src/shared/gatt-db.h src/shared/gatt-db.c \
>  				android/bluetooth.h android/bluetooth.c \
>  				android/hidhost.h android/hidhost.c \
>  				android/ipc-common.h \
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> new file mode 100644
> index 0000000..e56b381
> --- /dev/null
> +++ b/src/shared/gatt-db.c
> @@ -0,0 +1,47 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA + *
> + */
> +
> +#include "src/shared/util.h"
> +#include "src/shared/gatt-db.h"
> +
> +struct gatt_db {
> +	uint16_t next_handle;
> +};
> +
> +struct gatt_db *gatt_db_new(void)
> +{
> +	struct gatt_db *db;
> +
> +	db = new0(struct gatt_db, 1);
> +	if (!db)
> +		return NULL;
> +
> +	db->next_handle = 0x0001;
> +
> +	return db;
> +}
> +
> +void gatt_db_destroy(struct gatt_db *db)
> +{
> +	free(db);
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> new file mode 100644
> index 0000000..b3cd7a6
> --- /dev/null
> +++ b/src/shared/gatt-db.h
> @@ -0,0 +1,38 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA + *
> + */
> +
> +struct gatt_db;
> +
> +/*
> + * gatt_db_new - Create new database for storing attributes
> + *
> + * Returns new database. In case of error NULL will be returned.
> + */
> +struct gatt_db *gatt_db_new(void);
> +
> +/*
> + * gatt_db_destroy - Destroy gatt database
> + *
> + * @db - gatt database to be destroyed
> + */
> +void gatt_db_destroy(struct gatt_db *db);

I'd avoid adding doxygen style comments. Those functions are self-explanatory.

-- 
BR
Szymon Janc
