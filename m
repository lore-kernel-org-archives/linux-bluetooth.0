Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bd_addr question
From: Marcel Holtmann <marcel@holtmann.org>
To: Jessica Huang <jessieh@MIT.EDU>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.2.1.1.2.20040309190444.02e6e250@po14.mit.edu>
References: <5.2.1.1.2.20040309150546.02e414a0@po14.mit.edu>
	 <5.2.1.1.2.20040309150546.02e414a0@po14.mit.edu>
	 <5.2.1.1.2.20040309190444.02e6e250@po14.mit.edu>
Content-Type: text/plain
Message-Id: <1078878227.30990.17.camel@pegasus>
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
Date: Wed, 10 Mar 2004 01:23:47 +0100

Hi Jessica,

> Sorry, I worded it poorly.  I'm a graduate student researching privacy 
> issues related to Bluetooth, which I'm pretty new to.  I'm trying to work a 
> way around the fact that each device address is unique therefore 
> trackable.  I was wondering if I were to buy a Bluetooth transmitter and 
> build my own device, can I change the bd_addr that is stored by the chip's 
> manufacturer?  Which layer/module is in charge of reading that unique 
> bd_addr?  I hope that makes more sense!

the Bluetooth SIG is working on something that is called Anonymity Mode
and this should be present in Bluetooth 1.2, but it got removed from the
final specification. So actually devices are trackable. And there is no
default way of changing the BD_ADDR, but some manufacturers provides
vendor specific HCI commands to change the Bluetooth address.

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
