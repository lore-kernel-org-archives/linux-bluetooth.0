Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4333EA05.7090707@cyph.ath.cx>
References: <432D6F49.80304@cyph.ath.cx>
	 <20050919092548.1173.2@@vodafone.es>
	 <1127217202.5168.36.camel@localhost.localdomain>
	 <4333EA05.7090707@cyph.ath.cx>
Content-Type: text/plain
Message-Id: <1127483592.5623.5.camel@localhost.localdomain>
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
Date: Fri, 23 Sep 2005 15:53:12 +0200

Hi,

> >if it is a ROM chip, you may need to call HCI_Reset to establish the new
> >configuration. For the hci_uart driver you can load it with "reset=1" to
> >tell the Bluetooth core to always send a reset command first.
> >  
> >
> I've looked through bluez sources for 2.6.12 and found the "reset" 
> parameter in the hci_uart driver. However, I need to use the MontaVista 
> kernel on this phone. Nevertheless I have modified hci_uart driver to 
> set the appropriate quirks flag, and verified with hcidump that it sent 
> a reset on "hciconfig up". However this still does not work.
> 
> The phone's native stack though, still works fine. Unlike bluez, it does 
> not read the the BD_ADDR from the chip, which makes sense because it 
> programs the address into the chip...

there exists no backport for the reset quirks for any 2.4 kernels.

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
