Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061206164914.6718738c.ml133@netpole.com.br>
References: <20061206111617.d8f16a0c.ml133@netpole.com.br>
	<1165412385.2756.52.camel@localhost>
	<20061206131754.39cddee0.ml133@netpole.com.br>
	<1165418898.2756.84.camel@localhost>
	<20061206164914.6718738c.ml133@netpole.com.br>
Date: Fri, 08 Dec 2006 11:16:45 +0100
Message-Id: <1165573006.5529.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] suggestion for device control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> > > Hm. With raw, you do mean:
> > > 
> > >   socket (AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > > 
> > > right? or is there something else I need to set to raw?
> > 
> > that is not enough. You have to set the device into raw mode. Not only
> > open the raw socket. Check the source code for examples.
> 
> Right. Forgot to mention
> 
> 	ioctl (sd, HCISETRAW, 1);
> 
> This was already in my code which noticed kernel interference. And
> I've set all bits for events and packet types (if that matters
> regarding raw mode) when calling setsockopt with a filter. I'm looking
> at hcidump.c and can't see anything else which might be related to
> setting a device into raw mode. Should I see some other source?  What
> else do I need?

this should work. However I never tried to emulate everything by myself
and maybe at some point we broke the raw mode. Check with a 2.6.19
kernel and post the "hcidump -X -V" from your tests. Include any code
that is needed to reproduce what you see.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
