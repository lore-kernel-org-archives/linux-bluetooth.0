Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Aug 2011 15:56:20 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] serial: use port->msg to track rfcomm connection
 procedure
Message-ID: <20110819185620.GC24573@joana>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-2-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-3-git-send-email-padovan@profusion.mobi>
 <CABBYNZ+x_FjfZApEVTWNwacp_+0=aBLBW8wGA=-QJby5LcX5mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+x_FjfZApEVTWNwacp_+0=aBLBW8wGA=-QJby5LcX5mQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-19 10:13:16 +0300]:

> Hi Gustavo,
> 
> On Thu, Aug 18, 2011 at 11:10 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> >
> > Use port->msg has the same effect of using port->io.
> > ---
> >  serial/port.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/serial/port.c b/serial/port.c
> > index 3f041a6..bc4b4ea 100644
> > --- a/serial/port.c
> > +++ b/serial/port.c
> > @@ -149,7 +149,7 @@ static int port_release(struct serial_port *port)
> >        int err = 0;
> >
> >        if (port->id < 0) {
> > -               if (port->io) {
> > +               if (port->msg) {
> >                        g_io_channel_shutdown(port->io, TRUE, NULL);
> >                        g_io_channel_unref(port->io);
> >                        port->io = NULL;
> 
> They may have the same effect but I would maintain the current one
> since we are only using port->io and changing it to port->msg may be
> unclear when reading the code without knowing the behavior.

Yes, but I want to change the behavior of port->io since I don't to create
another struct member to mantain the IO channel.
Maybe we can keep it here, I'll check the code.

	Gustavo
