Return-Path: <cyrus@holtmann.org>
Message-ID: <73BDD852208F403CB708EBFA9AED92A0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Mon, 11 Aug 2008 13:18:40 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Question about Bluez-4.1 Object Paths
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

Gents,

After installing 4.1 yesterday, I noticed that the object paths for 
org.bluez.Adapter and org.bluez.Device have changed: both are now 
prefixed with "/org/bluez", probably reflecting the recent firestorm 
with the DBus folks.  So now, the object path for the "zero-th" adapter 
is not "/hci0", but "/org/bluez/hci0" as it was for the "legacy" DBus 
interface.

At the same time, the object path for org.bluez.Manager is still "/". 
Is this intentional, or an oversight?

David Stockwell 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
