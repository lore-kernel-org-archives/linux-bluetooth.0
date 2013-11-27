Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 10:29:44 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] android/socket: Handle Android events for server
 socket
Message-ID: <20131127082942.GD3149@aemeltch-MOBL1>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385474750-18331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131126154602.GB25005@x220.p-661hnu-f1>
 <20131127080051.GC3149@aemeltch-MOBL1>
 <20131127082128.GA23732@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131127082128.GA23732@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 27, 2013 at 10:21:28AM +0200, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Wed, Nov 27, 2013, Andrei Emeltchenko wrote:
> > On Tue, Nov 26, 2013 at 05:46:02PM +0200, Johan Hedberg wrote:
> > > Hi Andrei,
> > > 
> > > On Tue, Nov 26, 2013, Andrei Emeltchenko wrote:
> > > > Add watch for tracking events from Android framework for server socket.
> > > > ---
> > > >  android/socket.c | 27 ++++++++++++++++++++++++++-
> > > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > 
> > > I've applied the first two patches, but wanted to ask about this one:
> > > 
> > > > +static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
> > > > +								gpointer data)
> > > > +{
> > > > +	struct rfcomm_sock *rfsock = data;
> > > > +
> > > > +	DBG("");
> > > > +
> > > > +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> > > > +		error("Socket error: sock %d cond %d",
> > > > +					g_io_channel_unix_get_fd(io), cond);
> > > > +		cleanup_rfsock(rfsock);
> > > > +
> > > > +		return FALSE;
> > > > +	}
> > > > +
> > > > +	return TRUE;
> > > > +}
> > > 
> > > I don't see where (in which patch) you'd add code to handle G_IO_IN on
> > > this socket. Aren't you supposed to read data from this socket and write
> > > it to the RFCOMM one?
> > 
> > At this moment I do not know which data might come from this socket. I
> > have debug statement to know that something is coming.
> 
> The fact that you're adding G_IO_IN as one of the conditions for the
> callback tells the reader that you're interested in data. Then, when the
> reader looks at the function implementation he thinks "wait a minute, it
> looks like there's a bug here since this is never reading anything". The
> debug statement wont help you since then you'll end up in an endless
> loop if there ever is data (since the data gets never removed from the
> incoming socket buffer). So I'd just remove G_IO_IN from the conditions.
> 

OK

> > I assume this would be primary used to clean up socket structure if
> > Android decides to stop listen().
> 
> Which HAL method would "stop listen()" be done with? I don't see such a
> method in the HAL (please correct me if I'm wrong though). If there's no
> such method it's not possible to stop the listening socket, and hence
> you're just adding dead code here.

This is listening on socketpair descriptor, the other end was sent to
Android framework. So we might get some signal or socket close.

Best regards 
Andrei Emeltchenko 

