Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hp bluetooth headset a2dp
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050325002021.85942.qmail@web52801.mail.yahoo.com>
References: <20050325002021.85942.qmail@web52801.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1111710700.9195.37.camel@pegasus>
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
Date: Fri, 25 Mar 2005 01:31:40 +0100

Hi Shawn,

> > > I also have the Aiptek and Bluetake ones.  I just noticed that so
> > much
> > > activity with A2DP has been happening while I was not paying
> > attention,
> > > so I will try to do some testing.
> > 
> > The Aiptek is not conforming to the specification. However the SBC
> > over
> > RFCOMM is a nice feature.
> 
> Is SBC over RFCOMM the only method they support?  Or is their "not
> conforming" just in small points?

the SBC over RFCOMM is additional.

> I noticed that they don't work with either our phone or the BlueSoleil
> but wasn't sure why.  And they do say in the manual that they support
> A2DP, and explain how to bond them, enter pin "0000" etc.  I emailed
> tech support but haven't got a response yet.
> 
> Too bad - IMO those are the only ones so far that are actually
> comfortable.  The iPAQ ones aren't too bad either.

You will find almost every information about that in the mailing list
archive. However the problem with the Aiptek is that it conforms to
AVDTP, but then it does not conform to A2DP when it comes to sending the
actual SBC stream.

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
