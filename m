Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405062353.34156.cijoml@volny.cz>
References: <1083857533.16650.25.camel@saag>
	 <200405062127.11184.cijoml@volny.cz> <1083877306.4420.72.camel@pegasus>
	 <200405062353.34156.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1083918055.4420.100.camel@pegasus>
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
Date: Fri, 07 May 2004 10:20:55 +0200

Hi Michael,

> > The bthid will not be included. I already included the first rough steps
> > of the new hidd, which is going to depend on the hidp kernel module.
> > Right now I marked it as "noinst" and I am not quite sure if I am going
> > to change that before bluez-utils-2.8. However the code is there and I
> > think that I am going to release 2.6.6-mh1 with a prototype of that
> > kernel module.
> 
> PLS release it in 2.7. We will happily wait for it. Longer waiting is killing 
> us at all :)

it is in there, but it is not installed by default. The worst case will
be you have to compile it by yourself and copy the binary. However you
need special kernel support for it and that will be the other problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
