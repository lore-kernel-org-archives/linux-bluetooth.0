Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d8640503240501491f765e@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Serial(HCI-UART) Bluetooth Module - Initialization timeout error
In-Reply-To: <1111666515.1916.62.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f54d8640503240350250aae5e@mail.gmail.com>
	 <1111666515.1916.62.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Mar 2005 18:31:14 +0530

Thanks Marcel for your reply. Yes we doing the same exercise debugging
step by step using the hciattach source. Yes we have chosen the
required configurations mentioned.

We are designing a Bluetooth remote device using a custom hardware
interfaced to a standard Bluetooth module(headset+SPP). We are
targeting this product for PC market.

So we have to suggest our customer a set of USB Bluetooth dongles
which supports Bluez on the Linux PC. We are finding that the CSR
based BT USB dongle is working fine under linux rather than the
SiliconWave based BT USB dongle. I may be wrong in this regard, I
might have missed some settings.

We have tried the following BT USB dongles:
i) unknown make(CSR)  - Woking fine for Audio and data transfer.
ii) Orchid (Silicon wave) - Not working for Audio but recieving data.
iii) ANYCOM USB Adapter 240 (Silicon Wave) - Not working for Audio as
well as data.

We are using linux kernel 2.6.9-1.667(Fedora Core 3) and using the
latest CVS BT-SCO drivers.

Please advice.

Thanks & Regards,
Benny




On Thu, 24 Mar 2005 13:15:15 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Benny,
> 
> > We are now working with a RFMD Silicon wave based serial(hci-uart)
> > bluetooth module.  We are trying to test for its working under linux
> > 2.6.  We have installed the Bluetooth stack (bluetooth.o) module and
> > the HCI Uart (hci_uart.ko ) module.
> > We have tested for the working under windows.
> >
> > When we try to do hciattach the device with Serial port using the
> > following command.
> >
> >              hciattach  /dev/ttyS0 swave 115200 flow
> >
> > we are getting the INITIALIAZATION TIME OUT error. And it is the same
> > result with the following commands also:
> >
> >              hciattach ttyS0 swave 115200 flow
> >              hciattach  -s 115200 ttyS0  swave 115200 flow
> >              hciattach /dev/ttyS0 swave 115200
> >
> > Has anyone faced this problem before. Any pointers? Please advice.
> 
> Silicon Wave or now RFMD never send me a development kit to improve the
> support for it. I only have Silicon Wave based USB dongles and most
> people I know uses the USB interface to attach a Bluetooth module with
> this chip.
> 
> Look at the hciattach source code and see where this error occurs. Check
> your kernel config and make sure that H4 is really configured:
> 
>         CONFIG_BT_HCIUART=m
>         CONFIG_BT_HCIUART_H4=y
> 
> Regards
> 
> Marcel


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
