Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Packages to Use For Zaurus SL-6000L
From: Marcel Holtmann <marcel@holtmann.org>
To: murat_bog@yahoo.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041016065031.39199.qmail@web60406.mail.yahoo.com>
References: <20041016065031.39199.qmail@web60406.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1097927722.4911.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 16 Oct 2004 13:55:22 +0200

Hi Murat,

> I am wondering which combination of Bluez packages I
> should be installing on a Zaurus 6000L with factory
> configuration(2.4.18-rml7-pxa3-embedix with ROM
> version 1.12) to work with an AmbiCom BT2000CF card.
> 
> The latest set of packages do not seem to be working
> together.  When I install bluez-utils-2.10_arm.ipk, it
> reports a dependency error when used with
> bluez-kernel-2.4.18-mh15_arm.ipk and
> bluez-libs-2.10_arm.ipk.
> 
> I also see that when I run "/etc/rc.d/init.d/bluetooth
> start" command, I get the following message:
> 
> "Starting Bluetooth subsystem:/usr/sbin/hcid: error
> while loading shared libraries: libsdp.so.2: cannot
> load shared object file: No such file or directory"

you need an updated kernel, because the Bluetooth support of the 2.4.18
kernel is outdated. However I don't own a Zaurus and I have no idea how
to fix this the right way.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
