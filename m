Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how well supported is hci_read_rssi and
	hci_read_link_quality?
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Huang <ashuang@gmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec0406222219c5d442b@mail.gmail.com>
References: <ef9938ec0406222219c5d442b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1087975911.4209.58.camel@pegasus>
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
Date: Wed, 23 Jun 2004 09:31:51 +0200

Hi Albert,

> Does anyone have a rough estimate, or even a list, of the devices that
> support hci_read_rssi and hci_read_link_quality?  Am I correct in
> assuming that some devices supoprt it and some don't?  For example, a
> program that reads rssi and link quality that works beautifully on an
> x86 with a d-link usb bluetooth dongle doesn't seem to work at all on
> an HP ipaq h5550.  On the ipaq, the link quality is always 0 and rssi
> is always 255.

the link quality command is vendor specific, so you can't rely on it. We
only know how CSR uses it. The RSSI must be announced in the features
bits.

> The attached patch changes cmd_lq in hcitool.c to print out an
> unsigned integer instead of a signed integer.

Does this make any difference? The link quality is only uint8.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
