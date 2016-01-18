Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 18 Jan 2016 17:29:07 -0500
From: Don Zickus <dzickus@redhat.com>
To: =?utf-8?Q?=C5=81ukasz?= Rymanowski <lukasz.rymanowski@codecoup.pl>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: example GATT code to talk with a sensortag
Message-ID: <20160118222907.GA127976@redhat.com>
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
> Hi Don,
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

Sorry to bother you again.  I am trying to turn what I learned from d-feet
into something for python.  I can get UUIDs from the GetAll() command, but
no GattService info.  I then noticed the device is not connected.  So I
tried connecting it using the Connect() command.  It keeps timing out.

There isn't much fomr btmon, but it looks useful so I attached it below.
Help?

I tried doing this under bluetootctl too and had some strange timeout
requests.  When I execute 'connect xx:xx:xx', it seems to connect, start
dumping info, then disconnects with an error/timeout.

Cheers,
Don

python snippet..

    service = bus.get_object(BLUEZ_SERVICE_NAME, "/org/bluez/hci0/dev_68_C9_0B_06_FA_8A")
    service.Connect(dbus_interface="org.bluez.Device1")
    service_props = service.GetAll("org.bluez.Device1", dbus_interface=DBUS_PROP_IFACE)


btmon output


< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7 [hci0] 374.345329
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4  [hci0] 374.346096
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2 [hci0] 374.346190
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4  [hci0] 374.347102
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2 [hci0] 414.345224
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4  [hci0] 414.347154
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)

python failure message:


Did not receive a reply. Possible causes include: the remote application did
not send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken.


