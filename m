Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Apr 2009 16:02:01 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090407200201.GA18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904061457.02511.gene.heskett@verizon.net> <20090406221444.GA25011@dactyl.hungrycats.org> <200904071454.54317.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <200904071454.54317.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2009 at 02:54:54PM -0400, Gene Heskett wrote:
> But nothing seems to enable the pairing, and everytime I do that that far=
 in=20
> the 'bluetooth-wizard' and it sees the eb101, it tells me to enter an=20
> apparently randomly derived 4 digit pin number, but the wizard gives me n=
o=20
> place to enter it. Nor is there a 'proceed' button, and in 5 seconds or s=
o it=20
> clears that screen and reports pairing failed.

bluez-gnome (where your bluetooth-wizard comes from?) has a really stupid
UI design.  If bluetooth-wizard thinks you *can* enter a PIN into your
device, it will *require* you to enter a random one.  This idea doesn't
work so well on devices that don't have keyboards or that have fixed PINs,
and bluetooth-wizard knows only about broad categories of devices and a
handful of exceptions.  The opposite problem occurs on devices where
bluez-gnome thinks it knows a fixed-PIN device's PIN, but it actually
doesn't.

Also, bluez-gnome's discovery page won't show you discoverable devices that
are already known, so it can't tell you if a known device is in range.
'hcitool scan' will tell you about all devices in range, but it causes some
problems for bluetoothd if both are running at the same time.

If you can, use simple-agent instead of bluetooth-wizard.

> Aha!  A chance comment I read someplace paid off!  I knew the PIN code fo=
r=20
> that device was 0000 after a factory reset, which had been done several t=
imes. =20
> The comment was that if a pairing failed, they had to be powered off befo=
re it=20
> could be tried again, so I went to the other end and did a powerdown rese=
t,=20
> than came backup up to here and swapped one for the other of the 2 device=
s I=20
> had here, which have identical bdaddr's.

How do you have two devices with identical bdaddr's?  Doesn't that wreak
all sorts of havoc for a piconet?  I would expect it to make all the link
key management stop working, since link keys are randomly generated on
each device, but stored in a database keyed by bdaddr.  Also, the piconet
master clock for radio frequency hopping is keyed off the master's bdaddr,
and has to be unique for each piconet.

> Then I ran
> [root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
> RequestPinCode (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)
> Enter PIN Code: 0000
> Release
> New device (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)
>=20
> Ok, tapped the hdwe reset on the coco3 and let it reboot which restarts t=
he=20
> shell I killed that should be available for minicom to talk to.. =20

So at this point you should have a link key established between your
Bluetooth devices.  You have successfully completed pairing, and
if the remote device has non-volatile storage, it will stay paired.
Normal remote devices do have non-volatile storage for link keys,
but I'm not sure your devices are normal.

> Operative word is 'should':
> [root@coyote test]# minicom
> minicom: cannot open /dev/rfcomm0: No such file or directory
> [root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
> Creating device failed: org.bluez.Error.AlreadyExists: Bonding already ex=
ists

Yep, still paired...at least on the BlueZ side.

> [root@coyote test]# rfcomm release all
> [root@coyote test]# rfcomm bind 0 00:0c:84:00:86:F8

I think this creates a device file named "0".  Try "/dev/rfcomm0" instead.

Also make sure that /dev/rfcomm0 exists after you've finished rfcomm bind.
If you're using udev (which all modern distros should be), this should
happen automatically after binding.  If it doesn't, you can try "MAKEDEV
rfcomm0" or "mknod /dev/rfcomm0 c 216 0".

> [root@coyote test]# minicom
> minicom: cannot open /dev/rfcomm0: No such file or directory
>=20
> I think I'm battling with a bad error message that isn't telling me what =
I=20
> think it is.

No, in this case it's probably telling you that /dev/rfcomm0 really
doesn't exist.  *Why* it doesn't exist is a separate question.  ;)

> [root@coyote test]# rfcomm connect 0 00:0c:84:00:86:F8 1
> Can't connect RFCOMM socket: Host is down

This usually means your remote device isn't connectable, or out of
range, or has turned itself off, or has crashed, or maybe some other
device has connected to the device you're trying to connect to.

Apparently it can also mean the device isn't paired...or at least I get
the same error when trying to bind rfcomm sockets to unpaired devices.
So maybe you're not so paired after all.

It should be /dev/rfcomm0, not just 0, I think.

> [root@coyote test]# sdptool browse 00:0c:84:00:86:F8
> Failed to connect to SDP server on 00:0C:84:00:86:F8: Host is down
>=20
> So what is the real problem here other than I'm a clueless newbie?

It looks like your remote device is pairable, but maybe requires some kind
of magic button sequence to make it connectable.  That would be odd, but
within the realm of possibility.

Or, your Bluetooth adapter hangs right after pairing.  That would also
be odd, but possible.  There would probably be kernel log messages in
that case at around the time it fails.  Also, 'hciconfig hci0 reset'
might help if this is the case.

Another thing to watch out for is that a few devices like to power
themselves off if nothing is connected to them for some time.  I have a
headset that does this, which pretty much guarantees I'll never receive
a phone call with it.

Or possibly you have two devices with identical bdaddr, and they're both
turned on at the same time, or you've paired with one and are now trying
to connect to the other.

> Did that:
> [root@coyote test]# rfcomm release all
> [root@coyote test]# rfcomm bind /dev/rfcomm0 00:0C:84:00:86:F8 1
[...]=20
> Terminal programs such as minicom cannot connect to /dev/rfcomm0, claimin=
g it=20
> does not exist.
> root@coyote test]# ls -l /dev/rfcomm*
> crw------- 1 root root 216, 0 2009-04-07 13:08 /dev/rfcomm0
> [root@coyote test]# minicom
> minicom: cannot open /dev/rfcomm0: No such file or directory
>=20
> Next?

You seem to have paired successfully, but can't get any connections to
work afterwards.

Maybe try 'l2ping' to verify the remote device is still on?


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbsTkACgkQgfmLGlazG5xPYwCg5Nd5cbCpNPeBlMuC2tAvaORx
OMgAoN7S4XD4UHlBx61m10hoz0dXtX6C
=G+Nb
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
