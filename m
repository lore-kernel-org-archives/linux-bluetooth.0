Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
Message-ID: <20050306193724.GA17819@adamis.de>
References: <20050226031901.GL11723@adamis.de> <1109578431.17256.9.camel@pegasus> <20050228220209.GA8151@adamis.de> <1109665776.17256.122.camel@pegasus> <42294598.6010004@adamis.de> <1110021859.8058.111.camel@pegasus> <20050305141858.GA21208@adamis.de> <1110046671.18555.3.camel@pegasus> <20050305192539.GA26285@adamis.de> <1110052537.8302.2.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110052537.8302.2.camel@pegasus>
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
Date: Sun, 6 Mar 2005 20:37:24 +0100

Hi Marcel,

On 05.03.05 20:55:37, Marcel Holtmann wrote:
> I get these extra log messages with your patch and the Xircom card:
> 
> ttyS2: autoconf (0x03e8, 0x00000000): iir=3 iir1=6 iir2=6 Xscale type=XScale
> ttyS2 at I/O 0x3e8 (irq = 20) is a XScale
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=9600 quot=12
> ***** Serial: baud=115200 quot=1
> 
> Don't ask why the type is now Xscale. It seems it is Xscale for every
                            ^^^ was it different without my patch?
			    Shouldn't be...
> serial port in my system and it is a normal P4 system.

What kernel version did you patch? What does dmesg show when calling
hciattach (should be some ***** Serial messages)?
Does the card work with a 2.4 kernel (e.g. 2.4.29)?

> > > For the Socket card the baud rate is 230400 and yes, this is to slow for
> > > the full bandwith of a piconet. However I never did any bandwith test
> > > with this card, but actually there are cards out there where the UART
> > > limits the total possible bandwidth.
> > 
> > Huh - but at least it's still a lot faster than a GPRS connection so it's
> > okay for me...
> 
> If you have another system with an USB Bluetooth dongle, you can simply
> check what's the max piconet bandwidth. Use a PAN connection or test it
> with the l2test or rctest program.

I didn't find l2test nor rctest but I tried some OBEX file transfers and
only got around 25-30 KiByte/s, the same with Windows so it seems the
card really is limited to 230400 baud...
Btw, do you know another cf card without external antenna?

Regards,
Mathias


-- 
There are only 10 types of people in this world:
those who understand binary, and those who don't.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
