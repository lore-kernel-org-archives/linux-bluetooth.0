Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <448946B7.6000002@personnelware.com>
References: <448946B7.6000002@personnelware.com>
Date: Fri, 09 Jun 2006 12:12:48 +0200
Message-Id: <1149847968.6618.73.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] seg fault in rfcomm
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

Hi Carl,

> carl@asus17:~$ sudo hcitool scan
> Scanning ...
>         08:00:37:03:EF:36       PM325 by LG
> carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4
> Connected /dev/rfcomm0 to 08:00:37:03:EF:36 on channel 4
> Press CTRL-C for hangup
> 
> Segmentation fault

this shouldn't happen. What version is this and what platform you are
running this on. Try the latest version from CVS and run it with gdb to
get the backtrace.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
