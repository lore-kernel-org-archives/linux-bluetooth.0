Return-Path: <igorluiz@magiclink.com.br>
Subject: Re: [Bluez-users] Problem with pppd through bluetooth
From: Igor Luiz Oliveira de Souza <igorluiz@magiclink.com.br>
Reply-To: igorluiz@magiclink.com.br
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077843554.2843.19.camel@pegasus>
References: <1077831499.7219.34.camel@emerald>
	 <1077843554.2843.19.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1077878878.21031.13.camel@emerald>
Mime-Version: 1.0
Date: Fri, 27 Feb 2004 10:47:58 +0000
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Sorry about my innocence :-)))), but when you say "use the kernel RFCOMM
layer", you mean load the module "rfcomm" (or even have it built in the
kernel) ???
If so, I already have the module(rfcomm) loaded...
Se my lsmod:
-------------------------------------------------
root@emerald:~# lsmod
Module                  Size  Used by    Tainted: P
ppp_deflate             3512   0  (unused)
zlib_deflate           18520   0  [ppp_deflate]
ppp_async               7712   0  (unused)
ppp_generic            16092   0  [ppp_deflate ppp_async]
slhc                    5200   0  [ppp_generic]
hci_usb                 8088   0
sco                     9132   0  (unused)
rfcomm                 32672   0
l2cap                  16876   2  [rfcomm]
bluez                  32548   1  [hci_usb sco rfcomm l2cap]
ussp                   17152   0
uhci                   25872   0  (unused)
usbcore                62112   1  [hci_usb uhci]
8139too                15944   1
mii                     2496   0  [8139too]
crc32                   2880   0  [8139too]
nvidia               1962184   6
es1371                 27400   0
ac97_codec             13608   0  [es1371]
soundcore               3588   4  [es1371]
root@emerald:~#
-------------------------------------------------
And the problem still remains...

And if ""use the kernel RFCOMM layer"" has no meaning with I sad before,
can you tell me what it is?
Any other idea?

Best Regards!!!
-- 
Igor Luiz Oliveira de Souza
Magiclink Solucoes Internet
Analista de TI - 88657412
Salvador / BA   -  Brasil


Em Sex, 2004-02-27 às 00:59, Marcel Holtmann escreveu:
> Hi Igor,
> 
> > I'm experimenting a problem trying to connect internet via GRPS through
> > bluetooth using my Nokia 3650 and a Linux Box with a usb-dongle
> > bluetooth BT3030, via pppd.
> > 
> > The connection between the mobile and the PC via bluetooth is working
> > fine. I can transfer data in the two ways: PC->mobile , mobile->PC,
> > using the bluez driver.
> > So, now when I try to access the internet via GPRS a got this message
> > when I call "pppd"
> > 
> > root@emerald:~# rfcomm 1 xx:xx:xx:xx:xx:xx 9
> > Connected /dev/ttyU1 to xx:xx:xx:xx:xx:xx on channel 9
> > rfcomm_send_data: DLCI 18 not connected
> > rfcomm_send_data: DLCI 18 not connected
> > rfcomm_send_data: DLCI 18 not connected
> > rfcomm_send_data: DLCI 18 not connected
> 
> use the kernel RFCOMM layer.
> 
> Regards
> 
> Marcel
