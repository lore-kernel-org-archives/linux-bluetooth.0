Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4457BEF2.90707@free.fr>
References: <4457BEF2.90707@free.fr>
Date: Mon, 05 Jun 2006 16:10:42 +0200
Message-Id: <1149516642.7696.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFC : H4 and BCSP proto unification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Matthieu,

> this patch is an attempt to share H4 and BCSP proto for other drivers
> than hci_uart.
> 
> hci_h4.c and hci_bcsp.c where expecting a hci_uart structure, I define a
> more generic one. I need to add a tx_wakeup function for BCSP.
> 
> I also added 1 operation henqueue that queue a skb in the head of the
> skb list for driver that can't send all the skb data in one operation.
> 
> This is far from perfect (I don't like the hci_dev pointer duplication,
> ...) and untested for hci_uart driver.
> 
> Any comments will be appreciated.

we don't need anything for BCSP. So don't even bother with it, but for
H4 it makes sense to have on common code. However using an extra module
for it is a little bit too much. I would prefer using something like
libata etc. So creating a libh4 and using it would be the better
approach.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
