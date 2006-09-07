Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200609062040.14856.cijoml@volny.cz>
References: <200609032015.51210.cijoml@volny.cz>
	<200609061935.30152.cijoml@volny.cz>
	<d23110170609061046y6b01f1efm817ef081c302f362@mail.gmail.com>
	<200609062040.14856.cijoml@volny.cz>
Date: Thu, 07 Sep 2006 02:27:35 +0200
Message-Id: <1157588855.30159.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez utils debian package doesn't
	autoswith	dongle on?
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

Hi Michal,

> Second problem is, that hcid doesn't start:
> 
> Sep  6 20:39:17 localhost hcid[27463]: Bluetooth HCI daemon
> Sep  6 20:39:17 localhost hcid[27463]: Can't open system message bus 
> connection: Failed to connect to socket /var/run/dbus/system_bus_socket: No 
> such file or directory
> Sep  6 20:39:17 localhost hcid[27463]: Unable to get on D-Bus
> 
> What is this about??? I can't find any Debian package for this...

make sure that dbus or dbus-1 is installed and the system message is
running. You might have to reboot the system.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
