Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F9F8062.90209@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Paul Ionescu <paul@acorp.ro>
Cc: ethereal-dev@ethereal.com,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth ethereal dissector
References: <1067379074.2419.24.camel@paul>
In-Reply-To: <1067379074.2419.24.camel@paul>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 29 Oct 2003 08:54:58 +0000

Paul Ionescu wrote:
> Hi,
> 
> I am planning to make an ethereal dissector for bluetooth HCI
> conversation for BlueZ Bluetooth stack.
> In order to see this data, we have to load it first in ethereal.
> I see two ways to do that:
> 
> 1. Make libpcap hci aware, and let it capture hci data in normal pcap
> file like tcpdump, then ethereal will be able to sniff live from hci0.
> 
> 2. Make ethereal read capture files made with hcidump -w.
> 
> The first one seems better, but the second is easier.
> What do you think ?
> 
> P.S. This message is posted on both ethereal and bluez development
> lists.
> 
The affix,"http://affix.sourceforge.net/", bluetooth stack for linux 
already has an interface to ethereal, so it might be worth using the 
same api as affix has with ethereal, thus sharing the amount of 
development work needed to be done.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
