Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Wurmsdobler <peter@wurmsdobler.org>
In-Reply-To: <48C1160B.7060705@wurmsdobler.org>
References: <48C1160B.7060705@wurmsdobler.org>
Date: Fri, 05 Sep 2008 18:55:55 +0200
Message-Id: <1220633755.6714.83.camel@californication>
Mime-Version: 1.0
Cc: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm tty lost packets
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Peter,

> It appears that rfcomm tty packets are lost on my linux 2.6.22 based 
> embedded system at the startup, but also during the bluetooth 
> connection. There are patches to fix that on :
> 
> http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Faegl%2Flinux-2.6.git&a=search&h=HEAD&st=commit&s=kenzior 
> 
> 
> However, these patches appear to be against a newer version of the 
> kernel. Is it safe to apply the patches mentioned above manually?

that kernel is ancient and the patches might work or not. I am not
planning to look through the list of changes and check if it might
create any possible race conditions.

> Is there an alternative to "upgrade" the bluez part of the kernel and 
> apply the patches?

No.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
