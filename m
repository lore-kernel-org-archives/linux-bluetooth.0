Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question about hci_usb endpoint selection...
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <416EF4B0.6070802@dark-reality.de>
References: <416D23A6.3010904@dark-reality.de>
	 <1097752849.4640.37.camel@notepaq>  <416EF4B0.6070802@dark-reality.de>
Content-Type: text/plain
Message-Id: <1097928414.4911.27.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 16 Oct 2004 14:06:54 +0200

Hi Lars,

> OK, I added hci_usb_notify(..) and it works as it should (get's the
> notify when voice mode is changed).

you also need some extra changes from my Bitkeeper repository, because I
fixed some locking parts around the notify framework. The number of ACL
and SCO links are now also counted separately. You need that for
selecting the correct alternate setting.

> Now for the "real stuff"... :)
> 
> I think to handle the voice mode change correctly, I have to duplicate
> the code from about line 874..922 that locates the "proper" alternate
> setting; before this can happen, the notify function must close

No, because the correct alternate setting is described in the Bluetooth
HCI USB transport specification.

> ((husb *)hdev->driver_data)->isoc_iface with
> usb_driver_release_interface(...)

Don't try to release and claim it again. You are not in the probe()
function.

> is there anything else to do? Must some buffers be dropped or free'd or
> something? is it possible to simply re-set
> isoc_iface, isoc_in_ep and isoc_out_ep?

No simple reset. Change the alternate setting, but you maybe have to
suspend the ISOC URBs first and then resume them. Check the USB API
definition of it first.

> Or is it in fact not neccesary to disconnect isoc_iface and only change
> the values of isoc_in_ep and isoc_out_ep?

Maybe you should look at the /proc/bus/usb/devices first, because the
endpoint identifiers on the second interface are always the same. You
must tell the USB core to switch the alternate setting.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
