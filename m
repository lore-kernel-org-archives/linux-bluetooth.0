Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BLueZ Questions
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <423811DA.10403@carmedialab.de>
References: <4237F516.2040804@carmedialab.de>
	 <1110965751.9818.87.camel@pegasus>  <42380154.3080005@carmedialab.de>
	 <1110967438.9818.110.camel@pegasus>  <423811DA.10403@carmedialab.de>
Content-Type: text/plain
Message-Id: <1110971274.9818.124.camel@pegasus>
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
Date: Wed, 16 Mar 2005 12:07:54 +0100

Hi Marcus,

> > make sure that you adding my latest -mh patch for that kernel.
> for Kernel 2.4.19 I do (patch-2.4.19-mh18).

this is good, but the kernel is still behind the current state of the
latest 2.6 kernel. See my comments about that in the mailing list
archive.

> >>Profiles looking for:
> >>Serial Profile (through rfcomm ?)
> > 
> > 
> > To what should this be connected? The GPS or the GSM/GPRS unit?
> What ever is possible.
> -GPS for using a PDA(bt) to get positioning informations to spare a 
> separate GPS Module.
> -A terminal to connect to from a PC
> -Maybe using GSM/GPRS as Dial up connection.

Both is possible, but I think you need to write a little program that
listens on a specific RFCOMM channel and then forwards the data from and
to the specific serial ports. This program should also take care of
creating the needed SDP records.

Such a program doesn't really exists, but it is quite easy to do one
based on the current examples.

> >>Handsfree (for using a external mobile phone)
> > 
> > 
> > Are the SCO audio data sent over the PCM interface of the chip?
> In the first Hardware release there's no Audio codec but ther will be 
> one in the second. I'm not sure how it will be implemented. In the 
> moment the PCM interface is connected to a synchronus serial interface 
> on the tc1130. I'll think we got to diskuss this internally more deeply 
> to clarify the needs and usage.

If you have a PCM on your board, then you should simply connect it to
the PCM on the Bluetooth module.

> >>Fileexchange (through openobex)
> > 
> > 
> > Depending on what you wanna do you may need do write some extra code,
> > but there are a lot of examples. 
> I thought it's done through the openobex package. I suppose I can find 
> example on the openobex project site.

It is, but OpenOBEX is only an implementation of the OBEX protocol. You
still need an application that is doing the correct things.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
