Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F17E4EF.5060401@superbug.demon.co.uk>
References: <E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk>
Message-Id: <1058533496.25379.237.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 18 Jul 2003 15:04:50 +0200
Content-Type: text/plain

Hi James,

> The playback problem is a scheduling problem.
> The "hci_usb_tx_complete" function uses the scheduler to kick off the 
> next transmission, but the scheduler is too slow, and the correct method 
> to use is getting the "hci_usb_tx_complete" function to retrieve the 
> next packet to send from a ring buffer, and send it immeadiately during 
> the "hci_usb_tx_complete" function. This is how the current usbaudio.c 
> does it, so it proves that this method will work.
> So, I will need to implement a ring buffer.
> At the same time I want to implement sound output via alsa, so I want to 
> make sure we have a good api to achieve that.
> alsa requires certain information from the sound card (ring buffer 
> position etc.), and I will have to make sure that the information alsa 
> needs in available, by maybe adding new api calls through the sco layer 
> to the usb-hci.c layer. I think it would be a good idea to completely 
> separate the isoc(sound) urb path from the int/bulk/control urb path.
> We also have the added complication that the alsa ring buffer is 
> composed of just sound samples, but the sco layer converts that to 
> packets with a header so the hci-usb.c layer has to deal with packets 
> instead of samples.
> For 8 bit mono sound, SCO creates packets with 3 header bytes, and 24 
> sound samples. hci-usb.c then has to take each 27 byte packet and cut it 
> down into 3 slices each 9 bytes in length. All packet sizes and slice 
> sizes vary depending on 8/16 bits samples, and mono/stereo etc.

the seperate handling of ISOC is a good idea. Max told me that ISOC
URB's consumes USB bandwith and because of the fact that they are not
needed all the time, we have to start and stop them dynamicly, if a SCO
link is established or killed.

My current idea of handling this is that the hci_usb driver checks for
SCO links in connection complete and disconnect complete events. Another
idea is to add another HCI driver method (for example hdev->notify), so
that the HCI core can notify the driver of special events or errors.

> So, there is going to be quite a lot of manipulation of the sound 
> samples as they pass from alsa to the bluetooth device.
> The questions I am still trying to decide are: -
> 1) When should the conversion from alsa ring buffer to packets take 
> place. So far the only workable solution I have come up with is that the
> "hci_usb_tx_complete" makes a callback all the way to the sco layer, and 
> the sco layer grabs 24 bytes form the alsa ring buffer, adds it's header 
> and returns from the callback.
> 2) interface to alsa. I think this should happen just above the SCO 
> layer, but also ensuring that the SCO layer has enought api links with 
> the hci-usb.c layer to be able to service all the alsa-driver api 
> requirements.
> 3) Once that all works, modify the other low level hardware drivers to 
> work with it. e.g. bluecard_cs.c etc.

The native integration of Bluetooth audio within Linux is one of the
most wanted things. But we can't use ALSA for the 2.4 kernel, because it
is not a part of the kernel. For the 2.6 this is no problem, but I also
want to have support for OSS, because there will some people (like me)
which still uses OSS.

The integration of audio is not part of the Bluetooth drivers, because
every Bluetooth HCI driver is only a transport driver which have to
transport the HCI command, event, ACL and SCO data between the hardware
and the HCI core layer. The SCO data would send from the HCI core
through the hdev->send() callback and the driver can send the SCO data
it gets from the hardware back with hci_recv_frame(). This means that
all needed modifications for ALSA and OSS integration have to done in
the HCI core or the SCO layer. And all other HCI drivers will still work
with SCO like they do now.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
