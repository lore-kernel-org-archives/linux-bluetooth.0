Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pretec and Ambicom BT2000E driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404100030.49916.pavouk@pavouk.org>
References: <200404100030.49916.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1081593241.3028.7.camel@pegasus>
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
Date: Sat, 10 Apr 2004 12:34:01 +0200

Hi Pavel,

> yesterday somebody talks about BT2000E CF card.
> I have Pretec BT2000E CF card.
> I found new version of alternative driver which probably fix resume problems 
> and 2.6 kernel compiling.

I know that driver and I really thought of including it, but the best
way is to make it working through serial_cs and hci_uart/hciattach. Once
this is solved every card with a 16C950 UART will work and not only the
two with an Ericsson chip on it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
