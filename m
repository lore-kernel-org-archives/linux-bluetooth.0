Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM error message
From: Marcel Holtmann <marcel@holtmann.org>
To: ra002890@ic.unicamp.br
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1025.200.207.51.132.1090605410.squirrel@webmail.ic.unicamp.br>
References: <1025.200.207.51.132.1090605410.squirrel@webmail.ic.unicamp.br>
Content-Type: text/plain
Message-Id: <1090659756.4791.65.camel@pegasus>
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
Date: Sat, 24 Jul 2004 11:02:36 +0200

Hi Daniel,

>  Now I'm trying to put bluez to work with my embedded linux aplication in
> a ppc cpu. I have already recompiled it and tested it with l2ping and
> l2test, but when I try to use rfcomm I receive this message:
> 
> /mnt/flash/validador/aplicativo # rfcomm connect rfcomm1 00:01:24:00:30:de
> 1 &
> /mnt/flash/validador/aplicativo # bcsp_timed_event: Timeout,
> retransmitting 1 pkts
> Can't create RFCOMM TTY: Operation not supported
> 
> Does anybody knows why it sends me this error?

you haven't compiled in the RFCOMM TTY support into your RFCOMM kernel
module.

> And why I'm receiving a bcsp_timed_event warning?

You can ignore this. It happens and I am going to change this error into
a debug message.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
