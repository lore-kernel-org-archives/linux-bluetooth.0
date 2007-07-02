Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46896137.90202@gmail.com>
Date: Tue, 03 Jul 2007 02:03:59 +0530
From: Rogue <roguexz@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] A few questions about bluetooth-alsa project
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

Hi All,

I am new to this list. I was looking at options of connecting my 
Bluetooth headset to my laptop running Fedora 7, and came across this site.

So first up, I have built sample spec files that generate rpm files out 
of sbc and plugz. In case you are interested then I can share them with 
you all.

Now, I have installed both plugz and sbc. I am trying to use sco for 
doing the two-way communication. I have copied over the 
plugz/alsa-plugins/asound.conf (as ~/.asoundrc) and changed the BT 
address to my headset's.

I ran the headset daemon and I noticed that my gnome-volume applet looks 
different and shows a new control called PCM-2. But beyond this I am 
unable to do much.

I also noticed that the website states that I need kernel patches. Is 
this still true for kernels > 2.6.21 ??

I would really appreciate it if people could help me out with figuring 
out this headset integration.

thanks,
Rogue

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
