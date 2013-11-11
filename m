Return-Path: <cyrus@holtmann.org>
Message-ID: <1384173342.1898.8.camel@nuvo>
Subject: Re: [PATCH 3/3] obex: Use XDG_RUNTIME_DIR as a default root
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Nov 2013 13:35:42 +0100
In-Reply-To: <CABBYNZK4m11-41ShyWO+LS3VqoUuqWbX8d2C9JssvGuKxJMiDA@mail.gmail.com>
References: <1384016598.3880.38.camel@nuvo> <1384091198.4593.6.camel@nuvo>
	 <CABBYNZK4m11-41ShyWO+LS3VqoUuqWbX8d2C9JssvGuKxJMiDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2013-11-11 at 11:00 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Sun, Nov 10, 2013 at 3:46 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Sat, 2013-11-09 at 18:03 +0100, Bastien Nocera wrote:
> >> It's per-user, so we won't try to overwrite somebody else's
> >> files in /tmp when that happens.
> >
> > There might be another useful directory instead. We could use
> > g_get_user_cache_dir() instead of the run-time dir. This would save
> > cross-partition moves by default, making the move to the Downloads dir
> > atomic (a single rename, which can fail, iterate until we find a "free"
> > filename).
> >
> > Is that better for you?
> 
> Yep, it sounds better. Regarding renaming that is up the agent, if you
> really want to do that its probably fine but Im still not convinced
> this is absolutely necessary if obexd is running with the same user as
> the agent can just create the file while authorizing so you wouldn't
> need to move after completed, but again this is completely up to the
> agent to decide where the files should go.

You seem to think that all the application/services running under one
user would have the same rights. That's currently the case, but won't be
in the future.

> Btw, what about fd passing? In theory we can create a different
> version of the agent interface to enable passing fd directly, and in
> fact we were thinking about this already as for some services you
> wanted them to be dynamic so we were thinking on having this set by
> the agent when it registers.

I'm fine with a file descriptor as well, but obex push server is
currently broken in GNOME 3.10. I'm happy doing the changes in GNOME
3.12 (due in 6 months).

Can we get the cache dir change in, and make the API change later on?

Cheers

