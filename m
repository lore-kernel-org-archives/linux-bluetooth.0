Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2014 13:46:06 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-health: Clear NONBLOCK flag from fd
Message-ID: <20140703104603.GA7283@aemeltch-MOBL1>
References: <1404383493-8174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <700D9D34-C873-4A39-858C-68265704A8EB@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <700D9D34-C873-4A39-858C-68265704A8EB@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 03, 2014 at 12:38:29PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Java expects file descriptor passed with channel_state_cb() to be
> > blocking.
> > ---
> > android/hal-health.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> > 
> > diff --git a/android/hal-health.c b/android/hal-health.c
> > index 858d499..2ff19ab 100644
> > --- a/android/hal-health.c
> > +++ b/android/hal-health.c
> > @@ -19,6 +19,8 @@
> > #include <stddef.h>
> > #include <string.h>
> > #include <stdlib.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > 
> > #include "hal-log.h"
> > #include "hal.h"
> > @@ -44,6 +46,13 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
> > static void handle_channel_state(void *buf, uint16_t len, int fd)
> > {
> > 	struct hal_ev_health_channel_state *ev = buf;
> > +	int flags;
> > +
> > +	if ((flags = fcntl(fd, F_GETFL, 0)) < 0)
> > +		flags = 0;
> 
> I do not like the if ((x = x) < x) syntax. Don't use that.
> 
> Also what is the point of setting it to 0 here. Just skip the F_SETFL. I rather print a proper error here then trying to outsmart ourselves.
> 
> > +
> > +	fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
> > +
> 
> Same here. Might check the return error and print an error if it fails. At least then someone can debug it.
> 

OK, I will send updated version ASAP.

Best regards 
Andrei Emeltchenko 

> > 
> > 	if (cbacks->channel_state_cb)
> > 		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
> 
> Regards
> 
> Marcel
> 
