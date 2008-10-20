Return-Path: <cyrus@holtmann.org>
Subject: Re: PBAP storage plugin API proposal
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ac8af0be0810200221wff8bb75gf8d69b523ee3ea3b@mail.gmail.com>
References: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
	 <1223457456.11272.254.camel@violet.holtmann.net>
	 <ac8af0be0810081843i8bd6bd3g7282b11e3e9c8b1e@mail.gmail.com>
	 <1224304182.9386.14.camel@californication>
	 <ac8af0be0810200221wff8bb75gf8d69b523ee3ea3b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Oct 2008 18:12:39 +0200
Message-Id: <1224519159.9386.56.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> >> Yes. My proposed PBAP storage API follows this rule, but lacks the
> >> method to unregister the operations. Will add it later.
> >
> > I put some prototype declarations into the obexd repository. The
> > important part is that we have to do this in an async way. We can't
> > block while retrieving the phonebook information.
> >
> 
> I'm implementing PBAP driver framework and a simple(or prototype) PBAP
> driver based on your prototype declarations. Will add some extentions
> to the prototype declarations if necessary.
> To do that in an async way I think the basic idea is:
> 1 when PBAP driver is loaded(or initialized), fork() is invoked to run
> PBAP driver in child process

NO WAY. No fork() and no threads. That is just not needed. You get the
callback and then you just use phonebook_return(). Check the code that
is actually in the repository. It needs a little bit more work to get
the details right, but it works how it should be.

Also we do have a phonebook_context that presents a lifetime of a
transaction. It needs to be extended and used properly, but it is how
this is done.

Also the pull phonebook, pull vcard listing and pull vcard entry with
one specific context can not run simultaneously. The will run after each
if at all. So we init a context and then we destroy the context once we
are done with it. In between we can use the any callback.

> 2 the Unix domain socket is used to communicate between PBAP server
> and PBAP driver; and PBAP server acts as client role at the one end of
> socket, PBAP driver acts as server role at the other end of socket

NO WAY. Come on. Don't try to make this more complicated. Think simple
and I already put all the ground works into the repository. We just need
to parse the OBEX request properly and return the result from the
plugin.

And remember that obexd is designed for embedded systems and every
process that we have to run additionally costs us. Not to mention that
we end up with crazy dependencies for boot.

> 3 everytime a PBAP client connects to PBAP server(i.e. a OBEX session
> is initiated), PBAP server initiates a session(or a socket) with PBAP
> driver by invoking connect(). Then PBAP server sends subsequent PBAP
> request(pullphonebook, pullvcardlisting, pullvcardentry) through this
> socket; PBAP driver sends back the requested data through the socket
> asyncronously.
> Am I right? I'd like to first make the basic design ideas clear in
> order to avoid the unnecessary misunderstanding or confusion before
> starting to write the code.

The basic design is already pushed into the repository. Including sample
code for accessing the Evolution Data Server via the ebook plugin.

Start looking at that code, because that is the way to go. No need for
an over-complicated design. The whole code is only missing some minor
pieces I didn't have time for over the weekend.

Regards

Marcel


