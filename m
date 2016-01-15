Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 15 Jan 2016 14:06:34 -0500
From: Don Zickus <dzickus@redhat.com>
To: =?utf-8?Q?=C5=81ukasz?= Rymanowski <lukasz.rymanowski@codecoup.pl>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: example GATT code to talk with a sensortag
Message-ID: <20160115190634.GW127976@redhat.com>
References: <20160108222608.GU152924@redhat.com>
 <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
 <20160111181454.GZ152924@redhat.com>
 <CABBYNZ+9ETX4zxBWvZL_G6_8WXND0W4rGVPj+6YKyrCOzuUUhQ@mail.gmail.com>
 <20160111222207.GE152924@redhat.com>
 <CAExxLLBApkDFsPE_xbbcsQPq7CMs3a+iM7uSyM3yQzHyf3Fa0Q@mail.gmail.com>
 <20160113150640.GH127976@redhat.com>
 <CAExxLLBo+Aytnztc1BhMjExeThZiG_NDey1JQq37+eknsBv3HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAExxLLBo+Aytnztc1BhMjExeThZiG_NDey1JQq37+eknsBv3HA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 13, 2016 at 10:44:02PM +0100, Łukasz Rymanowski wrote:
> >> Start discovery from org.bluez.Adapter1. After that find device object
> >> of your device. Then connect to this device form org.bluez.Device1.
> >> Once connected GattServices and GattCharacteristincs should be visible for you.
> >>
> >> All this you can do with d-feet of course.
> >
> > So, I tried your suggestions from within d-feet and made good progress, but
> > I don't think I am quite there yet.  Here is what I did inside d-feet:
> >
> > Under /org/bluez/hci0 -> Interfaces -> org.bluez.Adapter1 -> Methods ->
> > StartDiscovery  --> double clicked and 'executed' this
> >
> > Under /org/bluez/hci0/dev_XXXXX -> Interfaces -> org.bluez.Device1 ->
> > Methods -> Connect --> double clicked and 'executed' this
> >
> > Under /org/bluez/hci0/dev_XXXX -> Interfaces ->
> > org.freedesktop.DBus.Properties -> GetAll ---> double clicked, entered
> > '"org.bluez.Device1"' and 'executed' this
> >     ---> received  valid UUIDs, GattServices, etc as output
> >
> > Thank you!
> >
> >
> > I did _not_ see GattCharacteristic1 in the output, nor do I see either
> > GattService or GattCharacteristic1 show up as an interface in either
> > /org/bluez/hci0/dev_XXXXX or /org/bluez/hci0.
> >
> >
> > Did I miss a step or misunderstand your suggestion?
> 
> You got it well.
> To be more clear.
> If your bluetoothd runs with -E option and you connect to BLE device
> which expose any GATT services, after connect you should see new
> objects paths. Smth like this:
> 
> a) /org/bluez/hci0/dev_XXXXX/servicexxxx
> b) /org/bluez/hci0/dev_XXXXX/servicexxxx/charyyyy
> c) /org/bluez/hci0/dev_XXXXX/servicexxxx/charzzzz
> 
> etc.
> 
> Inside a) you should see GattService1 and inside b) and c) GattCharacteristic1
> 
> Just make sure -E is there and if still not work, provide btmon.log

Hi Łukasz,

Yup, I see those now and the expected GattService1/Characteristic1
interfaces.

Thanks! I'll use that with the example-gatt-client to get me going.  Thanks
again!

Cheers,
Don

