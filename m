Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
From: Marcel Holtmann <marcel@holtmann.org>
To: John McCorquodale <mcq@cacr.caltech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040308004811.GA19145@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu>
	 <1078704901.15279.6.camel@pegasus>
	 <20040308002100.GA19049@viz.cacr.caltech.edu>
	 <1078705579.15279.18.camel@pegasus>
	 <20040308004811.GA19145@viz.cacr.caltech.edu>
Content-Type: text/plain
Message-Id: <1078707603.15279.27.camel@pegasus>
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
Date: Mon, 08 Mar 2004 02:00:03 +0100

Hi John,

> Progress.  2.4.25 produces different behavior:
> 
> First time loading it says:
> bcsp_recv: Out-of-order packet arrived, expected 1 got 0

this is ok. You can ignore this message.

> Second time loading it says:
> Unknown device type or id

This looks like that your command parameters are wrong.

> In 2.4.20, it always says "Unknown device type or id".

You need to have BCSP enabled for the hci_uart module.

>   1) Is there maybe a new G card device id out there, or should I be using
>      some other bluez than that which ships with 2.4.25?

The 2.4.25 should be fine.

>   2) Is there a patch for the 2.6 serial problem?

Not that I know of. Some cards are working and some are not.

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
