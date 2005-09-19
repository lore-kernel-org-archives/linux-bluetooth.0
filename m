Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Oliver <urnenfel@tiscali.es>
In-Reply-To: <432D6F49.80304@cyph.ath.cx>
Message-Id: <20050919092548.1173.2@@vodafone.es>
Mime-Version: 1.0
References: <432D6F49.80304@cyph.ath.cx>
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain;
 charset="iso-8859-1"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 19 Sep 2005 09:25:48 +0000

Ho,

> However, the problem comes when BlueZ requests the Bluetooth address 
> back from the chip: it will reply with 00:00:00:00:00:00. Seems like its 
> not a problem unheard of: 
> http://www.linuxquestions.org/questions/history/341892
> l2ping and hcitool scan works despite BlueZ not knowing the correct 
> local address.

It is not a BlueZ problem but a device itself, with the BlueZ stack the 
chip uses to forget its BD_ADDR.

> Will this cause any problems BlueZ functionality or other applications?

AFAIK for example another devices could not connect to it, moreover the 
fact that a device identifies itself as 00:00:00:00:00:00.

> Is this a sign that the chip is somehow configured wrongly?

Looks like, but I fear its too late for the the device. Would help a lot if 
it can take again a valid BD_ADDR. The HCI_USB driver behaves different for 
this device it casts a reset hci command on it, before the intialitation 
commands. May there is a point to look at but you are talking over UART...

> Is this a common problem for this chip?

I had this problem, I could not make it get its previous BD_ADDR

thanks,

		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
