Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Fri, 25 Jul 2008 02:14:59 +0000 (UTC)
Message-ID: <loom.20080725T021244-625@post.gmane.org>
References: <loom.20080724T175951-14@post.gmane.org>
	<50b40ba70807241118y79325efene53bde2612e8c783@mail.gmail.com>
	<loom.20080724T182719-946@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About socket interface
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I just observed that
when user socket is listening.
The debug message following the listen() function will be printed before the
message in sco_sock_listen().
So... I guess it's because the "printk in kernel" and "syslog in user space" are
running asynchronously in /var/log/messages.

Jui-Hao





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
