Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sf.net>
Date: Fri, 30 Mar 2007 12:03:13 +0530
Message-ID: <00b001c77295$4b0d39c0$8935c70a@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-users] Hcid problem bluez 3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi
I have been trying to bring up bluez-utils-3.9 and hcid is not working. It says 

[root@dlhl0330 tools]# hcid -n
hcid[29560]: Bluetooth HCI daemon
hcid[29560]: Can't connect to system message bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket: No such file or directory
hcid[29560]: Unable to get on D-Bus

I have looked into the mailing list and followed the mentioned procedure. I have installed dbus-0.61 and started the system bus by calling dbus-launch

[root@dlhl0330 dbus]# dbus-launch
DBUS_SESSION_BUS_ADDRESS='unix:abstract=/tmp/dbus-BcAG8pbfI2,guid=adea0b46b6c8607cd9bc4162ffe90200';
DBUS_SESSION_BUS_PID=29606;
[root@dlhl0330 dbus]#

I can see the dbus-daemon running when is do ps -e

system_bus_socket is present at the location /var/run/dbus/system_bus_socket Is there any way I can configure hcid to take the system_bus_socket from /var/run/dbus instead of /usr/local/var/run/dbus

Please suggest.



Sumeet 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
