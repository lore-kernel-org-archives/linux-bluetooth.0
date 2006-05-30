Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <447C5100.9070503@gmx.de>
References: <mailman.301.1148929305.21349.bluez-users@lists.sourceforge.net>
	<447C5100.9070503@gmx.de>
Date: Tue, 30 May 2006 16:24:39 +0200
Message-Id: <1148999079.11251.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth Instability Problem extended info
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

Hi Jens,

> I send you the requested information (and a bit more):
> 
> The bbt is running Kernel 2.4.25-mh5, gcc 3.3.3 with denx elkd version 3.1
> The PC is running suse 9.3 professional with kernel
> 2.6.11.4-21.11-default and gcc 3.3.5 (3.3.3 when cross compiling for PPC)
> 
> I tested some more hardware, the D-Link DBT-120 is revision B4 (got two
> of these), an Acer BT-600, and a Typhoon 20006. Everything works fine
> between two PC's, when used in bbt it still hangs.
> 
> One of my co-workers is suspecting the USB-Host chip, a timing or data
> size problem inside the bbt, so i'll try to check that out, too.

and he might be right with that. The USB stack in a 2.4 kernel is
actually not good. You should really consider moving to a recent 2.6
kernel for your btt.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
