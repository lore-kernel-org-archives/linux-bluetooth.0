Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <421B64F5.8090100@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] TPL (transmit power level)
References: <de33c8be0502160425215158ad@mail.gmail.com>
    <1109028291.7626.45.camel@pegasus>
    <de33c8be050221181635c1a751@mail.gmail.com>
In-Reply-To: <de33c8be050221181635c1a751@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Tue, 22 Feb 2005 16:59:33 +0000

Flávio wrote:
> One more question about this topic.
> In bluetooth core says that the range of the tpl (transmit power
> level) is between -30<= N<=20 and the step (resolution) is one
> unit,

Where does it say that the step is one unit? It might say that the
units for this value are dBm.

>       but when i execute the command hci_read_tpl (transmit power
> level) all the values that i receive are:
> 17 ; 14 ; 10 ; 6 ; 2 ; -2 ; -6 ; -9 and no more :(
> why?

This is completely as expected.

If you look right at the start of the Bluetooth spec in the radio
specification under transmitter characteristics, it says:

  The power steps shall form a monotonic sequence with a maximum
  step size of 8 dB amd a minimum step size of 2 dB.

The easiest way for a manufacturer to meet this specification is with
a preprogrammed set of levels.

A device isn't obliged to use the full range. The radio spec also says:

  Power control capability under +4 dBm is optional.

Your chip appears to go down to -9 dBm which exceeds the spec.

>      it´s something about Bluez or is the Firmware (of my dongle usb)
> that realy gives that values for tpl?

The firmware of the dongle reports the values.

Tour device is completely within spec.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
