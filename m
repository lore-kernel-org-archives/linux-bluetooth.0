Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050919092548.1173.2@@vodafone.es>
References: <432D6F49.80304@cyph.ath.cx>
	 <20050919092548.1173.2@@vodafone.es>
Content-Type: text/plain
Message-Id: <1127217202.5168.36.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Tue, 20 Sep 2005 13:53:22 +0200

Hi guys,

> > Is this a sign that the chip is somehow configured wrongly?
> 
> Looks like, but I fear its too late for the the device. Would help a lot if 
> it can take again a valid BD_ADDR. The HCI_USB driver behaves different for 
> this device it casts a reset hci command on it, before the intialitation 
> commands. May there is a point to look at but you are talking over UART...

if it is a ROM chip, you may need to call HCI_Reset to establish the new
configuration. For the hci_uart driver you can load it with "reset=1" to
tell the Bluetooth core to always send a reset command first.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
