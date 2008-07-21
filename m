Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jeremy Goodwill <skatewalking@gmail.com>
Date: Mon, 21 Jul 2008 05:49:59 +0000 (UTC)
Message-ID: <loom.20080721T053030-510@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Combinations of multiple BT dongles,
	master/slave role change
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

Hi all,

Pls bear with me if I have missed out some fundamentals of Bluez/Bluetooth.

My question is:

Using following topology

Machine (with Bluez stack) connected to 2 USB dongles:
-dongle A
-dongle B

The following procedure is performed:
1) dongle A connects to device C
2) role switch of dongle A to master
3) connection becomes active
4) dongle B connects to device D
5) role switch of dongle B to master
6) connection becomes active

At this point, will channel collision occur?  Is Bluez aware of the different
channels that each connected dongle is using and therefore avoid using the same
ones? 

Thanks in advance,
Jer





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
