Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F17E4EF.5060401@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez Dev <bluez-devel@lists.sourceforge.net>
References: <E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
In-Reply-To: <3F1752C5.5020701@dsto.defence.gov.au>
Subject: [Bluez-devel] Re: Bluetooth headset with Bluetooth usb dongle
	status.
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
Date: Fri, 18 Jul 2003 13:15:43 +0100
Content-Type: text/plain; CHARSET=us-ascii; FORMAT=flowed

I would like to discuss possible changes in the sco to hci-usb layer 
api. I would like people to agree the changes before I go ahead and code 
them. I don't have exact function names etc. yet, but just a general 
idea of what one needs to do in order to implement an alsa interface to 
bluez.

There are a number of problems with the current usb-hci.c driver.
I have a dirty fix for sound recording, but playback will need a lot of 
work.
If you want recording to work, just put in a for loop round the
"static int hci_usb_isoc_rx_submit(struct hci_usb *husb)" function to 
make it execute twice. See "e.g." below.

It is a very dirty fix, because I don't think that everything gets freed 
when not in use, but at least it records sound at the correct speed.

The playback problem is a scheduling problem.
The "hci_usb_tx_complete" function uses the scheduler to kick off the 
next transmission, but the scheduler is too slow, and the correct method 
to use is getting the "hci_usb_tx_complete" function to retrieve the 
next packet to send from a ring buffer, and send it immeadiately during 
the "hci_usb_tx_complete" function. This is how the current usbaudio.c 
does it, so it proves that this method will work.
So, I will need to implement a ring buffer.
At the same time I want to implement sound output via alsa, so I want to 
make sure we have a good api to achieve that.
alsa requires certain information from the sound card (ring buffer 
position etc.), and I will have to make sure that the information alsa 
needs in available, by maybe adding new api calls through the sco layer 
to the usb-hci.c layer. I think it would be a good idea to completely 
separate the isoc(sound) urb path from the int/bulk/control urb path.
We also have the added complication that the alsa ring buffer is 
composed of just sound samples, but the sco layer converts that to 
packets with a header so the hci-usb.c layer has to deal with packets 
instead of samples.
For 8 bit mono sound, SCO creates packets with 3 header bytes, and 24 
sound samples. hci-usb.c then has to take each 27 byte packet and cut it 
down into 3 slices each 9 bytes in length. All packet sizes and slice 
sizes vary depending on 8/16 bits samples, and mono/stereo etc.

So, there is going to be quite a lot of manipulation of the sound 
samples as they pass from alsa to the bluetooth device.
The questions I am still trying to decide are: -
1) When should the conversion from alsa ring buffer to packets take 
place. So far the only workable solution I have come up with is that the
"hci_usb_tx_complete" makes a callback all the way to the sco layer, and 
the sco layer grabs 24 bytes form the alsa ring buffer, adds it's header 
and returns from the callback.
2) interface to alsa. I think this should happen just above the SCO 
layer, but also ensuring that the SCO layer has enought api links with 
the hci-usb.c layer to be able to service all the alsa-driver api 
requirements.
3) Once that all works, modify the other low level hardware drivers to 
work with it. e.g. bluecard_cs.c etc.

The final result will be: -
1) a small tool that will link a particular paired bluetooth device to a 
particular PCM device for alsa to work with. This tool will basically 
just take destination BTADDR and channel number to use, because alsa 
will have no knowledge of that sort of info. It will add a new sound 
card instance for each bluetooth device.
2) alsa will just think that the bluetooth headset is a normal soundcard.
3) This would make integration with current audio applications simple, 
because alsa supports the alsa-api as well as emulate the oss-api, so 
current audio applications would need no changes.
4) We could even implement headset "in the vicinity" detection, so that 
when the headset transitioned from out of range to in range, your 
computer could say hello!

Cheers
James

e.g.
static int hci_usb_isoc_rx_submit(struct hci_usb *husb)
{
         struct _urb *_urb;
         struct urb *urb;
         int err, mtu, size;
         void *buf;
         int n;
         for(n=0;n<2;n++) {
         mtu  = husb->isoc_in_ep->wMaxPacketSize;
         BT_INFO("isoc_rx_submit: mtu=%d", mtu);
         size = mtu * HCI_MAX_ISOC_FRAMES;

         buf = kmalloc(size, GFP_ATOMIC);
         if (!buf)
                 return -ENOMEM;

         _urb = _urb_alloc(HCI_MAX_ISOC_FRAMES, GFP_ATOMIC);
         if (!_urb) {
                 kfree(buf);
                 return -ENOMEM;
         }
         _urb->type = HCI_SCODATA_PKT;
         _urb_queue_tail(__pending_q(husb, _urb->type), _urb);

         urb = &_urb->urb;

         urb->context  = husb;
         urb->dev      = husb->udev;
         urb->pipe     = usb_rcvisocpipe(husb->udev, 
husb->isoc_in_ep->bEndpointAddress);
         urb->complete = hci_usb_rx_sync_complete;

         urb->transfer_buffer_length = size;
         urb->transfer_buffer = buf;
         urb->transfer_flags  = USB_ISO_ASAP;

         __fill_isoc_desc(urb, size, mtu);
         BT_DBG("%s urb %p", husb->hdev.name, urb);

         err = usb_submit_urb(urb);
         if (err) {
                 BT_ERR("%s isoc rx submit failed urb %p err %d",
                                 husb->hdev.name, urb, err);
                 _urb_unlink(_urb);
                 _urb_free(_urb);
                 kfree(buf);
         }
         } /* End for loop */
         return err;
}
#endif



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
