Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAND + DUND
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126266637.4171.178.camel@baythorne.infradead.org>
References: <E1EDVht-00011o-Nf@mail.sourceforge.net>
	 <1126222497.5286.78.camel@blade>
	 <1126266637.4171.178.camel@baythorne.infradead.org>
Content-Type: text/plain
Message-Id: <1126268507.5227.83.camel@blade>
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
Date: Fri, 09 Sep 2005 14:21:47 +0200

Hi David,

> > you might not wanna hear it, but the DUN profile is deprecated (even by
> > the Bluetooth SIG). However to integrate it into your bridge you need to
> > play some tricks with pppd. It is all about pppd and this is not going
> > to be very easy.
> 
> That's sad. DUN allows for compression; Unless I'm mistaken, PAN does
> not.
> 
> I keep intending to write a pppd plugin and kernel module to do
> ppp-over-rfcomm directly instead of using the tty. Haven't quite got
> round to it yet though :)

the bluez-utils package still contains ppporc, but the kernel PPP and
pppd sucks and so PPP over RFCOMM socket directly is almost impossible
without tricks.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
