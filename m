Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth ipaq familiar
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Albert <matthias@ma-c.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1095082582.2191.35.camel@ringo.aicas.burg>
References: <1095082582.2191.35.camel@ringo.aicas.burg>
Content-Type: text/plain
Message-Id: <1095154677.5695.134.camel@pegasus>
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
Date: Tue, 14 Sep 2004 11:37:57 +0200

Hi Matthias,

> I have a iPAQ 5550 running with Familiar unstable 0.7.2 and Opie 1.1.4.
> I can establish a connection over pand between a pc and the ipaq.
> 
> After that I have a device called bnep0 which I can configure with
> ifconfig bnep0 and so on.
> 
> Now I would like to have a serial bluetooth connection between the pc
> and the ipaq.
> How can I do this?

use dund, play with the rfcomm utility or write your own client/server
application.

> Is it possible with a serial bluetooth connection, that I can go outside
> the frequency with my ipaq and go back and the connection is there?

You have to write this stuff by yourself.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
