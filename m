Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030721162046.093d2eb8@unixmail.qualcomm.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
In-Reply-To: <3F17E4EF.5060401@superbug.demon.co.uk>
References: <3F1752C5.5020701@dsto.defence.gov.au>
	<E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
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
Date: Mon, 21 Jul 2003 16:49:51 -0700
Content-Type: text/plain; CHARSET=us-ascii

At 05:15 AM 7/18/2003, James Courtier-Dutton wrote:
>There are a number of problems with the current usb-hci.c driver.
>I have a dirty fix for sound recording, but playback will need a lot of work.
>If you want recording to work, just put in a for loop round the
>"static int hci_usb_isoc_rx_submit(struct hci_usb *husb)" function to make it execute twice. See "e.g." below.
>
>It is a very dirty fix, because I don't think that everything gets freed when not in use, but at least it records sound at the correct speed.
Actually it's not a dirty fix. I thought that ISOC queuing (ie more than one transfer at a time) is not 
support by USB HCD driver. If it supported then the fix is good. 

>The playback problem is a scheduling problem.
>The "hci_usb_tx_complete" function uses the scheduler to kick off the next transmission, but the scheduler is too slow, and the correct method to use is getting the "hci_usb_tx_complete" function to retrieve the next packet to send from a ring buffer, and send it immeadiately during the "hci_usb_tx_complete" function. 
Which scheduler are you're talking about ?
Take a look at hci_usb_tx_proccess() function, which is called immediately after transfer completes,
it does this:

                /* Process SCO queue */
                q = __transmit_q(husb, HCI_SCODATA_PKT);
                if (!atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) &&
                                (skb = skb_dequeue(q))) {
                        if (hci_usb_send_isoc(husb, skb) < 0)
                                skb_queue_head(q, skb);
                }

So basically HCI USB driver has SCO TX queue and the next packet, if available, is retrived directly 
from this queue. Scheduler is not involved here. Again it only does one transfer at a time because
I thought (and still think :)) that multiple ISOC transfers are not supported.

>This is how the current usbaudio.c does it, so it proves that this method will work.
>So, I will need to implement a ring buffer.
>At the same time I want to implement sound output via alsa, so I want to make sure we have a good api to achieve that.
>alsa requires certain information from the sound card (ring buffer position etc.), and I will have to make sure that the information alsa needs in available, by maybe adding new api calls through the sco layer to the usb-hci.c layer. 
Those calls should be made into HCI core not HCI USB driver. Think about PCI and PCMCIA and other Bluetooth 
devices. We have to make audio support generic.

>I think it would be a good idea to completely separate the isoc(sound) urb path from the int/bulk/control urb path.
I completely disagree. Most of the URB processing is very similar. First version of the driver did have
separate bulk and isoc paths, but the code was pretty much the same that's why it's been combined.

>We also have the added complication that the alsa ring buffer is composed of just sound samples, but the sco layer converts that to packets with a header so the hci-usb.c layer has to deal with packets instead of samples.
>For 8 bit mono sound, SCO creates packets with 3 header bytes, and 24 sound samples. hci-usb.c then has to take each 27 byte packet and cut it down into 3 slices each 9 bytes in length. All packet sizes and slice sizes vary depending on 8/16 bits samples, and mono/stereo etc.
>
>So, there is going to be quite a lot of manipulation of the sound samples as they pass from alsa to the bluetooth device.
>The questions I am still trying to decide are: -
>1) When should the conversion from alsa ring buffer to packets take place. So far the only workable solution I have come up with is that the
>"hci_usb_tx_complete" makes a callback all the way to the sco layer, and the sco layer grabs 24 bytes form the alsa ring buffer, adds it's header and returns from the callback.
Why can't we just pass those samples to the HCI USB driver as soon as they become available ?
Driver will put queue them into tx queue and use that queue when transfer completes.  

>2) interface to alsa. I think this should happen just above the SCO layer, but also ensuring that the SCO layer 
>has enought api links with the hci-usb.c layer to be able to service all the alsa-driver api requirements.
By SCO layer you actually mean HCI core. Current SCO layer that we have is a simple raw socket interface 
nothing else. So ALSA Bluetooth sound cart driver will completely current SCO layer.

>3) Once that all works, modify the other low level hardware drivers to work with it. e.g. bluecard_cs.c etc.
That's why we have to go though HCI core from the beginning. If we do it right all other drivers will just
work.

>The final result will be: -
>1) a small tool that will link a particular paired bluetooth device to a particular PCM device for alsa to work with. This tool will basically just take destination BTADDR and channel number to use, because alsa will have no knowledge of that sort of info. It will add a new sound card instance for each bluetooth device.
>2) alsa will just think that the bluetooth headset is a normal soundcard.
>3) This would make integration with current audio applications simple, because alsa supports the alsa-api as well as emulate the oss-api, so current audio applications would need no changes.
>4) We could even implement headset "in the vicinity" detection, so that when the headset transitioned from out of range to in range, your computer could say hello!
That's exactly what I had in mind. I was even going to start looking into ALSA architecture.

Max



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
