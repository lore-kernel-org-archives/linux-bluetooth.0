Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Hedderly <bulkpaul@mjr.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040915090305.GL26469@wacka.mjr.org>
References: <20040915090305.GL26469@wacka.mjr.org>
Content-Type: text/plain
Message-Id: <1095248205.5263.57.camel@pegasus>
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
Date: Wed, 15 Sep 2004 13:36:46 +0200

Hi Paul,

> Ok I got a cheap CF Bluetooth card from ebay. I got it a while ago and
> keep trying to make it work... but can't (all the others I have no
> problem with...)
> 
> I think it's a 'Mavin' - there are pictures of the front and back at:
> 	http://mjr.org/bt/front.jpg
> 	http://mjr.org/bt/back.jpg
> 	http://mjr.org/bt/inside.jpg
> 	http://mjr.org/bt/closeup.jpg
> 
> The main chips inside (to save you needing to to the pics :O) are:
> 	OXCF950
> 	BC212
> 	29LV800BA-90
> 
> And the markings are:
> 	Model No.:MCF-M2.1
> 	60m
> 	S/N:MCF 0001773
> 	Made in Taiwan
> 
> I've tried various conf definitions and drivers but get nothing.
> 
> weeblu:/etc/bluetooth# cardctl ident 1
>   product info: "CF CARD", "GENERIC", "", ""
>   manfid: 0x0279, 0x950b
>   function: 2 (serial)
> 
> I've tried stuff like:
> 	
> card "Noname... Compact Flash Card"
>   manfid 0x0279, 0x950b
>   bind "btuart_cs"
> and
>   bind "bt950_cs"
> 
> Also tried the bt950 driver and tried to compile the bt2000e driver
> (Since this card seems to have the Oxford Semi CS950 chip in it)

try to use serial_cs and then use hciattach with the correct parameters.

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
