Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid updated
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: Peter Klausler <pmk@cray.com>,
   BlueZ Users List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1068933564.15097.46.camel@saag>
References: <20031106014519.GA31868@schnell>
	 <1068919368.15097.22.camel@saag>  <1068925159.19286.311.camel@pegasus>
	 <1068933564.15097.46.camel@saag>
Content-Type: text/plain
Message-Id: <1068937066.17638.346.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 15 Nov 2003 23:57:46 +0100

Hi Edd,

> Thanks for the pointer.  Attached is a patch to make Peter's software
> work with the uinput driver, suitable for bthid-0.8.  Tested under
> 2.6.0-test9.
> 
> With a bit of trouble I have this working with an Apple keyboard and an
> MS mouse.  I have found it troublesome to connect the devices:
> 
>         * power cycling the mouse is required after a connection is
>         lost, and even this doesn't always work
>         
>         * the Apple keyboard is very difficult to connect. Often after
>         reading the HID descriptor it receives no key events.
> 
> Also, the mouse events get lagged and the cursor sways drunkenly around
> the desktop: looks like we need to do something to batch up mouse events
> so the cursor keeps up with the mouse.

maybe it is a good idea to read my notes about HID

	http://www.holtmann.org/linux/bluetooth/hid.html

I also put my bthid utility into the utils2 CVS repository. It was
working fine for me and I solved the problem when the HID device
disconnects the L2CAP channels. However it depends on a modified USB HID
kernel module which allows us to input the HID reports directly into
their HID parser. But this USB HID modification is only a bad hack at
the moment.

I like to reuse the kernel HID parser from the USB subsystem, but this
is not as easy as I thought in the first place, because it is hardwired
with the USB subsystem. A HID parser is not a USB only thing, not
anymore. Maybe we should have the HID parser also in user space like
Peter's code does and use the uinput driver. At the moment I think this
is bad, because both parsers must be maintained and writing a good HID
parser is not a easy job. The kernel parser is doing quite a very good
job, but the people from the input subsystem are not very helpful in
building a general HID interface. Any thoughts about how to proceed?

As a side note, be careful with libs2 and utils2 ;)

Regards

Marcel




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
