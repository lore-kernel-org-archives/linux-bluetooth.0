Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
From: Marcel Holtmann <marcel@holtmann.org>
To: John McCorquodale <mcq@cacr.caltech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040307214224.GB18481@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu>
Content-Type: text/plain
Message-Id: <1078704901.15279.6.camel@pegasus>
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
Date: Mon, 08 Mar 2004 01:15:01 +0100

Hi John,

> I'm trying to get my socket CF G card to work in my pcmcia slot.  Just trying
> to get to the point where I can do an hci scan.  From what I've been able to
> glean from the list and howtos, this is my approach:
> 
>   1. pcmcia-cs loads G card as serial_cs (minicom on ttyS0 shows a packet
>      coming in every half-second or so, but I don't know what baud rate
>      I should be using, nor what HCI packets look like, so I can only assume
>      that it's correct)
> 
>   2. All bluez support built in to kernel (2.6.3-mm2, 2.4.25, 2.4.20 all
>      tried with same results)
> 
>   3. hciattach ttyS0 csr 230400
>      Responds: "Initialization timed out."
> 
> Anybody care to kick me a step further in the right direction on this sunny
> southern California afternoon?

you should use "hciattach ttyS0 bcsp 230400", because the Socket card
uses the BCSP transport protocol.

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
