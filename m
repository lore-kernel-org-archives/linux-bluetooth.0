Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Error message
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex <welpan@gmx.de>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405211928.52193.welpan@gmx.de>
References: <200405211611.38038.welpan@gmx.de>
	 <20040521172502.GA15835@gmx.net>  <200405211928.52193.welpan@gmx.de>
Content-Type: text/plain
Message-Id: <1085160826.22191.27.camel@pegasus>
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
Date: Fri, 21 May 2004 19:33:46 +0200

Hi Alex,

> May 21 19:27:02 welpix usb.agent[1928]:      hci_usb: already loaded
> May 21 19:27:02 welpix hcid[1593]: HCI dev 0 registered
> May 21 19:27:02 welpix usb.agent[1962]:      hci_usb: already loaded
> May 21 19:27:02 welpix kernel: i810_audio: drain_dac, dma timeout?
> May 21 19:27:02 welpix hcid[1593]: HCI dev 0 up
> May 21 19:27:02 welpix hcid[1593]: Starting security manager 0
> May 21 19:27:02 welpix kernel: hci_scodata_packet: hci0 SCO packet for unknown 
> connection handle 0
> May 21 19:27:12 welpix last message repeated 49999 times
> May 21 19:27:12 welpix kernel: cket: hci0 SCO packet for unknown connection 
> handle 0
> May 21 19:27:12 welpix kernel: hci_scodata_packet: hci0 SCO packet for unknown 
> connection handle 0
> May 21 19:27:13 welpix last message repeated 2290 times
> May 21 19:27:13 welpix pppd[1477]: Serial connection established.
> May 21 19:27:13 welpix kernel: hci_scodata_packet: hci0 SCO packet for unknown 
> connection handle 0

disable CONFIG_BT_HCIUSB_SCO in your kernel config and see if the error
still occurs. For me this looks like your dongle is very buggy.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
