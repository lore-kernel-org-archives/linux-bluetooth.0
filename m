Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <417149FD.6090700@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question about hci_usb endpoint selection...
References: <416D23A6.3010904@dark-reality.de>	 <1097752849.4640.37.camel@notepaq>  <416EF4B0.6070802@dark-reality.de> <1097928414.4911.27.camel@pegasus>
In-Reply-To: <1097928414.4911.27.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 16 Oct 2004 18:19:09 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

Marcel Holtmann wrote:
|>OK, I added hci_usb_notify(..) and it works as it should (get's the
|>notify when voice mode is changed).
|
| you also need some extra changes from my Bitkeeper repository, because I
| fixed some locking parts around the notify framework. The number of ACL
| and SCO links are now also counted separately. You need that for
| selecting the correct alternate setting.

Can you please describe how I can access your Bitkeeper repository? I
never used Bitkeeper before, and I'd rather not because of it's strange
license issues and stuff. Will this changes be in the MH-patches
sometime soon? Right now I'm trying to understand how things work, and I
think it'll be at least one more week until I can modprobe something
that might work, so I can wait a bit for a next release. Of course, if
you don't plan to release patches containing this changes soon, I'll use
Bitkeeper.

|>is there anything else to do? Must some buffers be dropped or free'd or
|>something? is it possible to simply re-set
|>isoc_iface, isoc_in_ep and isoc_out_ep?
|
|
| No simple reset. Change the alternate setting, but you maybe have to
| suspend the ISOC URBs first and then resume them. Check the USB API
| definition of it first.

OK, after digging for an USB API documentation I found:

***
~ int usb_set_interface(struct usb_device *dev, int interface, int
alternate);
***

The documentation/manpage says:

***
Note that in the Linux USB subsystem, bandwidth associated with an
endpoint in a given alternate setting is not reserved until an URB is
submitted that needs that bandwidth. Some other operating systems
allocate bandwidth early, when a configuration is chosen.

This call is synchronous, and may not be used in an interrupt context.
Also, drivers must not change altsettings while urbs are scheduled for
endpoints in that interface; all such urbs must first be completed
(perhaps forced by unlinking).
***

Questions I'm unable to answer myself right now:

1. are we in an interrupt context? (don't think so)
2. how can we make sure that there are no pending urbs? maybe we have to
change the setting asynchronus in the transmit function or something? Or
should we unlink pending SCO URBs?
3. can we safely assume that the endpoint ID's that are stored in
isoc_in_ep and isoc_out_ep are always the same for different alternate
settings?
4. I think we *can* assume that alternate setting 1 matches for 0x0?40
voice modes, while alternate setting 2 matches for 0x0?60 voice modes,
as you (Marcel) wrote that it's defined in the BT-USB-HCI specs.
5. Why do I need the SCO link count? Shouldn't it be sufficient to call

usb_set_interface(hcidev->udev, hcidev->isoc_iface,NEW_ALTERNATE_SETTING);

after making sure that we solved the URB release problem?

thanks for helping me out so much :)
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBcUn9QWC6DTWkDAoRAipKAJ4mfV/4SjYOtf3sDmCk+Y+X/gAPmQCgr8PS
qd4BK7v0u2ZBiULDQ24PB6k=
=0vo5
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
