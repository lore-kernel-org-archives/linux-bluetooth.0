Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 2.6.6-mh2 freeze
References: <200405271934.52883.cijoml@volny.cz> <1085686044.8896.43.camel@pegasus>
In-Reply-To: <1085686044.8896.43.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405272139.08194.cijoml@volny.cz>
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
Date: Thu, 27 May 2004 21:39:08 +0200

On Thursday 27 of May 2004 21:27, you wrote:
> Hi Michal,
>
> > I tried to use latest -mh patch, but my computer freezes when pcmcia
> > services wants to start.
> > No oops, clear freeze
> >
> > Here is output from 2.4.26:
> > Yenta ISA IRQ mask 0x0030, PCI irq 10
> > Socket status: 30000010
> > Yenta ISA IRQ mask 0x0030, PCI irq 10
> > Socket status: 30000006
> >
> >
> > 0000:02:04.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> > Controller (rev 01)
> > 0000:02:04.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> > Controller (rev 01)
>
> this can't be my fault, because I've only touched the Bluetooth
> subsystem with the -mh patch.

Hmm...but I installed only -mh2 and with -mh1 or clean 2.6.6 works

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
