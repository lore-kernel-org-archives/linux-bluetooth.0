Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP queries when authentication/encryption are
	turned on
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200502241322.06715.bluez-devel@schaettgen.de>
References: <20050223020808.14745.qmail@web52803.mail.yahoo.com>
	 <200502231044.48821.bluez-devel@schaettgen.de>
	 <1109241819.5645.8.camel@notepaq>
	 <200502241322.06715.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1109579295.17256.24.camel@pegasus>
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
Date: Mon, 28 Feb 2005 09:28:15 +0100

Hi Fred,

> > > > if you set your device into security mode 3, then this is what you get.
> > > > As I have often said, do this only when you know what you are doing and
> > > > what does this imply.
> > >
> > > Marcel, why don't you simply put this often repeated sentence into a
> > > comment in default hcid.conf right above auth/encrypt? If people are not
> > > familiar with bluetooth, then it's reasonable to assume that you have to
> > > enable this if you want any security at all. You don't expect everbody to
> > > know what security mode 3 means and what the alternatives are, do you?
> >
> > there is a comment that this is security mode 3, but actually this does
> > not prevents for its misuse and the later complaints. Problem is that
> > Bluetooth is still a complex technology and if you change defaults you
> > should understand what you are doing. However I always accept patches
> > that extends the manual pages with more details about it.
> 
> "should understand what you are doing"? Well, obviously this is wishful 
> thinking. You should really comment these settings right in the hcid.conf or 
> at least referr to the manpage. Then it's nearly impossible to change these 
> settings without reading the warnings about it. Not everyone will look into a 
> manpage, you should be more pragmatic here. It's your time that is wasted 
> with these questions after all ;)

even if I put a big explanation into the config file, people still will
do it wrong. Actually I think of removing some commands from the example
config file and only mentions their existens in the manual page or in
the source code.

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
