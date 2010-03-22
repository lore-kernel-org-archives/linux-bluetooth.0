Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Mar 2010 09:48:47 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Przemo Firszt <przemo@firszt.eu>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel <marcel@holtmann.org>,
	Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] Add sysfs speed attribute for wacom bluetooth
 tablet
In-Reply-To: <1268939541.3639.13.camel@pldmachine>
Message-ID: <alpine.LNX.2.00.1003220947310.18642@pobox.suse.cz>
References: <1268925902.12672.25.camel@pldmachine>  <1268926015.12672.27.camel@pldmachine>  <1268926624.21548.1478.camel@localhost.localdomain> <1268939541.3639.13.camel@pldmachine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 18 Mar 2010, Przemo Firszt wrote:

> > On Thu, 2010-03-18 at 15:26 +0000, Przemo Firszt wrote:
> > 
> > > +       unsigned char speed;
> > 
> > Could you add some comments as to what values represent what speed?
> I changed name from 'speed' to 'high_speed' as per your comment below,
> so I think there is no need (unless you think otherwise). 
> > 
> > > +static ssize_t wacom_store_speed(struct device *dev,
> > > +                               struct device_attribute *attr,
> > > +                               const char *buf, size_t count)
> > > +{
> > > +       struct hid_device *hdev = container_of(dev, struct hid_device,
> > > dev);
> > > +       int new_speed;
> > > +
> > > +       sscanf(buf, "%1d", &new_speed);
> > 
> > You should check the retval of sscanf as well.
> Done, see attached patch.
> > > +       if (new_speed == 0 || new_speed == 1) {
> > > +               wacom_poke(hdev, new_speed);
> > > +               return strnlen(buf, PAGE_SIZE);
> > > +       } else
> > > +               return -EINVAL;
> > > +} 
> > 
> > > 
> > > +static DEVICE_ATTR(speed, S_IRUGO | S_IWUGO,
> > > +               wacom_show_speed, wacom_store_speed);
> > 
> > If there's only 2 speeds available, and it's actually a boolean, I'd
> > rather you used a name like "high_speed".
> > 
> > Furthermore, wdata->speed doesn't look like it's initialised.
> It is initialised by the very first call of wacom_poke from wacom_probe
> function. Can you advise if it's enough?
> > 
> > Did you test whether speed switching works after the device has been
> > started up?
> Yes, it works like a charm, both ways. 
> [przemo@pldmachine ~]$ echo 0 > /sys/class/hidraw/hidraw1/device/speed
> and lag is gone,
> [przemo@pldmachine ~]$ echo 1 > /sys/class/hidraw/hidraw1/device/speed
> and "rubber band" effect is back.

The patch looks fine to me, so I have applied it to my tree.

Could you also please send a followup patch which would add 
Documentation/ABI entry for the speed attribute?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
