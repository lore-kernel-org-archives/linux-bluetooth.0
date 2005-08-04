Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DUN lookup on Samsung D500 raises SIGSEGV
In-Reply-To: <1123094146.8331.30.camel@pegasus>
Message-ID: <Pine.LNX.4.33.0508041007340.7461-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 4 Aug 2005 10:11:35 +0200 (CEST)


Hi Marcel,

I didn't check the SDP record.....

BTW (now for something completly different) : we had some trouble with our
PCI driver. Can you tell me when you introduced hci_alloc_dev () ??? This
is just for backward compatibility for the modified driver.

Thank you,

Peter


On Wed, 3 Aug 2005, Marcel Holtmann wrote:

> Hi Peter,
>
> > without realy knowing the internals this looks to me like BlueZ does not
> > support 32 Bit UUIDS. It is a little bit unusual to use 32 Bit UUIDs but
> > legal. So BlueZ SDP Parser shall support them.
>
> this should have been fixed in the latest version. However the problem
> is not the 32-bit UUIDs. The SDP record itself is wrong.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
