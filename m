Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
From: Marcel Holtmann <marcel@holtmann.org>
To: John McCorquodale <mcq@cacr.caltech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040308002100.GA19049@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu>
	 <1078704901.15279.6.camel@pegasus>
	 <20040308002100.GA19049@viz.cacr.caltech.edu>
Content-Type: text/plain
Message-Id: <1078705579.15279.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Mar 2004 01:26:19 +0100

Hi John,

> The other day you said:
> 
> Marcel> The Socket 2.5 generation (also know as revision G) is a CSR based
> Marcel> serial Bluetooth card. Look at the archives for more details.

a CSR chip can also use BCSP ;)

> And the list seems to indicate that the F card is BCSP and the G card is CSR.
> That said, using bcsp yields:
> 
>   $ hciattach ttyS0 bcsp 230400
>   BCSP initialization timed out

May this is the problem with some serial cards and 2.6. Try 2.4 instead.

> Am I mistaken about the F/G distinction?  Am I correct in using the normal
> serial_cs driver in the PCMCIA cardmgr?  Is there something I can run directly
> at the serial port that will give me a more verbose dialog than "initialization
> timed out", which might indicate some level of partial success?  Could it
> be that there's a new G card series out there -- these are brand spankin' new
> cards?

The revision E and F are Nokia based cards and they need the dtl1_cs
driver. The revision G contains a CSR chip with BCSP.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
