Return-Path: <keihachi@swissinfo.org>
Message-ID: <002c01c45d2d$b0f3dda0$0364a8c0@haruo>
From: "KeiHachi" <keihachi@swissinfo.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <20040627125235.GA15938@gmx.net>  <001101c45c55$7803b160$0364a8c0@haruo> <1088360970.3774.39.camel@pegasus>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Date: Tue, 29 Jun 2004 01:33:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, thanks for your reply, again.
 
> I think Nicholas answered most of your questions quite well, but I must
> comment on this part.

Thank you.

> > For example, Affix provides us these two versions software,
> > the testing version and the stable version.
> > http://affix.sourceforge.net/#download
> > 
> > I suppose such version control or management like Affix.
> 
> What you really wan"t doesn"t exists in the real world. Most Open Source
> projects differ between stable and unstable/testing trees, but how do
> you define the difference between them? The general problem is that they
> think their API is not sufficient and so they are going to redesign it
> and use the next major version for it. We will do actually the same, but
> as long as we don"t break any backward compatible there is no need to do
> this.

Yes, I understand what you mean.


> If you wanna choose a Bluetooth stack that has a clear stable and
> testing version then go with the Affix and use it.

Of course I think we should also investigate about Affix as well,
but that will be done in near future.


> I am not going to provide such version control, because I doesn"t work out for us.
> What I can give is a clear statement about what protocols (or profiles) are
> stable within the complete BlueZ stack. So you should know what you need
> and I can give you a more detailed answer about it.

Thank you very much.
I understand your thought about version control.
And I also understand BlueZ codes in the kernel are always stable (as enough as I expect) .


> > > If a new profile is testing or has been released immediately after the development,
> > > probably some bugs are still included.
> > 
>  I don"t take this point for sure, because even software declared as
>  stable has bugs ;)

Yes, of course I agree what you said :-).

 
> > So we think if BlueZ is used for the commercial use, the stable version is necessary,
> > because a commercial product is required to be a high quality.
> 
> Bugs are bugs. Even if I declare a BlueZ version as stable, I can"t
> assure that I don"t overlooked something. This is the human part of
> software engineering. Lets talk about details and not esoteric needs.

I think probably my explanation is unclear, because my English is poor (I'm sorry).

What I want to say isn't such a strict high quality that means there are no bugs in it.

The stable version that I wrote before means that
modifications for new features will not be added in principle.
This means modifications for only bug fix will be allowed.
That is the stable version that I want to say.

It will give me much pleasure if my intention will be shared with you properly.
Thank you.

Regards,
KeiHachi
