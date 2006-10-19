Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 13:56:08 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061019115608.GB31910@suse.de>
MIME-Version: 1.0
Subject: [Bluez-users] DiscoverDevices with apitest?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

i tried today to discover devices with apitest (instead of "hcitool scan"),
but it did not work:

seife@strolchi:~> apitest DiscoverDevices
None

and it returns immediately. So i tried my luck with direct "dbus-send":
seife@strolchi:~> dbus-send --system --dest=3Dorg.bluez --print-reply /org/=
bluez/hci0 org.bluez.Adapter.DiscoverDevices
method return sender=3D:1.541 -> dest=3D:1.867

No luck either.
I always get this in my syslog from hcid:
Oct 19 13:52:39 strolchi hcid[17330]: Introspect path:/org/bluez
Oct 19 13:52:39 strolchi hcid[17330]: Introspect path:/org/bluez/hci0
Oct 19 13:52:39 strolchi hcid[17330]: name_listener_add(:1.869)
Oct 19 13:52:39 strolchi hcid[17330]: DiscoverDevices requestor at :1.869 e=
xited before the operation finished
Oct 19 13:52:39 strolchi hcid[17330]: name_listener_remove(:1.869)
Oct 19 13:52:39 strolchi hcid[17330]: remove_name_listener: no listener for=
 :1.869

So why doesn't the dbus call block? I also tried with a "apitest -l"
running in parallel, to see if this would get something discovered, but it
didn't:
seife@strolchi:~> apitest -l
Listening for events...
DiscoveryStarted - /org/bluez/hci0:
DiscoveryCompleted - /org/bluez/hci0:
DiscoveryStarted - /org/bluez/hci0:
DiscoveryCompleted - /org/bluez/hci0:
Caught signal, exiting

So am i doing something wrong?

I'm running bluez-{libs,utils} version 3.7 on 2.6.18.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
