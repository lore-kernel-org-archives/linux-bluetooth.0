Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4720C85B.1090300@hccnet.nl>
Date: Thu, 25 Oct 2007 18:46:19 +0200
From: Remy Bosch <reboli@hccnet.nl>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Audio gaps with bcm2035 and Hama receiver
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

Hi,

I'd like to have my sound sent over from my laptop with a BCM2035 chip to a
Hama receiver. Though it works fine under W*ws, the sound under Linux is
broken off every minute for a second to continue afterwards. I used mplayer
and xmms2. and both have this problem.

I use bluez-libs/utils 3.2
Commands to get audio online:
dbus-send --system --print-reply --dest=org.bluez /org/bluez \
org.bluez.Manager.ActivateService string:audio
dbus-send --system --type=method_call --print-reply --dest=":1.19"
/org/bluez/audio \ org.bluez.audio.Manager.CreateDevice
string:00:10:60:9F:32:3B

For some reason sco isn't used...

Thanks!


Remy



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
