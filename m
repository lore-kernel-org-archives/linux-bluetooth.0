Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-users] CF cards
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086300734.4424.6.camel@pegasus>
References: <1086292123.4353.27.camel@m117a.studby.ntnu.no>
	 <1086300734.4424.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1086339872.4342.7.camel@m117a.studby.ntnu.no>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 11:04:32 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Ok, thanks for the prompt response.

I think what I'll do is get the Socket card and just stick with the 2.4
kernel for now. Maybe I can even help track down the problem with 2.6;
I'm quite comfortable recompiling kernels/modules and digging into
source code. I have no experience with kernel hacking though, and no
experience with BlueZ internals, so any pointers or further thoughts on
where the problem might lie would be helpful.

Jon

On Fri, 2004-06-04 at 00:12, Marcel Holtmann wrote:
> Hi Jon,
> 
> > I'm in the market for a CF card for my laptop (Thinkpad X30, built-in CF
> > slot), and after checking the hardware support list on bluez.org I had
> > decided on the Socket card, since that was one of the few I could find
> > in my country.
> > 
> > But in the archives of this list I stumbled across a few mentions of
> > that card not working with the 2.6 kernel. Is this still true? Has there
> > been any progress on solving that problem?
> > 
> > Alternately, is there any chance the Billionton (CFBT02) or Dell
> > (Truemobile 300) cards are supported or will be supported in the near
> > future?
> 
> actually the Socket card 2.5 is an excellent choise, because of their
> size and its CSR based Bluetooth chip. But as you already read in the
> archives there are some problems. With 2.6 some serial cards work and
> some don't. I guess that this is a problem in the new serial layer of
> 2.6. So choosing the right card will be a non-trivial problem, because
> most of them are serial based and you can't be sure that they work until
> you tested them. If you don't care what Bluetooth chip is used I suppose
> that you go with the Anycom CF card (bluecard_cs driver).
> 
> Regards
> 
> Marcel
> 
> 
