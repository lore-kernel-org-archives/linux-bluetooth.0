Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] osso-gwobex export
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <2d5a2c101002091244y7ddafc40mc8d565c8c86a2760@mail.gmail.com>
References: <1265738807.2383.6336.camel@localhost.localdomain>
	 <2d5a2c101002091244y7ddafc40mc8d565c8c86a2760@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 10 Feb 2010 00:25:05 +0000
Message-ID: <1265761505.2383.7099.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-02-09 at 22:44 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Feb 9, 2010 at 8:06 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > Here's a patch to fix libgwobex not using a soname, and fixing a few
> > build problems.
> >
> > I couldn't run the test suite, as gnome-bluetooth's ancient btctl Python
> > module isn't around any more.
> >
> > Could I bribe someone into making a release that I could use for gvfs'
> > ObexFTP module[1]?
> >
> > Cheers
> >
> > [1]: https://bugzilla.gnome.org/show_bug.cgi?id=609340
> 
> I thought the plan was to use obex-client daemon in gvfs backend,

Not sure where you got that idea from...

>  well
> obex-client uses gwobex so it is mostly the same code, but it would be
> good to know if there is there any specific reason, or reasons, not to
> use obex-client as it is what we normally uses for testing obexd
> functionality.

Because I'm not really interested in using D-Bus in gvfs modules
anymore. It's a pain to debug, especially when the client is used by
more than one module (say, for both bluetooth-sendto and the gvfs
backend).

Furthermore, the backend is already split out from applications, and
from the gvfs daemon. So adding a level of indirection is not really
necessary. Finally, nobody's written the file descriptor passing to
allow arbitrary data to be written through obexftp.

Now I can get better crasher and leak reports, better error handling,
stop using temporary files, and still share much of the backend code of
obexd.

If you want to help, you can look into porting gnome-user-share to using
obexd if you want...

Cheers

