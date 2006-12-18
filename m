Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612171648r74c532abg43dab9ac96b85f1c@mail.gmail.com>
Date: Sun, 17 Dec 2006 16:48:57 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] dbus connection failed and so hcid won't start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0670611554=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0670611554==
Content-Type: multipart/alternative;
	boundary="----=_Part_9865_31523074.1166402937931"

------=_Part_9865_31523074.1166402937931
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:  I did not come across this problem on SuSE.  This afternoon, however, I
have moved over to use a Fedora based box for development.  I found that
hcid won't even start.  I can see that my BT radio (USB dongle) is there and
UP.  I can scan for devices.
I also see dbus running as well.  But when I start hcid, I got:


[root@localhost ~]# hcid -n
hcid[2574]: Bluetooth HCI daemon
hcid[2574]: Can't open system message bus connection: Did not receive a
reply. Possible causes include: the remote application did not send a reply,
the message bus security policy blocked the reply, the reply timeout
expired, or the network connection was broken.
hcid[2574]: Unable to get on D-Bus
[root@localhost ~]#

Do I need to configure something on the dbus side?

Mark

------=_Part_9865_31523074.1166402937931
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi:&nbsp; I did not come across this problem on SuSE.&nbsp; This afternoon, however, I have moved over to use a Fedora based box for development.&nbsp; I found that hcid won't even start.&nbsp; I can see that my BT radio (USB dongle) is there and UP.&nbsp; I can scan for devices.
<br>I also see dbus running as well.&nbsp; But when I start hcid, I got:<br><br><br>[root@localhost ~]# hcid -n<br>hcid[2574]: Bluetooth HCI daemon<br>hcid[2574]: Can't open system message bus connection: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.
<br>hcid[2574]: Unable to get on D-Bus<br>[root@localhost ~]#<br><br>Do I need to configure something on the dbus side?<br><br>Mark

------=_Part_9865_31523074.1166402937931--


--===============0670611554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0670611554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0670611554==--
