Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041124034710.11f2673d.henryk@ploetzli.ch>
References: <41A22C0B.4050008@xmission.com> <41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <1101244496.27351.29.camel@pegasus>
	 <20041124034710.11f2673d.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101273877.27351.86.camel@pegasus>
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
Date: Wed, 24 Nov 2004 06:24:37 +0100

Hi Henryk,

> > so should it be and I got a trace from a friend with a prototype A2DP
> > device with a Zeevo ZV4002 and a Bluetooth stack from Impulsesoft.
> > They actually do it this way, but GCT puts in 0xff 0xff. 
> 
> Would you mind sharing theses traces with us? I'd really look at what
> other people do for this.

I actually don't know if this is possible, because it is a prototype
device. However I tried to export the trace into a text file, but my
viewer only shows the first 254 bytes of a L2CAP packet.

In what values are you interested. The AVDTP signalling channel looks
the same as we and the GCT devices do it. This device only selects other
settings for the SBC stream (0x22 0x16 0x33 0x33). Also the L2CAP MTU
for the AVDTP media channel is bigger (678 bytes) and thus it puts 5 SBC
frames into one L2CAP packet.

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
