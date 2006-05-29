Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447B45DF.5050207@free.fr>
Date: Mon, 29 May 2006 21:05:03 +0200
From: matthieu castet <castet.matthieu@free.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <4457BEF2.90707@free.fr>
In-Reply-To: <4457BEF2.90707@free.fr>
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

matthieu castet wrote:
> Hi,
> 
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
> 
> Thanks,
> 
> Matthieu
> 
No comments :(

Matthieu


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
