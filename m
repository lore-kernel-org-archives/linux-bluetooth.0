Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand vs. rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028BBF@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A4028BBF@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1094997405.5695.6.camel@pegasus>
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
Date: Sun, 12 Sep 2004 15:56:45 +0200

Hi Richard,

> I have rfcomm working among a few small embedded devices for
> transferring small amounts of data - less than 100 bytes of data per
> second. I have a master and four slaves in a small piconet. 
> 
> Now I'm adding a higher bandwidth connection between my master and
> another device with pand. The master is an embedded xScale single
> board computer Linux 2.4.26 with the latest patches. The other device
> here is an iPAQ 5550 with built in bluetooth - running Familiar Linux.
> A single bnep connection is established OK and seems to work pretty
> well. If I establish a bnep connection, I can do all the usual TCP/IP
> stuff between the two - ping, telnet, ftp work just fine. But I'm
> wondering if the bnep connection interferes with the rfcomm's that are
> used in the piconet. Can I have multiple asynchronous processes using
> bnep and rfcomm without interfering with each other ? 
> 
> Here's what happens:
> - I start up my system and the four rfcomm's are bound and
> transferring data. I've had this running for hours with no problems.
> 
> - Then I start the pand and this establishes the bnep connection OK. I
> can ping, ftp, etc.
> 
> - After a few minutes, the bnep connection fails to transmit any more
> data.
> 
> Is this to be expected ? 

maybe there is a bug somewhere. Are you using my latest -mh patch? Have
you tried to include the small checksum fix from David?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
