Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <64925.213.118.22.110.1091145636.squirrel@webmail.fusebox.be>
From: "Johan Van den Brande" <johan@vandenbrande.com>
To: bluez-users@lists.sourceforge.net
Reply-To: johan@vandenbrande.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Palm connection problems.
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
Date: Fri, 30 Jul 2004 02:00:36 +0200 (CEST)

Hi,

I'm facing a problem connecting my Palm|T to my linux box.

I've installed BlueZ and can run sdptool to see OPUSH services on my Palm.
Also, I'm able to bind the device etc. However, when I try to connect via
network (pppd), I get the following error:

Jul 30 01:37:24 questor dund[1032]: New connection from 00:07:E0:0E:00:3A
Jul 30 01:37:24 questor pppd[1033]: pppd 2.4.1 started by root, uid 0
Jul 30 01:37:24 questor pppd[1033]: Failed to open /dev/rfcomm0: No such
device
Jul 30 01:37:24 questor pppd[1033]: Exit.

I can connect to the Palm manually (at least, the Palm says 'connection in
progress') using:
rfcomm connect /dev/rfcomm0 00:07:E0:0E:00:3A 1

Anybody who knows what the problem can be?

Johan

-- 
Johan Van den Brande





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
