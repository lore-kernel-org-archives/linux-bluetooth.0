Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A0F6F4.6070707@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ and the ALSA support
References: <1100995285.7250.17.camel@pegasus>	 <41A027BD.5020401@xmission.com> <1101057242.7250.34.camel@pegasus>	 <41A0D34C.8070400@dark-reality.de> <1101061573.7250.68.camel@pegasus>
In-Reply-To: <1101061573.7250.68.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 Nov 2004 21:13:40 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|
|>| Do anyone mind if we start using the kernel coding style? It will make
|>| later integration into the kernel or BlueZ so much easier.
|>
|>I definitly won't mind, we'll have to migrate anyway, and sooner is
|>better than later.
|
|
| this is correct, but I won't integrate the current idea of the btsco
| kernel module. In the end it must work without the SCO socket in between
| for sending and receiving the SCO data packets from the HCI. And I like
| to have the eSCO support also. However even I don't have the right test
| hardware for that.

Yes, you already mentioned that before. Depending on the time I'll have
to implement it, it won't be much of a problem to do a complete redesign
of the stuff. As soon as I understand what we'll need... ;)


|>My problem how to change the usb_hci endpoint without killing the n.y.t.
|>urbs is still pending, did you have any new ideas on this?
|
|
| My problem is that I haven't written all of the hci_usb driver code and
| some parts are still so messy that I think a complete rewrite is the
| best that we can do.

I see, did not know that.

| But what I will do is to add a module parameter for
| choosing the alternate setting that can be changed at runtime. To bring
| up a device with a new alternate setting you only have to unplug and
| then plug it in again. This is not the solution we should have, but it
| will help us with testing the SCO stuff without recompiling the kernel
| every time.

Yes, that would be a first step.

I hope I can have a look at the way how usb_hci works, so that I can
understand when an asynchronus/delayed change of the endpoint selection
could happen - or how we could get rid of not-send urbs. *sigh* just
need more time...

don't you think it should be possible to
a) block the submit of new urbs when a change notify has arrived
b) queue until the queue is empty
c) change the endpoint setting and release the block

I don't know to which bad runs or locks this could lead...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBoPbzQWC6DTWkDAoRAhDvAJ9OiAlvi1fjivMFchnmb4ehBe53hwCfey+1
UEARQw9ddXYRhewZvKFf014=
=kTD6
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
