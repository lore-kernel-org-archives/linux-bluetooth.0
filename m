Return-Path: <cyrus@holtmann.org>
Subject: Re: Input pairing broken again
From: David Woodhouse <dwmw2@infradead.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100809121946g4c485792i485b8771f9813823@mail.gmail.com>
References: <1221265310.10249.10.camel@macbook.infradead.org>
	 <1221272245.10249.18.camel@macbook.infradead.org>
	 <1221273507.10249.20.camel@macbook.infradead.org>
	 <2d5a2c100809121946g4c485792i485b8771f9813823@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 19:52:53 -0700
Message-Id: <1221274373.10249.25.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-09-12 at 23:46 -0300, Luiz Augusto von Dentz wrote:
> Both seems good, but please use debug instead of printf. Btw does your
> first patch solves the problem?

Oops. I meant to remove the printf before I sent the patch :)

Have committed both to git://git.infradead.org/~dwmw2/bluez.git without
the printf.

Before my first patch, look closely at the handling of req->search_uuid
in browse_cb().

Note that it's incremented _every_ time we end up back in browse_cb().

Even when we've already finished going through the uuid_list[] array,
and we're supposed to be iterating through req->uuids.

So what happens is we handle everything in the uuid_list[] until we
reach the zero at the end. Then we handle the first item from
req->uuids, then we trawl through the memory _after_ uuid_list[],
treating it as more uuids to search for until we reach another zero.
Then we handle the second item from req->uuids, then...

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

