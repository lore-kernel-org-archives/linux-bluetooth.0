Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <446B7242.7050106@gmx.de>
References: <OF0B6841A9.963250D8-ONC1257171.002503E4-C1257171.00289B9D@dcx.dcx>
	<446B7242.7050106@gmx.de>
Date: Mon, 29 May 2006 15:25:01 +0200
Message-Id: <1148909101.31689.48.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth instability problem
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

> I don't know if i'm at the right spot here, but i'll ask here first. I
> have the following problem:
> 
> I've 3 "PCs" (one is an embedded linux based broadband handheld tester,
> afterwards refered to as bbt), all running linux with Kernels from 2.24
> (bbt) to 2.26 (PCs), and identical bluetooth usb-sticks (D-Link BT120).
> 
> Here's what i've done / what i know:
> 
> Downloaded the latest bluez-libs and bluez-utils, compiled and
> installed. Ran configure / make for a new kernel with only that
> functions needed, installed it to the bbt.
> 
> Running some tests with l2ping brought the following results. I can ping
> the bbt, sometimes i get no response messages (max. 5 after another,
> most times 4 in a row). This test runs for about 30 minutes, then i
> canceled it. The bigger I define paketsize (defaults 44 Bytes) the
> faster / more often come those no response messages and, here it comes!,
> when more than 250 Bytes are specified, the connection hangs! Aprox. 2
> minutes. The bigger the paketsize the faster it hangs.
> After it once hung, only a total reset of the bbt gets it running again.
> 
> Between those 2 PCs, I only had problems with rfcomm and dun, pan worked
> just fine. After i updated the Systems (it's SuSe linux 9.1 and 9.3, i
> forgot to say that) those problems where gone.
> 
> The biggest Problem is, that i can't path or upgrade the kernel in the bbt.

what kernel versions are you using. You mentioned onyl the bluez-utils
versions. Please specify the exact commands you are using for testing
and include the output of "hcidump -X -V".

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
