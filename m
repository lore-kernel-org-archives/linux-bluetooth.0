Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511536979.11411.23.camel@hadess.net>
Subject: Re: [PATCH 2/2] obex: Work-around compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Nov 2017 16:22:59 +0100
In-Reply-To: <CABBYNZ+SJ0maQVjyfxgawvqiV6z-RrpYaCwb0cdCQpw5dzvMuw@mail.gmail.com>
References: <20171102140953.21684-1-hadess@hadess.net>
         <20171102140953.21684-2-hadess@hadess.net>
         <1511532398.11411.8.camel@hadess.net>
         <CABBYNZ+SJ0maQVjyfxgawvqiV6z-RrpYaCwb0cdCQpw5dzvMuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-11-24 at 16:48 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Fri, Nov 24, 2017 at 4:06 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Thu, 2017-11-02 at 15:09 +0100, Bastien Nocera wrote:
> > > obexd/plugins/bluetooth.c: In function 'register_profile':
> > > obexd/plugins/bluetooth.c:310:7: error: format not a string
> > > literal,
> > > argument types not checked [-Werror=format-nonliteral]
> > >        profile->driver->port);
> > >        ^~~~~~~
> > > obexd/plugins/bluetooth.c:314:7: error: format not a string
> > > literal,
> > > argument types not checked [-Werror=format-nonliteral]
> > >        profile->driver->name);
> > >        ^~~~~~~
> > 
> > 
> > And so does this one.
> 
> I really hope we can avoid GCC specific pragmas,

I'm pretty sure it just won't do anything with other compilers.

>  there got to be a
> better way avoid this error

A lot of code refactoring.

>  or just disable
> -Werror=format-nonliteral, actually is that our error or
> g_markup_printf_escaped?

It's the g_markup_printf_escaped() usage that incorrect. The first
argument of printf-style functions are supposed to be literals,
otherwise the compiler doesn't know whether the arguments passed match
the format.

It's a potential security bug, depending on where the format comes
from, and how it's generated.

Removing the warning/error doesn't remove the bug, it just hides it.
And so does this patch. I don't know the codebase enough to refactor
it.

Cheers
