Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_9D16A3CC-39AA-4633-997D-3A9537E1F59C"; protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Getting started with BLE device
From: Rick Mann <rmann@latencyzero.com>
In-Reply-To: <1399057367.24457.11.camel@SejoLaptop>
Date: Mon, 5 May 2014 18:19:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98A4D598-0499-42E8-B639-0A2A8AC458E8@latencyzero.com>
References: <35E2DFE7-B463-4A15-8148-F7E30A201646@latencyzero.com> <1399057367.24457.11.camel@SejoLaptop>
To: Sejo Ruiz <sejoruiz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_9D16A3CC-39AA-4633-997D-3A9537E1F59C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

I got a little farther. The following commands reveal something:

root@linaro-alip:/home/rmann# rfkill block bluetooth
root@linaro-alip:/home/rmann# rfkill unblock bluetooth
root@linaro-alip:/home/rmann# hciattach -t 30 /dev/ttymxc2 texas 115200 flow
Found a Texas Instruments' chip!
Firmware file : /lib/firmware/TIInit_7.6.15.bts
Loaded BTS script version 1
texas: changing baud rate to 3000000, flow control to 1
Device setup complete
root@linaro-alip:/home/rmann# hcitool scan
Scanning ...
    80:56:F2:FF:FF:5B   GRETCHEN-THINK
    9C:2A:70:86:00:25   MP_THINKPAD_6
    3C:77:E6:EE:E9:9F   MP_ACCOUNTANT
    7C:E9:D3:E6:68:4D   MP_THINKPAD_4
    60:D8:19:B6:9B:B4   FORGE


On May 2, 2014, at 12:02 , Sejo Ruiz <sejoruiz@gmail.com> wrote:

> Hi Rick.
> First of all, you should make sure that the device is recognized as a BT
> device. Run hciconfig as sudo user to see if it returns something as
> hci0. If you can see it, then you can do hciconfig hci0 up to set up the
> interface and start playing. If not, then you could try to do lsusb and
> see what devices are connected to the USB. If you cannot see your device
> there, or something goes wrong, you can always try to check what is
> going on by plugging the device off and on again and then type dmesg |
> tail. Finally, make sure the bluetooth daemon is running. You can do
> that by executing /etc/init.d/bluetoothd status (I'm not sure about this
> last one)
> NOTE: I suggest to execute all the commands with sudo.
> 


-- 
Rick




--Apple-Mail=_9D16A3CC-39AA-4633-997D-3A9537E1F59C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNoOJwACgkQBzBA/9aDmJugGwCgoRDWGzp48NB1ahRqaclFCKca
WJoAoK3IPIucYkvpwAntSGHrBRIsmQZp
=7hMy
-----END PGP SIGNATURE-----

--Apple-Mail=_9D16A3CC-39AA-4633-997D-3A9537E1F59C--
