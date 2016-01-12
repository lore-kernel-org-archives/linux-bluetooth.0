Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160111222207.GE152924@redhat.com>
References: <20160108222608.GU152924@redhat.com>
	<CABBYNZ+bpQQH6XhM20d62wy5Y-PWw_Vq7_jhriHFmmLvJVHtAg@mail.gmail.com>
	<20160111181454.GZ152924@redhat.com>
	<CABBYNZ+9ETX4zxBWvZL_G6_8WXND0W4rGVPj+6YKyrCOzuUUhQ@mail.gmail.com>
	<20160111222207.GE152924@redhat.com>
Date: Tue, 12 Jan 2016 22:52:47 +0100
Message-ID: <CAExxLLBApkDFsPE_xbbcsQPq7CMs3a+iM7uSyM3yQzHyf3Fa0Q@mail.gmail.com>
Subject: Re: example GATT code to talk with a sensortag
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: Don Zickus <dzickus@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

On 11 January 2016 at 23:22, Don Zickus <dzickus@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 03:43:40PM -0300, Luiz Augusto von Dentz wrote:
>> Hi Don,
>>
>>
>> You will need to pass -E to bluetoothd to enable the experimental
>> intefaces, btw there is a recent change to GATT server/peripheral so I
>> suggest you try with the current version on git.
>
> Hi Luiz,
>
> I passed the -E and compiled and installed the latest git version of bluez
>
> commit e81aeaea21db84042ee0c30159290ca56d250111
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Wed Jan 6 12:20:45 2016 -0300
>
> I installed d-feet to help me with the d-bus interfaces as I was struggling
> with that.  With the -E option I now see 'GattManager1' pop up under
> '/org/bluez/hci0'.
>
> I guess I was expecting to see a 'GattService1' and 'GattCharacteristic1',
> but I don't.
>

Start discovery from org.bluez.Adapter1. After that find device object
of your device. Then connect to this device form org.bluez.Device1.
Once connected GattServices and GattCharacteristincs should be visible for you.

All this you can do with d-feet of course.

Also, run btmon so you can see HCI traffic. In case it still does not
work, you can
try shate btmon log here.


> I tried poking the 'GetAll' interfaces under my device
> '/org/bluez/hci0/dev_XXXXXX' using 'org.bluez.Device1' as my interface.
> That got me some device info but my UUIDs were empty [].  I tried using the
> 'Connect' Method in the same interface but that didn't seem to change
> anything.
>
> I am scratching my head trying to understand how this works.  Looking
> through the documentation in the bluez tree it appears I need a gatt-server
> that provides 'GattServices1'?  Did I read that wrong?
>
> Again, my goal was to simply read temperature data out of my sensor.  I know
> the UUID and the handle (from my successful use of the gatttool), I just
> don't know how to connect to the DBus correctly??? to get the same info.
>
> Perhaps I falsely assumed that if gatttool can get it, then there was an
> interface that I can use to get the same info.
>
> I apologize for all the newbie questions.  And thank you for your patience
> and help so far.
>
> Cheers,
> Don
>

BR
Lukasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
BR / Pozdrawiam
Łukasz
