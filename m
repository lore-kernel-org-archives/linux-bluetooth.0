Return-Path: <cyrus@holtmann.org>
Message-ID: <49762FAC.8090007@dell.com>
Date: Tue, 20 Jan 2009 14:10:20 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Dell Wireless 360 Bluetooth HID devices not being remembered
 over suspend/reboot
References: <b3f4dcd00901161441n6e2d98e6l193bcc8372fd2bc8@mail.gmail.com> <1232291616.5095.13.camel@californication>
In-Reply-To: <1232291616.5095.13.camel@californication>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3EA3C6EBAA021A8C82C502F"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3EA3C6EBAA021A8C82C502F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guys:

Unfortunately I haven't been able to get ahold of the documentation for
what is happening under the hood here.  If I do, i'll be glad to get
some form of a patch together or try to get said documentation released.

Regards

Marcel Holtmann wrote:
> Hi Matthew,
>
>  =20
>> I know that this is a developers list, but I have dug pretty deeply
>> here and got to the bottom of what the built-in USB bluetooth dongle
>> is.  I have found that its CSR based.   Under Windows Vista my Apple
>> keyboard and Logitech MX 900 work and are remembered across boots.
>> From what I have heard, this device should just work.  System is a
>> Dell Vostro 1510 with Intel Core2Duo running Ubuntu Intrepid Ibex,
>> bluez 4.22.  I also have an Intel 3945 ABG PCI mini wireless card in
>> it as well.
>>
>> I am willing to do the hacking to get this going - I used to submit
>> patches to the Linux kernel and develop/patch network drivers for
>> Frame Relay WAN, as well as making the 2.2x ehternet bridge accessible=

>> via a virtual ethernet interface - my email address was
>> grantma@anathoth.gen.nz.
>>
>> Should I be using the module flags for a straight CSR modem?  Is the
>> kernel module btusb ths only place the bluez stack looks hard at the
>> hardware?
>>
>> From what I have found looking at posts to the list, the CSR dongle,
>> once it is set up properly - I don't mind running a CSR DFU firmware
>> on it - it should just work.
>>
>> I am going to test software by using my old Logitech dongle in the MX
>> 900 base station-charger.
>>
>> Getting the mouse going reliably and keyboard is going to help with my=

>> frustrations with the small sized keys on the laptop keyboard when
>> essay writing - currently  I am rebinding the OOo.org keys into an
>> emacs type of keymap.
>>
>> lsusb and hciconfig -a output follow.  Is there anything else that may=

>> be helpful?
>>
>> I gather that solving this will help out a lot of Ubuntu Dell laptop u=
sers.
>>    =20
>
> check with "hciconfig hci0 revision" and "bccmd buildname" (both as
> root) if they have a special Dell firmware running on it. If not then
> there can be still a Dell custom application running in the VM of the
> Bluetooth chip.
>
> Best bet is to ask Mario from Dell if he can help us out here and maybe=

> make HID/HCI switching persistent across reboots. If not then we might
> have to write a bluetoothd plugin that does the job for us.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigA3EA3C6EBAA021A8C82C502F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkl2L6wACgkQ2CrZjkA73YvRNwCfVh7EVfJFHnSGa9L+xFmLUk2E
TfcAoJSOoUdopfDeM34OBKZ4JVbEYQW9
=xPLx
-----END PGP SIGNATURE-----

--------------enigA3EA3C6EBAA021A8C82C502F--
