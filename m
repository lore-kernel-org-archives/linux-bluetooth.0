Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405080023.12137.cijoml@volny.cz>
References: <1083857533.16650.25.camel@saag>
	 <200405072351.32016.cijoml@volny.cz> <1083967722.4420.144.camel@pegasus>
	 <200405080023.12137.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1083970579.4420.151.camel@pegasus>
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
Date: Sat, 08 May 2004 00:56:19 +0200

Hi Michal,

> > I don't really think so, because this is not an easy work and my focus
> > is on 2.6. However I added some missing stuff to hidd and it will be
> > enabled in bluez-utils-2.7 even if I haven't published a patch that
> > includes the hidp kernel module so far.
> 
> It is needed to have hid support in 2.4 and doesn't metter which way it will 
> be supported. But I except, that you'll make bthid deprecated when hidp 
> kernel module will be released, so... 

don't worry too much about it, because the final release of hidp is not
expected very soon. I am going to add a prototype to my -mh patches and
that's it. However the bthid was never really released, so you are right
and I will deprecate it at some point and remove it from CVS.

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
