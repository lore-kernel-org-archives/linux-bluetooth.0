Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zaurus SL6000 & Socket CF
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050303114811.18169.qmail@web40609.mail.yahoo.com>
References: <20050303114811.18169.qmail@web40609.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109851134.29482.100.camel@justakiss>
Mime-Version: 1.0
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
Date: Thu, 03 Mar 2005 12:58:54 +0100

Am Don, den 03.03.2005 schrieb Paolino paperino um 12:48:
> --- Erwin Authried <eauth@softsys.co.at> wrote:
> > Am Don, den 03.03.2005 schrieb Paolino paperino um
> > 12:07:
> > > Hi!
> > > I've installed on my Zaurus this ipk from Bluez
> > site:
> > > bluez-libs_2.8
> > > bluez-hcidump 1.9
> > > bluez-utils 2.8
> > > bluez-kernel-2.4.18-mh14
> > > 
> > > I've loaded the modules by hand with insmod
> > > hci_uart
> > > bluez
> > > l2cap
> > > 
> > > now i must  attach to the serial device:
> > > hciattach /dev/ttySX socket
> > > As X i tried 0 and 1 and this get me this error:
> > "BCSP
> > > initialization timeout".
> > > 
> > > If as X i use 2, 3 i get "Can't open serial port:
> > No
> > > such device"
> > > 
> > > without hciattaching i can't use Bluez, anybody
> > could
> > > hilight me?
> > > Thannk's
> > > Best regards 
> > >  Andrea S.
> > have you loaded serial_cs first? The kernel will
> > report the tty that is
> > used for the CF card.
> > 
> > Regards,
> > Erwin
> 
> No but, my zaurus has got it insmod serial_cs fails to
> find the module...where can i get it?
> 
> Andrea S.
> 
you have to enable standard (8250/16550) serial support as well as
pcmcia serial support in the kernel. The module will be placed into
modules/pcmcia.

Regards,
Erwin




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
