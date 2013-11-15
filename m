Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Nov 2013 11:23:19 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv1 07/16] android/hal-sock: Implement Android RFCOMM stack
 events
Message-ID: <20131115092317.GA7413@aemeltch-MOBL1>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384441915-23966-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <91DA1530-80F5-41BE-BDC6-6A03BA9B4C33@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91DA1530-80F5-41BE-BDC6-6A03BA9B4C33@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 15, 2013 at 09:00:51AM +0900, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Handle events from Android framework. Write everything to real RFCOMM
> > socket.
> > ---
> > android/socket.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 42 insertions(+)
> > 
> > diff --git a/android/socket.c b/android/socket.c
> > index c9ee32f..07743f6 100644
> > --- a/android/socket.c
> > +++ b/android/socket.c
> > @@ -118,6 +118,48 @@ static int get_rfcomm_default_chan(const uint8_t *uuid)
> > static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
> > 								gpointer data)
> > {
> > +	struct rfcomm_slot *rfslot = data;
> > +	unsigned char buf[1024] = { 0 };
> 
> since why are we doing this { 0 } thing?
> 
> > +	int len, sent;
> > +
> > +	DBG("rfslot: fd %d real_sock %d chan %u sock %d",
> > +		rfslot->fd, rfslot->real_sock, rfslot->channel,
> > +		g_io_channel_unix_get_fd(io));
> > +
> > +	if (!g_list_find(rfcomm_connected_list, rfslot)) {
> > +		error("rfslot %p not found in the list", rfslot);
> > +		return FALSE;
> > +	}
> > +
> > +	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
> > +		error("Socket error: sock %d cond %d",
> > +					g_io_channel_unix_get_fd(io), cond);
> > +		rfcomm_connected_list = g_list_remove(rfcomm_connected_list,
> > +								rfslot);
> > +		cleanup_rfslot(rfslot);
> > +		return FALSE;
> > +	}
> > +
> > +	/* FIXME check fd vs sock(io) */
> 
> I do not even understand this FIXME. Why not get it right in the fist place.
> 
> > +	len = recv(rfslot->fd, buf, sizeof(buf), 0);
> > +	if (len <= 0) {
> > +		error("recv(): %s", strerror(errno));
> > +		return FALSE;
> > +	}
> > +
> > +	DBG("read %d bytes write to %d", len, rfslot->real_sock);
> > +
> > +	sent = send(rfslot->real_sock, buf, len, 0);
> > +	if (sent < 0) {
> > +		error("send(): %s", strerror(errno));
> > +		return FALSE;
> > +	}
> > +
> > +	if (sent != len) {
> > +		error("send(): sent %d bytes out of %d", sent, len);
> > +		return FALSE;
> > +	}
> 
> Only problem is still that we now abort on errors like EINTR or EAGAIN. That is not what we want either.
> 

So shall we retry to send the several (say 3) times here?

Best regards 
Andrei Emeltchenko 
