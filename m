Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <416EF4B0.6070802@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question about hci_usb endpoint selection...
References: <416D23A6.3010904@dark-reality.de> <1097752849.4640.37.camel@notepaq>
In-Reply-To: <1097752849.4640.37.camel@notepaq>
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
Date: Thu, 14 Oct 2004 23:50:40 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

| look at the hci_usb driver and add the notify() callback function for
| it. This function gets called when you change the voice setting or a new
| connection is added or removed. I changed the connection hash to count
| the ACL and SCO links separatly and disabled the tasklet when calling
| this function so that the core stops processing TX packets and enable it
| after the driver finished anything it has to do.

Hi there,

OK, I added hci_usb_notify(..) and it works as it should (get's the
notify when voice mode is changed).

Now for the "real stuff"... :)

I think to handle the voice mode change correctly, I have to duplicate
the code from about line 874..922 that locates the "proper" alternate
setting; before this can happen, the notify function must close

((husb *)hdev->driver_data)->isoc_iface with
usb_driver_release_interface(...)

is there anything else to do? Must some buffers be dropped or free'd or
something? is it possible to simply re-set
isoc_iface, isoc_in_ep and isoc_out_ep?

Or is it in fact not neccesary to disconnect isoc_iface and only change
the values of isoc_in_ep and isoc_out_ep?

I don't know much about the usb internals, so I ask the list again.

Thanks very much for bringing this topic forward :))

cu,
~  Lars

PS: one last question, I'm using kernel 2.6.8.1 now and hci_usb.c uses
CONFIG_BT_HCIUSB_DEBUG to enable/disable debugging; my kernel config
says this option does not exists, so, how to enable debugging properly?
Or is just the option accidently missing from kernel config in this release?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBbvSwQWC6DTWkDAoRArROAJ9ita8X+pxnxEDeH6f2iU4JUbMsDACfbao5
F0MQVzgEB8guoBDKw/McCbU=
=iJew
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
