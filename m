Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikdXHstUxQ52RM6OMSnqfLWYJVMvg@mail.gmail.com>
References: <BANLkTikdXHstUxQ52RM6OMSnqfLWYJVMvg@mail.gmail.com>
Date: Wed, 6 Apr 2011 12:55:28 +0200
Message-ID: <BANLkTinQBr7Scuab_KAs_1L1UY-E9j87pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Support hardcoded Nintendo Wii Remote pins
From: David Herrmann <dh.herrmann@googlemail.com>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 6, 2011 at 12:04 PM, Daniele Forsi <dforsi@gmail.com> wrote:
>> The Nintendo Wii Remote requires the destination bluetooth address
>> as pincode.
>
> according to my my tests they require the source address, ie the host
> adapter's address
>
>> +             /* Nintendo Wii Remote uses destination address as PIN */
>
> better to document in that comment if it works when pressing the red
> button or the 1+2 buttons
Pressing 1+2 buttons requires the destination address, pressing the sync
button requires the source address. Since the 1+2 buttons technique is the
more easy way I decided to implement this way first, however, the bluez
daemon needs input from the user-agent to decide which method to use finally.
The Wii decides which PIN to use depending whether the red-sync button on the
Wii (yes, on the wii, not the wiimote) or the "connection" button in
the Wii-menu is used.
The latter one uses destination address, the first one source address.

I couldn't figure out when autoreconnection is established, reliably. Pairing
the wiimote works sometimes, but not always and I didn't figure out how to
reset the internal cache of reconnection addresses. My wiimote also saves up
to 3 addresses which it can reconnect to in an unreliable way and so I sometimes
end up with my wiimote starting the Wii instead of reconnecing to my
PC. However,
this issue may be solved later.

>
> I tested your 3 patches against bluez git 4.91-32-gd7f412e and
> gnome-bluetooth 2.32 but they didn't work for me for 2 reasons:
> 1) can't get vid/pid so when the remote is unknown the
> read_device_id() call in your code fails to get vid/pid and the
> specific pin is never tried; the same happens after a failed pairing
> when the /var/lib/bluetooth/*/did file contains a line this:
> 00:1F:C5:25:36:87 FFFF 0000 0000 0000
All my Wiimotes have a PnP SDP record which is fetched by the SDP code
inside bluez so VID/PID should be available. Could you test using
sdptool whether there is a valid PnP record in your wiimote? If there is
no PnP record with VID/PID information it would be useful to know how
old your wiimote is. I have 3 different wiimotes, one about 2 years old,
one 1 year old and one new WiimotePlus which is about 1/2 year old and
all of them have the same PnP record so I assumed all wiimotes have this
PnP record.
If there is a valid PnP record maybe some bluez Dev could elaborate whether
VID/PID values are guaranteed to be available when pairing is started. All
my tests worked and there was always a valid VID/PID when pairing was done.

> 2) the source vs destination address I mentioned above
Please try both methods: sync button and 1+2 buttons and report which
method works
with which PIN. As I mentioned above all my Wiimotes work with source-addr plus
red-sync-button and dest-addr plus 1+2 buttons.

>
> It works for me if I manually edit that line with the values read from
> another wiimote's line:
> 00:1F:C5:25:36:87 0002 057E 0306 0600
> and if I change dba to sba here
>>                       memcpy(pinbuf, dba, 6);
>
> how can I help you to debug these issues?
>
> BTW pairing also works when I use the test code mentioned in
> https://bugzilla.gnome.org/show_bug.cgi?id=603845#c6
This patch simply forces the source address as PIN for every device. If this
works for you, could you run the example code at:
http://goo.gl/axeqd
on the new /dev/hidrawX device which is created for the wiimote? HIDRAW support
must be enabled in the kernel of course.
This should give you VID/PID information and the HID descriptor table.
Git-url for this is: http://goo.gl/odnwd

> --
> Daniele Forsi

Thanks for helping. I think if we could figure out how to reliably get
the VID/PID
values we can change the PIN to sda to support all devices. Patch 1
and 2 of my series
might be applied anyway to allow binary pins. This would also allow to
extend the
DBUS agent interface.
If you have ideas how to support both, sba and dba via some new DBUS
interface, I would
be glad to hear about it.

David
