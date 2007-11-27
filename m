Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196103584.10878.490.camel@cookie.hadess.net>
References: <47477234.9010007@free.fr>
	<1195956126.10878.444.camel@cookie.hadess.net>
	<1196057724.4217.71.camel@aeonflux>
	<1196098681.10878.486.camel@cookie.hadess.net>
	<1196103584.10878.490.camel@cookie.hadess.net>
Date: Tue, 27 Nov 2007 09:32:48 +0100
Message-Id: <1196152368.17196.23.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > sixpair2.c has a couple of bugs:
> > - country is wrong
> 
> Doesn't matter.
> 
> > - version is wrong
> 
> That was my mistake.
> 
> > - report is missing 4 bytes
> 
> Doesn't seem to matter. I think it might be hidd being broken...

can you extract the full HID report descriptor from SDP and simply put
it statically into the code? I think that makes it easier.

> Attaching a new version of sixpair2.c that seems to work:
> sudo ./sixpair2 --store-info <local bdaddr>
> 
> It needs to be compiled from the input/ subdir of bluez-utils, using the
> command-line at the top of the file.

I would like to include this one into the CVS. Can you get me a version
without GLib stuff? It is not really needed as I can tell. You only use
it for option parsing.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
