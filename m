Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sebastian Alff <Sebastian-Alff@gmx.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 11 Oct 2007 19:49:19 +0200
Message-Id: <1192124959.3808.11.camel@91-64-236-100-dynip>
Mime-Version: 1.0
Subject: [Bluez-users] integrated blutooth on laptop doesn't work
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

Hello!

I just installed openSuSe 10.3 with gnome on my laptop and now I'm
trying to get Blutooth (under gnome) to work. I installed the up-to-date
bluez packages (+an extra one for gnome). Starting bluetooth
(/etc/init.d/bluetooth start) seems to work (output: Starting bluetooth:
hcid hid2hci  done). I also started "Bluetooth-Dateiaustausch (in
englisch something like Bluetooth-File exchange), but don't know if
thats required.
Calling hcitool dev/inq/scan gives no results. The program hcid (as
described in some tutorials) is not installed on my system.

Would anyone help me with getting bluetooth to work? And, yes the
bluetooth switch is turned 'on' :).

regards,
Sebastian


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
