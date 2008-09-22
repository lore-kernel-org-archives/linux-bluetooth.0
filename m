Return-Path: <cyrus@holtmann.org>
Message-ID: <48D80826.9070502@pook.es>
Date: Mon, 22 Sep 2008 23:03:34 +0200
From: Stuart Pook <bluez56@pook.es>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] "unable to install hw params" to bluetooth (SCO)
 headset (was: btusb+sco failing to play sound through Jabra BT500v headset)
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello

I have read Martin's messages concerning his Jabra BT500v bluetooth headset.

I have similar problems with my Jabra JX10 headset.  I have installed 
bluez-4.4. When I run aplay with a 2.6.26 kernel, aplay works. When I 
run aplay with linux 2.6.27-rc5 I can hear a hiss when my PC connects to 
the headset but no music.

I have written a long bug report on 
http://bugzilla.kernel.org/show_bug.cgi?id=11514 with the output of 
hcidump -X -V and the messages from bluetoothd. Could someone have a 
look and give me a hint about what I might be doing wrong? Has anyone 
had any luck with Jabra headsets and 2.6.27-rc5 or should I buy a 
different brand of headset? Marcel Holtmann said that "It simply works 
for me." What headsets have you tested?

aplay always says "Unable to install hw params" after bluetoothd says 
"connect(): Connection timed out (110)" but hcidump shows lots of SCO 
packets being sent to the headset.

thanks
Stuart

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
