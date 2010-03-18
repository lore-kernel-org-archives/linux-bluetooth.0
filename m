Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth
 tablet
From: Bastien Nocera <hadess@hadess.net>
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel
 <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping
 <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <1268926015.12672.27.camel@pldmachine>
References: <1268925902.12672.25.camel@pldmachine>
	 <1268926015.12672.27.camel@pldmachine>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 18 Mar 2010 15:37:04 +0000
Message-ID: <1268926624.21548.1478.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2010-03-18 at 15:26 +0000, Przemo Firszt wrote:

> +       unsigned char speed;

Could you add some comments as to what values represent what speed?

> +static ssize_t wacom_store_speed(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct hid_device *hdev = container_of(dev, struct hid_device,
> dev);
> +       int new_speed;
> +
> +       sscanf(buf, "%1d", &new_speed);

You should check the retval of sscanf as well.

> +       if (new_speed == 0 || new_speed == 1) {
> +               wacom_poke(hdev, new_speed);
> +               return strnlen(buf, PAGE_SIZE);
> +       } else
> +               return -EINVAL;
> +} 

> 
> +static DEVICE_ATTR(speed, S_IRUGO | S_IWUGO,
> +               wacom_show_speed, wacom_store_speed);

If there's only 2 speeds available, and it's actually a boolean, I'd
rather you used a name like "high_speed".

Furthermore, wdata->speed doesn't look like it's initialised.

Did you test whether speed switching works after the device has been
started up?

Cheers
