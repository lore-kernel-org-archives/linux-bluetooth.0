Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Mailing list gateway corrupting messages (was:
	L2CAP connectionless)
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   "Desai, Keyur Rajnikant" <kdesai@mail.smu.edu>
In-Reply-To: <403237AF.5030501@csr.com>
References: <38F76B90B82C0A4A822651EACE4FF8E9C23322@s31xs2>
	 <403237AF.5030501@csr.com>
Content-Type: text/plain
Message-Id: <1077037010.2665.64.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 17 Feb 2004 17:56:50 +0100

Hi Steven,

> We're getting messages from Keyur Desai blocked by our corporate
> filters. One such message was titled "L2CAP connectionless" and was
> sent on 16th of February. A direct link is:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=3903638&forum_id=1883
> 
> I've also appended an edited version to the end of this message.
> 
> The problem appears to be that the original mail message was sent in
> MIME Base64 encoding (no problem there - it's completely legal), however,
> the mailing list gateway is appending text to the end (the usual SF.net
> advert and mailing list info). Since the text is appended to the end of
> a Base64 section, mail clients are intepreting it as Base64 encoded data.
> Since the data has not been Base64 encoded this results in the message
> appearing to contain lots of garbage characters. This is what trips up
> our corporate filters.
> 
> Netscape and Outlook both show a lot of garbage characters at the end
> of the message. More tellingly, Sourceforge's own web list interface
> (the link I gave above) also shows some garbage characters (though it
> gives up after three).
> 
> A colleague also reports a similar problem with MIME quoted-printable
> messages. The Sourceforge appended text also contains equals signs.
> This trips up quoted-printable decoders (most clients just show a few
> incorrect characters - breaking the advertising link, however, mh
> spots the illegal quoting and refuses to display the entire message).
> 
> This is a known bug in Mailman 2.0 (tracker ID 617930). It was reported
> in October 2002 and is fixed in mailman 2.1:
> 
> https://sourceforge.net/tracker/?func=detail&atid=100103&aid=617930&group_id=103
> 
> Apparently, judging by the X-Mailman-Version headers in the mailing
> list messages, we're still using Mailman 2.0 (2.0.9-sf.net).
> 
> Is there any way to change this? Sourceforge's issues list at:
> 
> http://sourceforge.net/docman/display_doc.php?docid=17790&group_id=1
> 
> says:
> 
>   Software Upgrades
> 
>     [...]
> 
>     Mailing list services will be upgraded, though the exact time frame has
>     not yet been determined. This upgrade will include Mailman upgrades and
>     additional anti-spam mechanisms (we know what needs to be done, but have
>     not yet scheduled the resources to perform the implementation).
> 
> Is there a known workaround? I've tried to search Sourceforge's support
> requests, but it's not being very helpful.

I don't know of any technical workaround. My workaround is that people
should start using mail clients that are not messing up the emails. The
prefered format for posts to a mailing list is still 7-bit ASCII. No
multipart HTML or other fancy stuff. Personally I tend to ignore mails
that I can't read or that my mail client can't display.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
