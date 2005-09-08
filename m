Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAND + DUND
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <E1EDVht-00011o-Nf@mail.sourceforge.net>
References: <E1EDVht-00011o-Nf@mail.sourceforge.net>
Content-Type: text/plain
Message-Id: <1126222497.5286.78.camel@blade>
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
Date: Fri, 09 Sep 2005 01:34:57 +0200

Hi Gavin,

no cross posting !!!

> I am trying to build an access point that supports both PAN and LAP
> profiles. I was able to follow the instructions to create a PAND
> access point using the Ethernet bridge technique
> (http://bluez.sourceforge.net/contrib/HOWTO-PAN). I have searched all
> around the web for instructions for incorporating DUND into this
> configuration, and the best I have found is an out of date article
> from Ling-Jyh Chen
> (http://www.cs.ucla.edu/~cclljj/interest/notes/bluez/pand_dund.html).
> Are there any instructions for configuring the recent versions of
> Bluez to support multiple Bluetooth devices using PAN and / or LAP?
> Any assistance would be appreciated.

you might not wanna hear it, but the DUN profile is deprecated (even by
the Bluetooth SIG). However to integrate it into your bridge you need to
play some tricks with pppd. It is all about pppd and this is not going
to be very easy.

> PS: I have been really impressed with the depth in the current
> implementation of BlueZ and have managed to construct some interesting
> software. As a developer, I find the lack of the formal documentation
> describing the uses of the BlueZ utilities and the API available in
> the BlueZ libraries a real issue. If the BlueZ implementation is to
> become universally accepted by the development community, the BlueZ
> community will need to work on this issue.

Since this is open source, feel free to do something about it. Write
documentation. I invite everybody to construct a good manual.

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
