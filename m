Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405071153.59387.cijoml@volny.cz>
References: <1083857533.16650.25.camel@saag>
	 <200405070028.06843.cijoml@volny.cz> <1083918493.4420.109.camel@pegasus>
	 <200405071153.59387.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1083946453.4420.122.camel@pegasus>
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
Date: Fri, 07 May 2004 18:14:13 +0200

Hi Michal,

> > the hidp kernel module is designed to implement only HIDP. It works
> > mostly the same way as BNEP and CMTP, but it needs a lot more
> > information from the SDP database of the remote device. Thus the
> > structures had to evolve over time and now I think I found the perfect
> > match on what the kernel has to know and what not. You can look at the
> > hidp_connadd_req struct in libs/include/hidp.h and see what I mean. The
> > problem of hidd at the moment is that it only fills in the sockets and
> > the report descriptor data. Once hidd had given the connection to the
> > hidp module everything else is done inside the kernel. This means that
> > you can even stop and restart hidd without losing your input device.
> 
> Great :) And now, do you plane to backport hidp kernel module from 2.6 to 2.4?

I have no plans for doing this.

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
