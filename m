Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Hedderly <bulkpaul@mjr.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040915123623.GQ26469@wacka.mjr.org>
References: <20040915090305.GL26469@wacka.mjr.org>
	 <20040915123623.GQ26469@wacka.mjr.org>
Content-Type: text/plain
Message-Id: <1095255481.5263.111.camel@pegasus>
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
Date: Wed, 15 Sep 2004 15:38:01 +0200

Hi Paul,

> Apparently this card does work with linux:
> 	http://www.mavintec.com/product_bt_cf.eng.html
> Above link shows my card - though it does not say mavin/tec anywhere on
> it.
> 
> That page points to Marcel's webpage to show that their card works with
> btuart_cs...
> 
> /me tries btuart_cs again!
> 
> Of course just because the model number matches precisely and the card
> looks identical... doesn't mean that the board inside is the same. Sigh!

I think there was something like this. They changed from an Ericsson
chip to a CSR chip, but they kept the initial baud rate of 57600. Try to
play with it, because hciattach offers you an switch for the initial
baud rate setting.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
