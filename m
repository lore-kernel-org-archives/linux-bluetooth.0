Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Elimination of pow() in SBC code
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041128025750.00e11da4.henryk@ploetzli.ch>
References: <1101599506.18467.6.camel@pegasus>
	 <20041128025750.00e11da4.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101644100.18467.47.camel@pegasus>
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
Date: Sun, 28 Nov 2004 13:15:00 +0100

Hi Henryk,

> > the pow() function is the only reason for linking with -lm and it is
> > only used in one place with a limit range of parameters.
> 
> Oh yes, that occurence of pow(2.0, x) is in older code I forgot about.
> (And before -lm was necessary for cos(), too)
> 
> > So what is the range of scale_factor[ch][sb]. From a quick testing a
> > saw that it ranges from 0 - 15. Is this always true? 
> 
> Yes, scale_factor is a 4 bit integer (Table 12.13 of A2DP) and there
> should be no way of getting it bigger. If there was this would be a bug.
> 
> > If yes, then I would use a pre-calculated array for 2^x.
> 
> Isn't 1<<x good enough for that?

stupid me. Of course power of two is done by bitshifting. I committed
the following to the CVS:

	2 << frame->scale_factor[ch][sb]

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
