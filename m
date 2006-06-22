Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <bf1d6e70606212208r7ed5e33ak5895b61024c36850@mail.gmail.com>
References: <bf1d6e70606212208r7ed5e33ak5895b61024c36850@mail.gmail.com>
Date: Thu, 22 Jun 2006 09:02:56 +0200
Message-Id: <1150959776.13991.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez installation
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

Hi Lavanya,

> I tried installing the packages given in your website for Bluez..
> namely
> 
>       * bluez-libs-3.1.tar.gz
>       * bluez-utils-3.1.tar.gz
>       * bluez-firmware-1.2.tar.gz
>       * bluez-hcidump-1.31.tar.gz
> 
> the first one worked fine.. utils package configuring gave error as
> below
> 
> 
> checking for DBUS... Package dbus-glib-1 was not found in the
> pkg-config search path.
> Perhaps you should add the directory containing `dbus-glib-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-glib-1' found
> configure: error: dbus-glib > 0.35 is required
> 
> 
> 
> could you let me know where the problem is?

check the mailing list archive. This has already been discussed and it
is a bug. The bluez-utils should only require the D-Bus low-level
library. Will be fixed in the next version.

Regards

Marcel



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
