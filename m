Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: digger vermont <dv_mlist@verizon.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1074697933.3020.19.camel@myrna>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
Content-Type: text/plain
Message-Id: <1074698544.7088.102.camel@pegasus>
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
Date: Wed, 21 Jan 2004 16:22:25 +0100

Hi Digger,

> Ahh, then I'm back to square one.  Before I added the configuration to
> config.opts  cardmgr was  trying to start serial_cs and I was getting
> the error:
> 
> Jan 19 16:14:50 [cardmgr] + WARNING: Error inserting 8250
> (/lib/modules/2.6.1-ben1/kernel/drivers/serial/8250.ko): Device or
> resource busy
> 
> I didn't understand it was because the internal serial ports were using
> ttyS0 and ttyS1. With the ports disabled the card is now starting. 
> 
> Should cardmgr, serial_cs.ko, or 8250.ko been able to see that the ports
> were already used?  (The powerbook uses pmaczilog.ko) If not where can
> that be configured.  Also, a config definition for the card doesn't seem
> to be needed.  Should I put one in config.opts?

I don't have any experiences with Apple machines. Ask Benjamin
Herrenschmidt about this specific problem.

> Forward to step two.
> 
> > After that you can use "hciattach <dev> socket" to init the Bluetooth
> > chip on this card.
> 
> running "hciattach /dev/tts/0 socket" I get:
> 
> BCSP initialization timed out
> 
> I built and tried a 2.4.24 kernel and the command works fine.   I would
> prefer to stay with the 2.6 kernel.  I there anything I can try? If its
> of any help there's lofiles, etc below.

My Com1 card uses also BCSP and I will try it later with 2.6.2-rc1.
Please check again with this kernel, too.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
