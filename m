Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Malmgren <danielovictoria@telia.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2161615.1168251295635.JavaMail.tomcat@pne-ps2-sn2>
References: <2161615.1168251295635.JavaMail.tomcat@pne-ps2-sn2>
Date: Mon, 15 Jan 2007 14:32:05 +0100
Message-Id: <1168867925.5728.16.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't seem to find my bluetooth
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

Hi Daniel,

> I'm trying to get Bluetooth working on my Znote 6015WD laptop and I 
> don't really know where to start. I'm running Fedora Rawhide (x86_64). 
> I don't even know what bt chip the computer has (or how to find out). 
> Hcitool just says I haven't got any bluetooth device. Neither lspci nor 
> lsusb shows anything that seems relevant. From lshal all I get is the 
> following:
> 
> udi = '/org/freedesktop/Hal/devices/platform_bluetooth'
>   info.udi = '/org/freedesktop/Hal/devices/platform_bluetooth'  
> (string)
>   linux.subsystem = 'platform'  (string)
>   linux.hotplug_type = 1  (0x1)  (int)
>   info.product = 'Platform Device (bluetooth)'  (string)
>   platform.id = 'bluetooth'  (string)
>   info.parent = '/org/freedesktop/Hal/devices/computer'  (string)
>   info.bus = 'platform'  (string)
>   linux.sysfs_path_device = '/sys/devices/platform/bluetooth'  
> (string)
>   linux.sysfs_path = '/sys/devices/platform/bluetooth'  (string)
> 
> ...which doesn't say me much. There is a led on the front of the 
> computer which is blue, which according to the manual means that 
> bluetooth is inactive, but I've got no idea of how to activate it. 
> Where do I start?

these are generic information that are always present. You need to find
the hardware switch to enable your Bluetooth module and then it will
show up in lsusb.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
