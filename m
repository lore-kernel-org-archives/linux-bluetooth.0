Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050109212302.GB5291@penguinhosting.net>
References: <20050109212302.GB5291@penguinhosting.net>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1105324578.8637.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 Jan 2005 03:36:18 +0100

Hi Ian,

> I have an Apple bluetooth keyboard and mouse.  I can connect to and use
> the mouse as expected.  However, attempting to connect to the keyboard:
>=20
> sheba% sudo hcitool scan
> Scanning ...
> 	00:0A:95:3A:4E:1C	ian=C3=A2=E2=82=AC=E2=84=A2s keyboard
>=20
> gives me:
>=20
> sheba% sudo hidd --search
> Bluetooth: HIDP (Human Interface Emulation) ver 1.0
> Searching ...
>         Connecting to device 00:0A:95:3A:4E:1C
> Can't create HID control channel: Function not implemented
>=20
> I never get a PIN entry request (as I did with the mouse) or any other
> error.  There's a long pause between the "Connecting to device" and the
> "Can't create".  According to lib.c in the kernel, ENOSYS is returned
> on an unrecognized error code, but I don't know enough about the packet
> formats to figure out what byte is the error code, or what else it migh=
t
> mean.  Attached is an hcidump during the "hidd --search" run.

at that pause you should type a numeric PIN on your keyboard and then
press return.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
