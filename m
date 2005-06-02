Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: UART based bluetooth dongle
In-Reply-To: <429EF8F9.60002@certi.org.br>
Message-ID: <Pine.LNX.4.33.0506021325400.2153-100000@redbean.intranet.gw-instruments.de>
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
Date: Thu, 2 Jun 2005 13:28:40 +0200 (CEST)


Hi Gabriel,

why don't you use a serial BT dongle with integrated RFC Stack.
Implementing RFC in Java won't be trivial, I think. And it would also be
very slow.

(BTW: not the appropriate mailing list....)

Ciao,

Peter

On Thu, 2 Jun 2005, Gabriel Marques wrote:

> I'm using Brainboxes' BL642, wich works fine with bluez.
> It provides only the HCI layer (H4), so the rest can be implemented as
> you wish.
> I've bought it at Emulation Technology for U$263,00, its expensive, but
> I needed it for a special purpose.
> The contact was corey@emulation.com.
>
> One more thing, does anyone heard about an RFCOMM imlementation in Java?
> I'm developping some apps. for transferring files from a Set-top-box to
> a cell phone.
> The STB runs JavaTV, with no BT stack implementation (no BT hardware
> too), but I'm managing to attach the serial BT dongle to it and run the
> JavaBluetooth (javabluetooth.org) stack over it. Currently I'm runing
> the JavaBT on a PC, but the RFCOMM and other high-level layers were not
> implemented on this stack, but as it supports L2CAP I just need one more
> layer :)
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
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
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
