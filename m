Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <40A9E6CB.4010505@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
Cc: linux-usb-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco do?
To: Lars Grunewaldt <lgw@dark-reality.de>
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
Date: Tue, 18 May 2004 11:53:01 +0100

On 18 May 2004, at 11:34, Lars Grunewaldt wrote:

> there's a kernel patch in snd-bt-sco, and it would  be great if someone
> could explain what it does:
>
> *****
> - --- linux-2.6.4-orig/drivers/bluetooth/hci_usb.c	2004-03-11
> 02:55:44.000000000 +0000
> +++ linux-2.6.4/drivers/bluetooth/hci_usb.c	2004-03-13
> 23:52:27.000000000 +0000
> @@ -851,7 +851,12 @@
>
> ~ #ifdef CONFIG_BT_HCIUSB_SCO
> ~ 				case USB_ENDPOINT_XFER_ISOC:
> - -					if (ep->desc.wMaxPacketSize < size || a > 2)
> +					/* Use only the 9 byte
> +					  "One voice channel with 8 bit encoding"
> +					  endpoint until there is support for changing
> +					  the endpoint dynamically. See
> +					   Bluetooth 1.1 Part H:2, section 2.1 */
> +					if (ep->desc.wMaxPacketSize != 9)
> ~ 						break;
> ~ 					size = ep->desc.wMaxPacketSize;
> ****


There are different voice encodings over the isochronous USB channel 
that is used for the SCO connection. Which encoding is used is selected 
by running 'hciconfig hci0 voice <somenumber>', where <somenumber> is, 
for example, 0x0040 for one 8 bit 8000Hz stream and 0x0060 for one 16 
bit 8000Hz stream.

Depending on how many SCO channels are open and what format is used, 
different isoc USB frames are used by the bluetooth device. The 
possibilities are enumerated in the documentation that is referenced in 
that comment.

What it boils down to is that for one 8000Hz 8 bit channel, the USB 
packets are 9 bytes each. That check ensures that the appropriate 
endpoint is selected. Otherwise, the wrong endpoint probably gets 
chosen and the audio doesn't work at all or it sounds very bad.

The isoc streams ideally would be dynamically selected as required, 
depending on the type and number of SCO connections. Since there wasn't 
infrastructure in place when I wrote that patch, I hard-coded that 
choice to coincide with that required by the alsa driver.

Hope that sheds some light on the matter!



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
