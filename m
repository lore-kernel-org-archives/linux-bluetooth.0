Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A3ACE2.4030501@xmission.com>
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <41A3ACE2.4030501@xmission.com>
Content-Type: text/plain
Message-Id: <1101246735.27351.45.camel@pegasus>
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
Date: Tue, 23 Nov 2004 22:52:15 +0100

Hi Brad,

> > I also saw that you were modifying the way a2play packs its frame though
> > that still doesn't look right to me. Maybe we should talk about our
> > interpretation of the specs in this case.
> 
> yes, exactly. Marcel got it to work by tracing the (non-spec!) traffic 
> produced by using his headset's transmitter. We don't have the luxury of 
> capturing the traffic but we should try to follow the spec as well as we 
> can.

we should follow the specification, but I also like to get my Aiptek
phone working without the sender device. So we already need the first
workaround/quirk for the not finished A2DP support ;)

The only good thing is that GCT puts in a device id SDP record with the
id value of 1310:0100 (from the USB vendor ist). I tried to look this up
at www.linux-usb.org/usb.ids if 1310 is assigned to GCT, but haven't
found anything so far.

So what we must do is read the device id SDP record (PNP Information,
service class 0x1200) and check for the product and vendor ids and if
they match set a flag to use their specific media payload header.

> > Next thing should be media payload header from A2DP which is 1 octet in
> > length and correct, too.
> > 
> > Then there should be an SBC frame as per A2DP p. 53 just like my code
> > produces them. That should start with 0x9C which I can't see anywhere in
> > the a2play output.
> 
> we just send one sbc frame then? I was assuming that but not sure.

With the GCT stuff you can break the frame at any point you like. For me
this looks like the RFCOMM stream. However my device doesn't work if the
frame size is too short, so we should put as much frames into the L2CAP
payload as the MTU allows.

>>From the other trace of the Impulsesoft stack I saw that they put 5 SBC
frames into one AVDTP media packet. They use 0x22 0x16 0x33 0x33 for the
media specific settings of the SBC, while my Aiptek headphone sets them
to 0x22 0x46 0x02 0xfa.

> Are you saying we should put 0x9c in the stream or it should be in the 
> stream already? The SBC-specific stuff is definitely where my 
> understanding ends.

No, this must come from the SBC encoder.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
