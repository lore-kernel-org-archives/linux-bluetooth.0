Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Bluetooth security in bluez ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Anssi Saari <as@sci.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040402111506.GA15425@sci.fi>
References: <20040328220800.36896.qmail@web60302.mail.yahoo.com>
	 <200403290028.48289.cijoml@volny.cz> <1080514616.2281.178.camel@pegasus>
	 <20040401102919.GA6987@sci.fi> <1080816007.3059.18.camel@pegasus>
	 <20040402111506.GA15425@sci.fi>
Content-Type: text/plain
Message-Id: <1080905701.2836.5.camel@pegasus>
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
Date: Fri, 02 Apr 2004 13:35:02 +0200

Hi Anssi,

> > > How can you tell whether a connection is encrypted or not in Bluez if
> > > security mode is 2?
> > 
> > check with "hcitool con"
> > 
> > Connections:
> >         < ACL 00:0A:xx:xx:xx:xx handle 43 state 1 lm MASTER ENCRYPT 
> 
> Great, thanks. Are RFCOMM connections for dialup usually encrypted? I
> have Bray & Sturman's BT book, but it only mentions in passing that
> "RFCOMM will enforce security for dialup networking" where it talks
> about the security manager.

the RFCOMM connection itself can't be encrypted, but the underlaying ACL
link can. The link is shared across every connection between two devices
and this means if you enforce once the encryption it is there for every
other RFCOMM, L2CAP etc. connection at that time. Some books don't make
this point very clear and talking about a security manager is another
topic, because the Bluetooth security mechanism are part of the lower
(hardware and firmware) layers.

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
