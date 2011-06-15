Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 15:13:44 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Per-project patch prefixes
Message-ID: <20110615181344.GB23248@joana>
References: <20110614211507.GB27437@piper>
 <20110614213143.GD2613@joana>
 <1308136231.2518.5.camel@aeonflux>
 <20110615120443.GA11463@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110615120443.GA11463@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Johan Hedberg <johan.hedberg@gmail.com> [2011-06-15 15:04:43 +0300]:

> Hi,
> 
> On Wed, Jun 15, 2011, Marcel Holtmann wrote:
> > > > Now, this list receives patches for at least 3 different projects, so how
> > > > about using different subject prefixes for each priject? The first thing
> > > > that comes to mind is this:
> > > 
> > > This is a great idea. It can a lot when identifying patches, and you can do
> > > this to the project's .git/config:
> > > 
> > > [format]
> > >         subjectprefix = "bluetooth-next"
> > 
> > as long as patches come in as [PATCH bluetooth-next v2] or something
> > similar I am fine with this. I want the [PATCH ...] prefix kept alive
> > since that is one thing that git did right from the beginning.
> 
> The mandatory part then becomes "[PATCH bluetooth-next] Bluetooth: ".
> That doesn't leave much to the really valuable part, especially if
> you're on a 80-column wide terminal. Add Subject: to the beginning and
> you've got even less. Kernel patches already have the Bluetooth: prefix
> in the subject so they are pretty easy to spot IMHO. For obexd OTOH I'd
> be fine with a [PATCH obexd] convention.

So no modifications for the kernel patches. "Bluetooth:" prefix is enough to
me as well.

	Gustavo
