Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F9F8062.90209@superbug.demon.co.uk>
References: <1067379074.2419.24.camel@paul> <3F9F8062.90209@superbug.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D78AFB12-0A4C-11D8-B1BA-000A958097E4@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
From: Guy Harris <guy@alum.mit.edu>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
To: James Courtier-Dutton <James@superbug.demon.co.uk>
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
Date: Wed, 29 Oct 2003 12:16:55 -0800


On Oct 29, 2003, at 12:54 AM, James Courtier-Dutton wrote:

> The affix,"http://affix.sourceforge.net/", bluetooth stack for linux

(Did they know what they were doing when they added the PF_AFFIX 
protocol type for HCI SCO sockets, or was it a pure accident that 
BTPROTO_HCISCO ends with "CISCO"? :-))

>  already has an interface to ethereal,

Their support is a bit, err, umm, odd.

The Ethereal patch contains:

	1) a bunch of dissectors, which don't actually do any *capturing* - it 
appears that the HCI dissector registers itself with Ethertype 0xb123, 
so it appears to assume that the packets in the capture look like 
Ethernet packets, with the Bluetooth stuff inside Ethereal payload;

	2) a "capture-affix-pcap.c", which appears to be the "load WinPcap at 
run time" code, modified to load a UNIX-style "libpcap.so" at run time.

2) seems not to be particularly useful - if you've dynamically-linked 
Ethereal, it should *already* load "libpcap.so" at start-up time (at 
least if ".so" is your OS's dynamically-linked library suffix).  It 
also doesn't appear to include any code to *call* the routine to load 
"libpcap.so" at run time.

I assume that the affix people have a modified version of libpcap that 
uses some mechanism (Bluetooth sockets?) to capture Bluetooth packets; 
however, it doesn't appear to be in the Ethereal patch for affix, nor 
can I find it in either the affix-kernel-2.0.2 or the affix-2.0.2 
stable or testing tarballs.

So I don't see any evidence of any support for Bluetooth capture with 
Ethereal, unless they've cleverly hidden their modified libpcap 
somewhere.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
