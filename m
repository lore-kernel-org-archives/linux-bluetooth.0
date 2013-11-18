Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 12:02:43 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 04/16] android/socket: Define structs and implement
 listen
Message-ID: <20131118100242.GB21114@aemeltch-MOBL1>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384763179-2218-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131118085535.GC30170@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131118085535.GC30170@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 18, 2013 at 10:55:35AM +0200, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Mon, Nov 18, 2013, Andrei Emeltchenko wrote:
> > This defines structures for socket HAL. We need to emulate Android
> > sockets by sending connect/accept signals over file descriptor.
> > Handle HAL socket listen call. Create RFCOMM socket and wait for events.
> > ---
> >  android/socket.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 116 insertions(+), 2 deletions(-)
> > 
> > diff --git a/android/socket.c b/android/socket.c
> > index e580036..276c78c 100644
> > --- a/android/socket.c
> > +++ b/android/socket.c
> > @@ -27,8 +27,12 @@
> >  
> >  #include <glib.h>
> >  #include <stdbool.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> >  
> >  #include "lib/bluetooth.h"
> > +#include "btio/btio.h"
> > +#include "lib/sdp.h"
> >  #include "log.h"
> >  #include "hal-msg.h"
> >  #include "hal-ipc.h"
> > @@ -37,13 +41,123 @@
> >  
> >  static bdaddr_t adapter_addr;
> >  
> > -static int handle_listen(void *buf)
> > +/* Simple list of RFCOMM server sockets */
> > +GList *rfcomm_srv_list = NULL;
> > +
> > +/* Simple list of RFCOMM connected sockets */
> > +GList *rfcomm_connected_list = NULL;
> 
> Didn't I suggest "servers" and "connections" as names for these?
> 
> > +struct rfcomm_slot {
> 
> The term "slot" seems a bit confusing to me. You're using this struct as
> context for both server sockets and connected sockets. Would the name
> struct rfcomm_socket make more sense? Feel free to suggest something
> else too.

rfcomm_socket is ok, what is a good name instead of rfslot? rfsock?

Best regards 
Andrei Emeltchenko 

