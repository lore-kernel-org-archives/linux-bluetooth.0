Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060718225953.76507.qmail@web51415.mail.yahoo.com>
References: <20060718225953.76507.qmail@web51415.mail.yahoo.com>
Date: Wed, 26 Jul 2006 09:31:37 +0200
Message-Id: <1153899097.746.20.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] HCID startup error
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

Hi Manoj,

> I have installed following on CentOS 3.3.
> bluez-libs-3.1.tar.gz 
> bluez-utils-3.1.tar.gz 
> bluez-firmware-1.2.tar.gz 
> bluez-hcidump-1.31.tar.gz 
> I see following errors when i start hcid in /var/log/messages/ 
>          hcid[4770]: Bluetooth HCI daemon
>          hcid[4770]: Service could not become primary owner
>          hcid[4770]: Unable to get on D-Bus
>  
> I have started dbus using dbus-daemon and dbus-launch --system. The
> files system-bus-socket and messgebus.pid exist
> under /usr/local/var/run and /usr/local/var/run/dbus/.
>  
> Pls let me know what am i missing?  Is there any documentation
> available to get bluez working with dbus?
> Any help is greatly appreciated.

this seems like bluez-hcid.conf is not installed properly. If this is
placed in the wrong directory, D-Bus will reject any connections for
org.bluez and thus it won't work.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
