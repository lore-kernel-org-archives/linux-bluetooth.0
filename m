Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] First HCI command sent to a device
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: steven.singer@csr.com,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040305131833.3bf6803f.charles@bueche.ch>
References: <1078411850.5347.43.camel@pegasus> <404749F3.9090006@csr.com>
	 <1078415736.5347.62.camel@pegasus>
	 <20040305131833.3bf6803f.charles@bueche.ch>
Content-Type: text/plain
Message-Id: <1078489692.2762.67.camel@pegasus>
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
Date: Fri, 05 Mar 2004 13:28:12 +0100

Hi Charles,

> I haven't looked at the code so my idea will probably be unusable, but
> how about maintaining a list of which dongles don't like the reset and
> send it only to the other ones ?
> 
> Or reversing the test, only sending a reset to the dongles that need
> it.
> 
> Of course, it implies that you can identify the device *before* deciding
> on your action.
> 
> AFAIK, there is a similar "black-list" of controllers in the IDE layer
> of Linux to decide on the supported features..

I like to identify the dongles that don't like the HCI_Reset, but this
is impossible for UART based adapters and even on the USB side this is
not very trivial. Actually I chose to introduce a reset quirk for the
i-Tec/Broadcom dongle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
