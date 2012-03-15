Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331808559-12880-7-git-send-email-arik@wizery.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
	<1331808559-12880-7-git-send-email-arik@wizery.com>
Date: Thu, 15 Mar 2012 08:08:56 -0400
Message-ID: <CAJdJm_N-BfUN3FUjDx0kv3+-uQ=L+uhXGzXM9ec+qH-frQMk_Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] proximity: reporter: implement D-Bus API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 15, 2012 at 6:49 AM, Arik Nemtsov <arik@wizery.com> wrote:
> Register a D-Bus interface per remote device. Set a watch on the
> "DeviceAdded" signal to add all existing devices. Likewise set watches
> on "DeviceCreated" and "DeviceRemoved" to handle dynamic addition and
> removal of devices.

The paragraph above does not apply anymore. You need to update to
refer to the device driver.

> +/* device driver for tracking remote GATT client devices */
> +static struct btd_device_driver reporter_dev_tracker_driver = {

What about using "reporter_device_driver"

> +       .name = "Proximity GATT Reporter Device Tracker Driver",

And "Proximity GATT Reporter Device Driver"

> +       .uuids = BTD_UUIDS(GATT_UUID),
> +       .probe = gatt_device_probe,
> +       .remove = gatt_device_remove,

And using reporter_probe() / reporter_remove()

> +};
> +

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
