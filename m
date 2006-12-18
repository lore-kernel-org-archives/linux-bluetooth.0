Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612171724s40f8850dtefd626680321c21b@mail.gmail.com>
Date: Sun, 17 Dec 2006 17:24:18 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] proper dbus config for hcid
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1769486822=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1769486822==
Content-Type: multipart/alternative;
	boundary="----=_Part_10262_5538494.1166405058144"

------=_Part_10262_5538494.1166405058144
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

I am on Fedora Linux and I am unable to get hcid to start.  It complains
that it cannot communicate with DBUS:

[root@localhost init.d]#   ps -ef | grep dbus
root      2454  2406  0 16:45 ?        00:00:00 /usr/bin/ssh-agent
/usr/bin/dbus-launch --exit-with-session gnome-session
501       3137     1  0 17:14 ?        00:00:00 dbus-daemon --system
root      3208  2703  0 17:20 pts/2    00:00:00 grep dbus
[root@localhost init.d]# hcid -n
hcid[3210]: Bluetooth HCI daemon
hcid[3210]: Service could not become the primary owner.
hcid[3210]: Unable to get on D-Bus
[root@localhost init.d]#

I already put in allow own = "*" in the dbus config. file.
Am I missing a step?
Thanks

Mark

------=_Part_10262_5538494.1166405058144
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi:&nbsp; <br>
<br>
I am on Fedora Linux and I am unable to get hcid to start.&nbsp; It complains that it cannot communicate with DBUS:<br>
<br>
[root@localhost init.d]#&nbsp;&nbsp; ps -ef | grep dbus<br>
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2454&nbsp; 2406&nbsp; 0 16:45 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 /usr/bin/ssh-agent /usr/bin/dbus-launch --exit-with-session gnome-session<br>
501&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3137&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0 17:14 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 dbus-daemon --system<br>
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3208&nbsp; 2703&nbsp; 0 17:20 pts/2&nbsp;&nbsp;&nbsp; 00:00:00 grep dbus<br>
[root@localhost init.d]# hcid -n<br>
hcid[3210]: Bluetooth HCI daemon<br>
hcid[3210]: Service could not become the primary owner.<br>
hcid[3210]: Unable to get on D-Bus<br>
[root@localhost init.d]#<br>
<br>
I already put in allow own = &quot;*&quot; in the dbus config. file.&nbsp; <br>
Am I missing a step?<br>
Thanks<br>
<br>Mark<br><br>

------=_Part_10262_5538494.1166405058144--


--===============1769486822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1769486822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1769486822==--
