Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4494238A.1050007@stfw.eu>
References: <448DB88D.8080306@stfw.eu>
	<1150540347.17539.28.camel@aeonflux.holtmann.net>
	<4494238A.1050007@stfw.eu>
Date: Sun, 18 Jun 2006 09:13:25 +0200
Message-Id: <1150614805.4109.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hidd error 14 (Bad address) on ubuntu ppc
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

Hi,

> Hi, thanks for investigate my problem. I've put the result of hcidump 
> here: http://stfw.eu/hcidump-X-V.txt
> 
> Here is the command I did and the result:
> root@Monster:~# hidd --connect 00:0A:95:3A:CA:44
> HID create error 14 (Bad address)
> root@Monster:~#
> 
> Here what was writen in syslog (only one line):
> Jun 17 16:20:16 localhost hidd: New HID device 00:0A:95:3A:CA:44 (Apple 
> Wireless Keyboard)

make sure that the hidp kernel module is loaded.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
