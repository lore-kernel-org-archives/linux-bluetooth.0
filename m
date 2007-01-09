Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 9 Jan 2007 09:27:09 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070109082709.GB5956@suse.de>
References: <200701081837.04388.dgollub@suse.de>
	<20070108184701.GA12689@jh-mbp> <878xgd3xkv.fsf@tora.pca.it>
MIME-Version: 1.0
In-Reply-To: <878xgd3xkv.fsf@tora.pca.it>
Subject: Re: [Bluez-devel] Should hcid wait for dbus daemon?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luca,

On Tue, Jan 09, 2007 at 12:31:12AM +0100, Luca Capello wrote:

> NB, I'm not deeply involved in bluetooth neither dbus development,
> just a "power user".  If my thoughts are wrong, just discard them.

They are not wrong, it is just a different use case :-)

> Shouldn't be the contrary?  I mean, on a clean Debian etch, every
> dbus-dependent service is started by dbus:
 =

> root@gismo:/home/luca# invoke-rc.d dbus start
> Starting system message bus: dbus.
> Starting Hardware abstraction layer: hald.
> Starting DHCP D-Bus daemon: dhcdbd.
> Starting network connection manager: NetworkManager.
> Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
> Starting network events dispatcher: NetworkManagerDispatcher.
> =

> root@gismo:/home/luca#

This is about the same if i statically enable the bluetooth service
on a SUSE machine. But i would like to avoid that (no need to run
hcid on a machine that will never see a BT device). At the same time,
i like to have it "just work", without the user needing to configure
it. So i start the bluetooth services via udev, when a BT device
is connected.

This works very well once the machine is up and running. If the device
is connected during boot, it is different, because the udev "coldplug"
happens before most of the services are started.

I hope this clears up my (and Daniels) intentions :-)

Have fun
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
