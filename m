Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001101c45c55$7803b160$0364a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <20040627125235.GA15938@gmx.net>  <001101c45c55$7803b160$0364a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088360970.3774.39.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Jun 2004 20:29:30 +0200

Hi Keihachi,

I think Nicholas answered most of your questions quite well, but I must
comment on this part.

> For example, Affix provides us these two versions software,
> the testing version and the stable version.
> http://affix.sourceforge.net/#download
> 
> I suppose such version control or management like Affix.

What you really wan't doesn't exists in the real world. Most Open Source
projects differ between stable and unstable/testing trees, but how do
you define the difference between them? The general problem is that they
think their API is not sufficient and so they are going to redesign it
and use the next major version for it. We will do actually the same, but
as long as we don't break any backward compatible there is no need to do
this.

If you wanna choose a Bluetooth stack that has a clear stable and
testing version then go with the Affix and use it. I am not going to
provide such version control, because I doesn't work out for us. What I
can give is a clear statement about what protocols (or profiles) are
stable within the complete BlueZ stack. So you should know what you need
and I can give you a more detailed answer about it.

> If a new profile is testing or has been released immediately after the development,
> probably some bugs are still included.

I don't take this point for sure, because even software declared as
stable has bugs ;)

> So we think if BlueZ is used for the commercial use, the stable version is necessary,
> because a commercial product is required to be a high quality.

Bugs are bugs. Even if I declare a BlueZ version as stable, I can't
assure that I don't overlooked something. This is the human part of
software engineering. Lets talk about details and not esoteric needs.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
