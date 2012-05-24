Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 17:12:41 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Denis Kenzior <denkenz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PROPOSAL bluetoothd/obexd] doc/features.txt and doc/TODO
Message-ID: <20120524201241.GA14906@joana>
References: <CAMOw1v7BR1H9iAROyufdccyJS+WNLMFfRyxgJxt0iQ9SPP0Z-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMOw1v7BR1H9iAROyufdccyJS+WNLMFfRyxgJxt0iQ9SPP0Z-Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Lucas De Marchi <lucas.demarchi@profusion.mobi> [2012-05-24 16:44:47 -0300]:

> Hey,
> 
> Some times (mainly when I'm preparing presentations about BlueZ) I
> have to dig the source code and commit log to check which version and
> features of each protocol is supported in BlueZ. I think this is a
> common pattern for other BlueZ developers as well. It matters even
> more when we are proposing implementations of new features (and then
> we realize it's already implemented) or when we are trying to cover a
> use case that depends on a feature not done yet.
> 
> I propose to follow what oFono does, by maintaining a
> doc/features.txt and a doc/TODO  (I don't think the
> "Priority"/"Complexity" is very important in the latter but could be
> done as well). I'd prefer each developer to fill in the file for
> profiles he's used with, so the end result is more accurate than if we
> had only 1 person to do it all. I can contribute an initial version
> with the features I found the last time I did that.

We actually have a TODO file in BlueZ, but it seems out of date. I think it
was started it during the initial phase of the LE development, but it was
abandoned at some point.

doc/features.txt would be interesting as well.

	Gustavo
