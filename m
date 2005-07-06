Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] H5 3 wire UART connect problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f16b04cf050706022079c5b876@mail.gmail.com>
References: <f16b04cf050630083549f68fef@mail.gmail.com>
	 <1120213256.15397.187.camel@pegasus>
	 <f16b04cf05070103496a3e64e6@mail.gmail.com>
	 <1120224082.15397.197.camel@pegasus>
	 <f16b04cf0507032307413fcef@mail.gmail.com>
	 <f16b04cf05070405321b3bc41b@mail.gmail.com>
	 <f16b04cf05070405392568477e@mail.gmail.com>
	 <1120482028.10273.154.camel@pegasus>
	 <f16b04cf05070500152e8f94c2@mail.gmail.com>
	 <1120551220.10273.202.camel@pegasus>
	 <f16b04cf050706022079c5b876@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120643149.8967.13.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 06 Jul 2005 11:45:49 +0200

Hi Hariharan,

> Please find her with the source modified for the H:5 3 WIRE UART
> Silicon wave dongle
> implementation in Bluez stack.

please send an unified diff for the hciattach changes.

Is this statement "3-Wire UART differs only with the protocol number
definitions" really true? If yes, it should be very easy to integrate
the 3-Wire UART support directly into hci_bcsp.c without any unneeded
overhead.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
