Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI Forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42005A510007CC0F@resmta05.ono.com> (added by postmaster@resmta05.ono.com)
References: <42005A510007CC0F@resmta05.ono.com>
	 (added by postmaster@resmta05.ono.com)
Content-Type: text/plain
Message-Id: <1108046877.15974.57.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 10 Feb 2005 15:47:57 +0100

Hi,

> As you remember I was developing a gateway for tunneling the hci traffic
> over TCP and be able to transfer files and play bluetooth games at long
> distances.
> I wrote a simple and very rudimentary C++ test program but didn't work. I
> think the problem is the destination bluetooth address, would I need to
> parse
> the hci frames to set the bt address to its correct value?, I don't know
> how to do this, I am really lost.
> I tested the program with another friend running the same program with two
> nokia n-gage.
> 
> If you can help me here is the source code, please feel free to modify
> whatever
> you want and tell me how can I solve this problem or give me a new way of
> doing this.
> (I marked up the important part of the main loop so you can see the main
> idea witouth reading the full source), at the end is the program and hcidump
> output.
> 
> If you want the full source (all files and makefile) tell me.

using C++ is actually too much for such a project, because OO is useless
in this case and personally I don't like C++ and so I won't comment on
your code.

If you wanna do HCI forwarding then you must first use the HCI device in
raw mode and even then I don't think that this going to work. You must
map a lot of commands to events and vice versa. For example a connect
request from on side must result in a create connection on the other
side and then you must do the HCI flow control right.

And yes, you must do a BD_ADDR and also connection handle translation
for every command/event exchange. I am not sure if this will ever work,
but even if, it is a lot of work and you need a deep understanding of
the HCI.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
