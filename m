Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stefan Behlert <behlert@suse.de>
To: Paul Hedderly <bulkpaul@mjr.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
Message-ID: <20040915113653.GG7076@suse.de>
References: <20040915090305.GL26469@wacka.mjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040915090305.GL26469@wacka.mjr.org>
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
Date: Wed, 15 Sep 2004 13:36:53 +0200

Hi,

On Sep 15, 04 10:03:05 +0100, Paul Hedderly wrote:
> Ok I got a cheap CF Bluetooth card from ebay. I got it a while ago and
> keep trying to make it work... but can't (all the others I have no
> problem with...)
> 
[...]
> 
> All I get are lines like:
> 
> Sep 15 09:36:11 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x70 received.
> Sep 15 09:36:11 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x60 received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x70 received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x60 received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
> Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x00 received.

I've seen such error-messages when hciattach $DEVICE $MANFID is called
without adding the correct speed.
Have a look at /etc/pcmcia/bluetooth and try e.g.
hciattach $DEVICE $MANFID 115200 
manually. 
It helped here with a card from Brainboxes.
-- 
Stefan Behlert


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
