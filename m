Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Ionescu <paul@acorp.ro>
Cc: ethereal-dev@ethereal.com,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1067379074.2419.24.camel@paul>
References: <1067379074.2419.24.camel@paul>
Content-Type: text/plain
Message-Id: <1067425631.24043.224.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 29 Oct 2003 12:07:05 +0100

Hi Paul,

> I am planning to make an ethereal dissector for bluetooth HCI
> conversation for BlueZ Bluetooth stack.
> In order to see this data, we have to load it first in ethereal.
> I see two ways to do that:
> 
> 1. Make libpcap hci aware, and let it capture hci data in normal pcap
> file like tcpdump, then ethereal will be able to sniff live from hci0.

from my point of view this is not a good idea, because libpcap is for
Ethernet traffic. But ask the libpcap guys what they think about it.

> 2. Make ethereal read capture files made with hcidump -w.

This should be the way to go, because live capturing is not always what
you want. However ethereal can read from stdin and we can modifiy
hcidump to output the raw packages to stdout.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
