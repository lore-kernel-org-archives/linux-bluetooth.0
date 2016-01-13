Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 13 Jan 2016 10:06:41 -0500
From: Don Zickus <dzickus@redhat.com>
To: =?utf-8?Q?=C5=81ukasz?= Rymanowski <lukasz.rymanowski@codecoup.pl>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: example GATT code to talk with a sensortag
Message-ID: <20160113150640.GH127976@redhat.com>
References: <20160108222608.GU152924@redhat.com>
 <CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
 <20160111181454.GZ152924@redhat.com>
 <CABBYNZ+9ETX4zxBWvZL_G6_8WXND0W4rGVPj+6YKyrCOzuUUhQ@mail.gmail.com>
 <20160111222207.GE152924@redhat.com>
 <CAExxLLBApkDFsPE_xbbcsQPq7CMs3a+iM7uSyM3yQzHyf3Fa0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAExxLLBApkDFsPE_xbbcsQPq7CMs3a+iM7uSyM3yQzHyf3Fa0Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 12, 2016 at 10:52:47PM +0100, Łukasz Rymanowski wrote:
> Hi Don,
> 
> On 11 January 2016 at 23:22, Don Zickus <dzickus@redhat.com> wrote:
> > On Mon, Jan 11, 2016 at 03:43:40PM -0300, Luiz Augusto von Dentz wrote:
> >> Hi Don,
> >>
> >>
> >> You will need to pass -E to bluetoothd to enable the experimental
> >> intefaces, btw there is a recent change to GATT server/peripheral so I
> >> suggest you try with the current version on git.
> >
> > Hi Luiz,
> >
> > I passed the -E and compiled and installed the latest git version of bluez
> >
> > commit e81aeaea21db84042ee0c30159290ca56d250111
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Wed Jan 6 12:20:45 2016 -0300
> >
> > I installed d-feet to help me with the d-bus interfaces as I was struggling
> > with that.  With the -E option I now see 'GattManager1' pop up under
> > '/org/bluez/hci0'.
> >
> > I guess I was expecting to see a 'GattService1' and 'GattCharacteristic1',
> > but I don't.
> >

Hi Łukasz,

Thanks for the feedback!

> 
> Start discovery from org.bluez.Adapter1. After that find device object
> of your device. Then connect to this device form org.bluez.Device1.
> Once connected GattServices and GattCharacteristincs should be visible for you.
> 
> All this you can do with d-feet of course.

So, I tried your suggestions from within d-feet and made good progress, but
I don't think I am quite there yet.  Here is what I did inside d-feet:

Under /org/bluez/hci0 -> Interfaces -> org.bluez.Adapter1 -> Methods ->
StartDiscovery  --> double clicked and 'executed' this

Under /org/bluez/hci0/dev_XXXXX -> Interfaces -> org.bluez.Device1 ->
Methods -> Connect --> double clicked and 'executed' this

Under /org/bluez/hci0/dev_XXXX -> Interfaces ->
org.freedesktop.DBus.Properties -> GetAll ---> double clicked, entered
'"org.bluez.Device1"' and 'executed' this
    ---> received  valid UUIDs, GattServices, etc as output

Thank you!


I did _not_ see GattCharacteristic1 in the output, nor do I see either
GattService or GattCharacteristic1 show up as an interface in either
/org/bluez/hci0/dev_XXXXX or /org/bluez/hci0.


Did I miss a step or misunderstand your suggestion?


Cheers,
Don
