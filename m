Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050424164810.GA12143@externe.net>
References: <1114345112.10706.64.camel@pegasus>
	 <20050424134746.GA31151@externe.net>
	 <20050424181947.4a2f1656.henryk@ploetzli.ch>
	 <20050424164810.GA12143@externe.net>
Content-Type: text/plain
Message-Id: <1114366503.10706.123.camel@pegasus>
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
Date: Sun, 24 Apr 2005 20:15:03 +0200

Hi Guylhem,

> > My 0.02EUR: There is a problem here. Mayank turned up a very valid point
> > in his "a2play code not according to the specifications" posting: Having
> > the SBC encoding decoupled from the AVDTP negotiation is not a good
> > thing. One of the primary problems of the current pipe approach (and
> > expecting applications to stream SBC into a socket/device/whatever is
> > not different in this regard) is that the format of the SBC stream
> > (sample rate, channel mode, etc.) will have to depend on the
> > capabilities of the receiver, but there is no feedback to the encoder
> > about that.
> 
> Maybe the supported encodings/frequencies/etc. could be advertised in
> a separate file? The player would open it first, then send the sbc
> in one of the supported format

the advertised endpoints, encodings etc. can change dynamically and so
you would always need a L2CAP link on PSM 25 first. So this can't be an
option.

> > And also coupling /dev/a2dpN tightly to SBC format would make it even
> > harder (or impossible) to support other audio formats as A2DP does.
> 
> That was just a suggestion on the system behaviour - I mean having a
> device supporting a format. You could as well have
> /dev/a2dp0_sbc_someformat /dev/a2dp0_sbc_someotherformat etc. and try
> to open them until once doesn't return an error.

This is an ugly interface and won't even work. Do you wanna create a
connection to the headphone for every device node that you are testing?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
