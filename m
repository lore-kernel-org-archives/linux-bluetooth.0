Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SDP queries when authentication/encryption are turned on
References: <20050223020808.14745.qmail@web52803.mail.yahoo.com> <200502231044.48821.bluez-devel@schaettgen.de> <1109241819.5645.8.camel@notepaq>
In-Reply-To: <1109241819.5645.8.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502241322.06715.bluez-devel@schaettgen.de>
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
Date: Thu, 24 Feb 2005 13:22:06 +0100

On Thursday 24 February 2005 11:43, Marcel Holtmann wrote:
> Hi Fred,
>
> > > if you set your device into security mode 3, then this is what you get.
> > > As I have often said, do this only when you know what you are doing and
> > > what does this imply.
> >
> > Marcel, why don't you simply put this often repeated sentence into a
> > comment in default hcid.conf right above auth/encrypt? If people are not
> > familiar with bluetooth, then it's reasonable to assume that you have to
> > enable this if you want any security at all. You don't expect everbody to
> > know what security mode 3 means and what the alternatives are, do you?
>
> there is a comment that this is security mode 3, but actually this does
> not prevents for its misuse and the later complaints. Problem is that
> Bluetooth is still a complex technology and if you change defaults you
> should understand what you are doing. However I always accept patches
> that extends the manual pages with more details about it.

"should understand what you are doing"? Well, obviously this is wishful 
thinking. You should really comment these settings right in the hcid.conf or 
at least referr to the manpage. Then it's nearly impossible to change these 
settings without reading the warnings about it. Not everyone will look into a 
manpage, you should be more pragmatic here. It's your time that is wasted 
with these questions after all ;)

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
