Return-Path: <cyrus@holtmann.org>
Message-ID: <1340027876.3987.117.camel@novo.hadess.net>
Subject: Re: [PATCH 2/3] fakehid: Disconnect from PS3 remote after 10 mins
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Jun 2012 14:57:56 +0100
In-Reply-To: <CABBYNZJ0-CDhC6WQJ-k20yCeJRiHR7c__tV6xg9-xphcDdEg_Q@mail.gmail.com>
References: <1339889570.20079.7.camel@sirocco.config>
	 <CABBYNZJ0-CDhC6WQJ-k20yCeJRiHR7c__tV6xg9-xphcDdEg_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-06-18 at 11:44 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Sun, Jun 17, 2012 at 2:32 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > After 10 minutes, disconnect the PS3 BD Remote to avoid draining its
> > battery. This is consistent with its behaviour on the PS3.
> >
> > Original patch by Ruslan N. Marchenko <rufferson@gmail.com>
> > ---
> >  input/device.h  |    1 +
> >  input/fakehid.c |   36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/input/device.h b/input/device.h
> > index ff52967..d8baa2c 100644
> > --- a/input/device.h
> > +++ b/input/device.h
> > @@ -33,6 +33,7 @@ struct fake_input {
> >        int             uinput;         /* uinput socket */
> >        int             rfcomm;         /* RFCOMM socket */
> >        uint8_t         ch;             /* RFCOMM channel number */
> > +       guint           timeout_id;     /* Disconnect timeout ID */
> >        gboolean        (*connect) (struct input_conn *iconn, GError **err);
> >        int             (*disconnect) (struct input_conn *iconn);
> >        void            *priv;
> > diff --git a/input/fakehid.c b/input/fakehid.c
> > index 3181538..a125356 100644
> > --- a/input/fakehid.c
> > +++ b/input/fakehid.c
> > @@ -44,6 +44,9 @@
> >  #include "fakehid.h"
> >  #include "uinput.h"
> >
> > +/* Timeout to get the PS3 remote disconnected, in seconds */
> > +#define PS3_REMOTE_TIMEOUT 10 * 60
> > +
> >  enum ps3remote_special_keys {
> >        PS3R_BIT_PS = 0,
> >        PS3R_BIT_ENTER = 3,
> > @@ -141,6 +144,20 @@ static unsigned int ps3remote_keymap[] = {
> >        [0xff] = KEY_MAX,
> >  };
> >
> > +static gboolean ps3_remote_timeout_cb(gpointer user_data);
> > +
> > +static void ps3remote_set_timeout(struct fake_input *fake, gboolean enable)
> > +{
> > +       if (enable) {
> > +               fake->timeout_id = g_timeout_add_seconds(PS3_REMOTE_TIMEOUT, ps3_remote_timeout_cb, fake);
> > +       } else {
> > +               if (fake->timeout_id > 0) {
> > +                       g_source_remove(fake->timeout_id);
> > +                       fake->timeout_id = 0;
> > +               }
> > +       }
> > +}
> 
> It doesn't really need to remove/add the timeout separately, upon
> event just reset the idle timeout.

I don't understand what you're saying here.

Are you saying I should call g_source_remove, and then g_timeout_add()?
There's no functionality to change the interval for g_timeout_add*
functions.

The call is separate because it is used multiple times in the code (and
handling getting/setting in one place is cleaner).

By the way, the reason why it's handled this way is because the rest of
the input code relies on the kernel switching off the connection using
hidp_connadd_req->idle_to. fakehid doesn't use hidp.

Cheers

