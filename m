Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070330T074518-49@post.gmane.org>
References: <loom.20070330T074518-49@post.gmane.org>
Date: Sat, 31 Mar 2007 15:46:03 +0200
Message-Id: <1175348763.5815.256.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid not working - bluez 3.9
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

Hi Sumeet,

> I have been trying to bring up bluez-utils-3.9 and hcid is not working. It 
> says 
> 
> [root@dlhl0330 tools]# hcid -n
> hcid[29560]: Bluetooth HCI daemon
> hcid[29560]: Can't connect to system message bus: Failed to connect to 
> socket /usr/local/var/run/dbus/system_bus_socket: No such file or directory
> hcid[29560]: Unable to get on D-Bus
> 
> I have looked into the mailing list and followed the mentioned procedure. I 
> have installed dbus-0.61 and started the system bus by calling dbus-launch
> 
> [root@dlhl0330 dbus]# dbus-launch
> DBUS_SESSION_BUS_ADDRESS='unix:abstract=/tmp/dbus-
> BcAG8pbfI2,guid=adea0b46b6c8607cd9bc4162ffe90200';
> DBUS_SESSION_BUS_PID=29606;
> [root@dlhl0330 dbus]#
> 
> I can see the dbus-daemon running when is do ps -e
> 
> system_bus_socket is present at the location /var/run/dbus/system_bus_socket 
> Is there any way I can configure hcid to take the system_bus_socket 
> from /var/run/dbus instead of /usr/local/var/run/dbus

the session bus is not the same as the system bus. You need a running
system bus for hcid. And normally your distribution ensures that it is
setup correctly.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
