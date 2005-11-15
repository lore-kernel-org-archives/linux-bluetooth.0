Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_[Bluez-devel]_uart_driver?=
In-Reply-To: <OFFBED3F2B.F3FBB1C9-ONC12570BA.00595759-C12570BA.005ABF75@sagem.com>
Message-ID: <Pine.LNX.4.33.0511151810490.4802-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 15 Nov 2005 18:24:20 +0100 (CET)


Hi Mattieu,

On Tue, 15 Nov 2005, Matthieu CASTET wrote:
> I look in your pci driver, and is more or less what I did except that I
> still use hci_h4 module.
>
> What I don't like with these scheme is that all PCI/PCMCIA/USB driver
> duplicate some generic uart bluetooth code.
Well, its mostly in the ISR and this should be fast. So code duplication
is the most effective way here, even if it is not very nice.

> What I wanted is to have a generic uart driver that know nothing about hci
> and bluetooth, and then use hci_ldisc.c for the bluetooth part.
Well, this is how the standard HCI UART driver works !!??

> Is the fact to use the tty layer between uart driver and bluetooth uart
> module is too complex and have a high overhead ?
>
> If tty is too complex, why not doing a generic uart bluetooth driver with
> simple inferface : send_packet/receive/init/close/... ?
The current driver interface isn't much more than that. I think it's
fairly simple. It has open/close/ send frame/ flush / destruct and
ioctl (the last two are usualy empty). Than it gots an ISR for receive
which delivers the packets to the higher layer. All other code is more or
less hardware specific. I don't see a good chance to make it much simpler.

Ciao,

Peter

>
> Matthieu
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
