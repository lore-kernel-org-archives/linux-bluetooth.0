Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Palm connection problems.
From: Marcel Holtmann <marcel@holtmann.org>
To: johan@vandenbrande.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <64925.213.118.22.110.1091145636.squirrel@webmail.fusebox.be>
References: <64925.213.118.22.110.1091145636.squirrel@webmail.fusebox.be>
Content-Type: text/plain
Message-Id: <1091179050.12651.174.camel@pegasus>
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
Date: Fri, 30 Jul 2004 11:17:30 +0200

Hi Johan,

> I'm facing a problem connecting my Palm|T to my linux box.
> 
> I've installed BlueZ and can run sdptool to see OPUSH services on my Palm.
> Also, I'm able to bind the device etc. However, when I try to connect via
> network (pppd), I get the following error:
> 
> Jul 30 01:37:24 questor dund[1032]: New connection from 00:07:E0:0E:00:3A
> Jul 30 01:37:24 questor pppd[1033]: pppd 2.4.1 started by root, uid 0
> Jul 30 01:37:24 questor pppd[1033]: Failed to open /dev/rfcomm0: No such
> device

the problem is simple. There is no /dev/rfcomm0 device. What kernel
version do you use? What version of bluez-libs and bluez-utils do you
installed?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
