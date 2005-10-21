Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4359109D.9050502@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO USB isoc transfer
References: <de37400f0510210807s3df4b697sab237041cd30c6e1@mail.gmail.com>
In-Reply-To: <de37400f0510210807s3df4b697sab237041cd30c6e1@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 21 Oct 2005 17:00:29 +0100

Tomasz Urbanowicz wrote:
> Now I'm working on enabling SCO transfer which takes place over isochronous endpoints in
> the usb device. Now to the point. After establishing the SCO connection when I read from
> the device isoc endpoint I've noticed that the data that is returned sometimes starts
> with the SCO header and sometimes it doesn't.When it doesn't the first SCO
> Header appears somewhere later in the data.

This is a fundamental problem with SCO over USB.

One HCI SCO packet is broken into three USB packet. Only the first of
these packets has a header.

Unfortuantely, the USB isochronous stream is not reliable and packets
can get lost. This means that the header may not be where you expect
them.

For a single SCO link with 16 bit data, the Bluetooth spec recommends
that the data be packed into HCI packets containing 48 payload bytes
(24 samples). The three byte HCI header brings the total PDU size up to
51 bytes. This is then split into three 17 byte packets which are sent
on successive milliseconds.

The first packet contains the three byte header and 14 bytes of payload.
The last two contain 17 bytes of payload.

You will need generic resynchronisation code that detects that a header
was not received where it was expected and then reads individual USB
packets until it finds one that starts with a header.

If you wanted to be really robust, you'd look for a USB packet with a
header followed by two without as, in theory, the header sequence could
appear in the sample stream.

In practice, if you just take the next packet with a header then if you
did accidentally match in the packet stream, you'll probably find the
next header isn't where you expected (as it's unlikely that the three
bytes 48 bytes further along the data stream also match the header).
You can then try and resynchronise again and keep trying until you get
the right match (which should never take more than 3 attempts).

> But it's not always like that. Somtimes the result buffer will start with
> some garbage data, and the proper SCO header appears somewhere later in that
> buffer. For example :
>  **)
> 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22
> 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10
> 2C 00 30 22 10 22 10 22 10 22 10 22 10 22 10 22 10
>  Here first 34 bytes are not preceeded with the SCO Header. A properly
> structured packet starts at the 3rd line here with 2C 00 30.

34 bytes is 2 x 17 bytes which means you started reading from the second
packet of the three making up the full HCI packet.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
