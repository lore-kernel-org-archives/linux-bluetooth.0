Return-Path: <grantma@anathoth.gen.nz>
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <1098676528.6465.68.camel@pegasus>
References: <1098654320.4635.16.camel@localhost> <1098676528.6465.68.camel@pegasus>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-128455809"
Message-Id: <1C78290E-2664-11D9-938E-000D93436326@anathoth.gen.nz>
From: Matthew Grant <grantma@anathoth.gen.nz>
Subject: Re: PROBLEM: Apple powerbook, Apple BT keyboard, keyboard does not reconnect on reboot
Date: Mon, 25 Oct 2004 21:59:00 +1300
To: Marcel Holtmann <marcel@holtmann.org>, bluez-users@lists.sourceforge.net
List-ID: <bluez-users.lists.sourceforge.net>


--Apple-Mail-1-128455809
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Marcel,

Back in OS X to get this posted. Wish I had linux BT going enough so 
that I could easily use the keyboard which I am bound to because of RSI 
reasons.

There is definitely more to the Apple bluetooth than the bluez-utils 
can interface with.  It looks like Apple have changed the CSR firmware 
so that they can turn the USB BT dongle on and off for going on 
aeroplanes, and there is something with the commands to delete and add 
parings that is different as well.  Bluez does not look like it is 
doing this.

'hidd --show' does not list any devices, even when 'hcitool con' lists 
authed encrypted parings.  'hidd --killall' does not work, and 'hidd 
--kill <BT-mac>' does kill off the pairing

I went back into OS X and deleting the pairings there, rebooted back to 
linux, reformed the pairings  using 'hidd --search' , 'hidd --show' 
didn't list anything.  Rebooted from linux to linux again, and the 
keyboard did not connect.  When rebooting to OS X there were no parings 
showing either.  Maybe I should not mix them, but I need to get linux 
working fully with this onboard apple BT dongle so that I can use linux 
on this laptop.

Does hidd save pairings to disk somewhere?  I am wondering if OS X is 
doing this in addition to the flash on the built-in USB dongle.

Anyone else have experience with Apple powerbooks/keyboards, and Bluez 
HID stuff?

Thanks for all your help.

Cheers,

Matthew Grant

On 25/10/2004, at 4:55 PM, Marcel Holtmann wrote:

>> The Lower level layer is definitely connected, but the keyboard events
>> are not generating keyboard input at all.  I have to switch the 
>> keyboard
>> off, and then switch it back on, and it renegotiates, and it all 
>> starts
>> working.
>
> What does "hidd --show" tell you when the keyboard is connected, but 
> not
> working?

It does not show anything.


>> This test is not using security mode 3 yet, though I will be doing 
>> this
>> to prevent people sniffing passwords.... but the same problem happens
>> then.
>
> Actually I thought, that the Apple keyboard is always in security mode
> three, but from your dumps it looks like that this is not true when it
> reconnects. What does "hcitool con" say about the reconnect ACL link?
>
>> When I boot from OS X back into Linux, the problem does not occur.
>
> This is strange and actually I never had any problems with the Apple 
> HID
> stuff, but I used it on a normal Intel machine.
>
> Regards
>
> Marcel
>
>
>

--Apple-Mail-1-128455809
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBfMBZuk55Di7iAnARAmizAJ9u5hdZNAmNo5fMfn7+4jKdA/VD6wCfc0rT
B7AaU4FvRjNVdADvXAfFhtg=
=4AZn
-----END PGP SIGNATURE-----

--Apple-Mail-1-128455809--
