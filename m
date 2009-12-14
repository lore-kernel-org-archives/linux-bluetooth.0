Return-Path: <cyrus@holtmann.org>
Subject: Re: No way to cancel SendFiles() in obexd
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2a9506370912141044s2f5ed846ub2072b0d378d7a11@mail.gmail.com>
References: <1260810093.3311.5884.camel@localhost.localdomain>
	 <2a9506370912141044s2f5ed846ub2072b0d378d7a11@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 14 Dec 2009 19:16:13 +0000
Message-ID: <1260818173.3311.6022.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-12-14 at 15:44 -0300, Vinicius Gomes wrote:
> Hi Bastien,
> 
> On Mon, Dec 14, 2009 at 2:01 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > I have a slight problem with SendFiles().
> >
> > When sending multiple files, and refusing one of them on the phone, the
> > subsequent files are still sent.
> >
> > Is there a way to avoid that? Or should I rework the UI slightly to
> > mention that some files were not sent?
> >
> 
> As of now, there's no way to avoid that. Personally, I like the
> current behavior, at least, it is consistent with other tools, cp for
> example.

That's fine if you're implementing a command-line tool. Most UIs that do
copy will block until the user acknowledges the problem.

> > For a single file, you'll get a nice "retry" button if the phone refused
> > the connection. I'd prefer it if the agent could ask me whether to carry
> > on sending files, or cancel all the sending.
> >
> 
> Between those two options, I prefer cancel all the sending.

That would be fine by me, at least I can implement re-sending in some
way, even if it's not the way it currently works.

Marcel, what do you think?

