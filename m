Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sf.net>
Date: Mon, 5 Nov 2007 14:31:16 +0530
Message-ID: <018c01c81f8a$6d010370$832fc70a@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-users] Problem with HSP/HFP in bluez-3.22
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

Hi
I am trying to test the Headset profile using bluez-3.22 but I am facing the following error. I followed the steps from
http://wiki.bluez.org/wiki/HOWTO/AudioDevices


[root@dlhl0330 audio]# dbus-send --system --print-reply --type=method_call --dest=:1.3 /org/bluez/audio org.bluez.audio.Manager.CreateHeadset string:XX:XX:XX:11:65:00
method return sender=:1.3 -> dest=:1.19
 string "/org/bluez/audio/device3"
[root@dlhl0330 audio]# dbus-send --system --print-reply --type=method_call --dest=:1.3 /org/bluez/audio/device3 org.bluez.audio.Headset.Connect
Error org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with signature "" on interface "org.bluez.audio.Headset" doesn't exist


The A2DP profile is working fine.

Regards,
Sumeet 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
