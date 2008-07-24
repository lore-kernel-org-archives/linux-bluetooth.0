Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 24 Jul 2008 18:08:13 +0000 (UTC)
Message-ID: <loom.20080724T175951-14@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] About socket interface
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

Hi,
I have a question about the user socket interface.
When I run the scotest -d, I know it will basically call sco_sock_accept in sco.c
Inside it, there is a wait queue and try to find a new socket.
The accept() will be notified when there is a new connection coming from another
client.
My question is: how the bluez notify the user socket "accept()"? Can anyone tell
me where the event is generated and finally notify user socket accept()? Just
need a keyword.

Hope this time someone can answer me. maybe I am keeping asking stupid question
so that nobody wants to answer it.

Bests


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
