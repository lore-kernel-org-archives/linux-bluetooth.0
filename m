Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46DF18F7.8000807@gmail.com>
Date: Wed, 05 Sep 2007 23:00:39 +0200
From: Advhertz <advhertz@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
Subject: [Bluez-users] [BLUETOOTH-ALSA] Skype with SCO/headsetd deamon
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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
List-ID: <bluez-devel.lists.sourceforge.net>

Hi there,
anyone knows how to let to works an headset bluetooth via SCO protocol 
with skype?

Once compiled and installed the bluetooth-alsa stack I've configured the 
~/.asoundrc as the attached one and I did works the headset with vlc 
(vlc --alsadev=headset-sco-resample file.mp3) and aplay (aplay -D 
headset-sco-resample file.wav) well.

But as tried with skype, I had some problem.

When I launch skype the system do the pairing with the headset device 
but when I'm trying to make some tests (sound test and test call) I 
don't hear nothing.

Any suggestion/advice?

Thanks,
Best Regards,
Advhertz

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
