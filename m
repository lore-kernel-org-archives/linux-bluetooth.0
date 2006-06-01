Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <447C4862.5050205@free.fr>
References: <447B4F98.8020501@free.fr>
	<1148934839.31689.116.camel@localhost>  <447C4862.5050205@free.fr>
Date: Thu, 01 Jun 2006 21:15:00 +0200
Message-Id: <1149189300.28511.61.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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

Hi Fabien,

> > please split the changes to Bluetooth core and SCO module. Your changes
> > to the core will conflict with the automatic sniff mode support and I
> > need to sort that out.
> 
> Ok, i've just done that, i've split the patch into three smaller bits.
>    - Patch part 1 are changes to hci core required for SCO flow control 
> itself.
>    - Patch part 2 are the changes to the SCO socket layer.
>    - Patch part 3 are additionnal comments on hci core code.
> 
> Please note however that part 1 and part 2 can not be applied seperately.

so far I only looked at the changes to the HCI core. Please don't rename
the disconnect timer. This will collide with the changes for automatic
sniff mode support.

Can we change the core and add a hci_stream_sco() without breaking the
API. This would make it easier for me to apply the changes.

Another question is if we really should queue the data in sk_write_queue
and not directly in the core. I would prefer to send the data to the
core and then stream it from there.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
