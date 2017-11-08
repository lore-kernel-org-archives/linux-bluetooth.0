Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510139184.3313.4.camel@hadess.net>
Subject: Re: [PATCH 1/3] plugins/sixaxis: Fix cable pairing not working
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 08 Nov 2017 12:06:24 +0100
In-Reply-To: <20171108074930.GA11778@x1c.lan>
References: <20171107182356.15683-1-hadess@hadess.net>
         <20171108074930.GA11778@x1c.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-08 at 09:49 +0200, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Tue, Nov 07, 2017, Bastien Nocera wrote:
> > In 6c467e9, get_pairing_type() was modified to return a structure
> > that's
> > allocated on the stack. While not a problem for the direct callers,
> > as the function is defined as "inline", function that expected to
> > return
> > this structure themselves would fail, as the stack would be
> > trampled
> > upon on function exit.
> 
> The devices array inside get_pairing() is declared as static, so I
> don't
> see how this can be on the stack?

Looks like I chased down a wild goose, and that while it "fixed" my
problem, the root cause was something completely different. There's a
new patch coming up.

>  Are these the structures you're
> referring to? That said, it seems weird to have an inline function
> declare a static variable, since then every single caller of the
> function would cause another static variable to be allocated, right?
> It
> seems to me that if the function is still desired to be inline then
> the
> cable_pairing array should at least be moved into some c-file, so
> that
> it only gets created once. Perhaps a better solution is however to
> stop
> having get_pairing() as inline to begin with?

The reason to having this inline in a shared header was explained in
the commit message I believe. We need this code both in the
core/builtin input plugin and in the sixaxis plugin. We'd either need
to make this function public in the core, meaning in the external
plugin API, or copy/pasted between the 2 parts, both of which are
inconvenient.

If the function wasn't inline, we'd have 2 functions with the same
name, and the external plugin, sixaxis in this case, would fail to
load.
