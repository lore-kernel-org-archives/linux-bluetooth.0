Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test problem
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <405EBCDD.3090402@india.hp.com>
References: <405E6C9E.1030600@india.hp.com>
	 <1079937432.2663.78.camel@pegasus>  <405EBCDD.3090402@india.hp.com>
Content-Type: text/plain
Message-Id: <1079951177.2663.90.camel@pegasus>
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
Date: Mon, 22 Mar 2004 11:26:17 +0100

Hi Swarup,

> > may you wanna take a look at the Bluetooth specification and search for
> > result code 2 of the L2CAP connect response ;)
> > 
> > 	0x0002 Connection refused - PSM not supported.
> >   
> 
> Yes, I saw that earlier. But how do I get the supported PSM's?
> Are they available from the SDP records one gets from the output of
> "sdptool browse"?
> (are they the numbers beside L2CAP in the records?)

yes, they are the uint16 numbers besides the uuid16 protocol UUID for
L2CAP, but why do you want them? You asked about a mobile phone and most
of them are based on the higher layer RFCOMM. So far I haven't seen any
phone that support BNEP, HID or HCRP. And this means that in your case
only two PSM's are supported. PSM 1 for the SDP requests and PSM 3 for
the RFCOMM protocol.

> In case of l2test, which PSM (psm of which record) should it use?

The l2test program is for Linux-to-Linux testing and not really meant
for testing other devices. You should ask yourself what you are trying
to do.

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
