Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20080823T192730-77@post.gmane.org>
References: <loom.20080822T022926-635@post.gmane.org>
	<loom.20080823T192730-77@post.gmane.org>
Date: Sat, 23 Aug 2008 22:22:45 +0200
Message-Id: <1219522965.7591.482.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Patch] Flush Occurred Event
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

> The following is a patch against 2.6.22 kernel to catch HCI "Flush Occurred"
> event. (meaningful for ACL; useless for SCO)
> 
> One more thing to NOTICE is that the handle in the event packet from my adapter
> seems to be "Big Endian", so that I use ntohs to convert it.
> Normally it should be __le16_to_cpu(ev->handle)

against 2.6.27-rc4 please and in unified diff format. I am not even
going to bother reading context diffs.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
