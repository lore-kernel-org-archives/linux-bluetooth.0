Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 8 Jan 2007 18:37:04 +0100
MIME-Version: 1.0
Message-Id: <200701081837.04388.dgollub@suse.de>
Subject: [Bluez-devel] Should hcid wait for dbus daemon?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

the hcid daemon aborts when there is no dbus daemon running. What about 
enhancing hcid to handle the case that the dbus daemon get started after 
hcid. I know there are might be not many use cases. But at least i know one 
case ;)

To avoid that there is another "unneeded" service running, i want to call only 
the bluetooth init scripts when there is a bluetooth device plugged in. This 
is done by a simple udev rule, which calls the bluetooth init script when the 
device got plugged in.

So there is no need to insserv or do any other stuff like running YaST or 
something like that. Just turn on the bluetooth device or plug it in and the 
bluetooth service get started by udev.

The only problem is during boot. udev get started before the dbus daemon, and 
will trigger the udev rule which calls the bluetooth init script. Then hcid 
will fail because the dbus daemon isn't started in this early stage of boot.

If the hcid would wait for the dbus daemon this wouldn't be a problem. At 
least hcid can handle a dbus daemon restart, maybe we can enhance this.

I know this can be also done in the bluetooth init script, but maybe someone 
else insist on this enhancement.

best regards,
Daniel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
