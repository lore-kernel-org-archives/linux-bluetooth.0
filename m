Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Mon, 2 Apr 2007 11:53:47 +0530
Message-ID: <009501c774ef$78f86920$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1175348763.5815.256.camel@violet>
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

Hi Marcel,
How would I know that the system bus is up and running? Basically I think
the problem is the socket system_bus_socket is created in /var/run/dbus
instead of /usr/local/var/run/dbus.

I tried to configure the dbus-0.61 package with the following string

./configure --prefix=/usr/local --disable-gtk --disable-selinux
--with-session-socket-dir=/usr/local/var/run/dbus
--with-dbus-user=messagebus --with-test-socket-dir=/usr/local/var/run/dbus 
But still it doesn't work.

Any pointers?

Regards,

Sumeet 
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Saturday, March 31, 2007 7:16 PM
To: BlueZ users
Subject: Re: [Bluez-users] hcid not working - bluez 3.9

Hi Sumeet,

> I have been trying to bring up bluez-utils-3.9 and hcid is not 
> working. It says
> 
> [root@dlhl0330 tools]# hcid -n
> hcid[29560]: Bluetooth HCI daemon
> hcid[29560]: Can't connect to system message bus: Failed to connect to 
> socket /usr/local/var/run/dbus/system_bus_socket: No such file or 
> directory
> hcid[29560]: Unable to get on D-Bus
> 
> I have looked into the mailing list and followed the mentioned 
> procedure. I have installed dbus-0.61 and started the system bus by 
> calling dbus-launch
> 
> [root@dlhl0330 dbus]# dbus-launch
> DBUS_SESSION_BUS_ADDRESS='unix:abstract=/tmp/dbus-
> BcAG8pbfI2,guid=adea0b46b6c8607cd9bc4162ffe90200';
> DBUS_SESSION_BUS_PID=29606;
> [root@dlhl0330 dbus]#
> 
> I can see the dbus-daemon running when is do ps -e
> 
> system_bus_socket is present at the location 
> /var/run/dbus/system_bus_socket Is there any way I can configure hcid 
> to take the system_bus_socket from /var/run/dbus instead of 
> /usr/local/var/run/dbus

the session bus is not the same as the system bus. You need a running system
bus for hcid. And normally your distribution ensures that it is setup
correctly.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
