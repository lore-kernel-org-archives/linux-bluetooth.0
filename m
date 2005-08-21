Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reset card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <430606F9.3060906@hasborg.com>
References: <43038D0B.1060209@hasborg.com>
	 <20050819092419.715FE479@arbetsmyra.dyndns.org>
	 <4305A63E.7020507@soft.uni-linz.ac.at> <1124462989.6398.8.camel@notepaq>
	 <430606F9.3060906@hasborg.com>
Content-Type: text/plain
Message-Id: <1124632986.6260.9.camel@notepaq>
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
Date: Sun, 21 Aug 2005 16:03:06 +0200

Hi Joshua,

> > feel free to send me a patch for the bccmd tool that I can include 
> > into the bluez-utils distribution.
> 
> Thanks to all who replied.  Simon's code was exactly what was needed,
> and the CSR BCCMD documentation was very helpful.
> 
> Attached is a patch to automatically reset CSR cards after changing the
> BD_ADDR with the bdaddr utility.

I modified it a little bit to make it more generic, but it is in the CVS
now. Feel free to test it. Do I get also a patch for bccmd for a reset
command and a patch for decoding this command in hcidump?

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
