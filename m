Return-Path: <cyrus@holtmann.org>
Message-ID: <1425919980.1421.18.camel@hadess.net>
Subject: Re: [RFC 2/2] profiles/input: Add support for SDP fallback for
 DualShock 3 clones
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Antonio Ospite <ao2@ao2.it>, Szymon Janc <szymon.janc@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Veseli Veseljko <veseljko75@gmail.com>
Date: Mon, 09 Mar 2015 17:53:00 +0100
In-Reply-To: <1644418.QPL4BBNlRG@uw000953>
References: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
	 <1425830910-9549-3-git-send-email-szymon.janc@gmail.com>
	 <20150309122108.1dac140bf6ecff692e3ca165@ao2.it>
	 <1644418.QPL4BBNlRG@uw000953>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2015-03-09 at 14:37 +0100, Szymon Janc wrote:
> Hi Antonio,
> 
> On Monday 09 of March 2015 12:21:08 Antonio Ospite wrote:
> > On Sun,  8 Mar 2015 17:08:30 +0100
> > Szymon Janc <szymon.janc@gmail.com> wrote:
> > 
> > > Some DualShock 3 clones were reported to not provide any SDP 
> > > record. In such case provide fallback SDP record (based on 
> > > genuine DS3 record) and retry setting input device channels 
> > > before disconnecting.
> > 
> > Hi Szymon,
> > 
> > I guess this can't be done in the sixaxis plugin, right?
> 
> Unfortunately not. There would have to be some sort of callbacks 
> from input
> to handle this from plugin. But if you come up with some nice 
> solution I'd
> review it gladly :)
> 
> Maybe we could modify code to always provide those on USB plug and 
> then never do
> reverse SDP when sixaxis device is detected... I'd have to think 
> about that :)

That's what the original version of the sixaxis patch for BlueZ (the 
one that shipped only in Fedora for a long while) did.

When you create the BlueZ device setup by plugging in the pad, shove 
the SDP record in the local cache as well.

In the worst case, people will need to remove the device from the 
Bluetooth settings, and plug it back in via USB.
