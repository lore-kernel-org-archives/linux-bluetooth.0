Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v2 12/15] adaptername: Refactor handle_inotify_cb
Date: Fri, 31 Aug 2012 16:25:51 +0200
Message-ID: <1623298.VeVY2Kx13o@uw000953>
In-Reply-To: <CAJdJm_NNYAHHVrr-uj97h7FEL0XatL5PuLnpOri6An4c-bz=mw@mail.gmail.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com> <1346416811-23484-13-git-send-email-szymon.janc@tieto.com> <CAJdJm_NNYAHHVrr-uj97h7FEL0XatL5PuLnpOri6An4c-bz=mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 31 of August 2012 16:19:28 Anderson Lizardo wrote:
> Hi Szymon,

Hi Anderson,

> 
> On Fri, Aug 31, 2012 at 8:40 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > @@ -226,35 +226,41 @@ static int adaptername_probe(struct btd_adapter *adapter)
> >  static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
> >                                                                 gpointer data)
> >  {
> > -       char buf[EVENT_BUF_LEN];
> 
> Looks like EVENT_SIZE and EVENT_BUF_LEN defines are not used anymore
> so they can be removed.

Yeap, will remove it.

> 
> > +               err = g_io_channel_read_chars(channel, name, event.len, &len,
> > +                                                                       NULL);
> 
> No need to check for event.len <= FILENAME_MAX before the
> *read_chars() call ? (I don't know inotify, so I'm not sure about the
> allowed limits here)

Well, data is a file name which can't be > FILENAME_MAX+1. We would have to receive
some invalid data from kernel for that to happen... can we trust data from kernel?:)

So I'm also not sure if we really needs to validate that data...
This is what I've found in inotify-tools code about that situation:
  // oh... no.  this can't be happening.  An incomplete event.
  // Copy what we currently have into first element, call self to
  // read remainder.
  // oh, and they BETTER NOT overlap.
  // Boy I hope this code works.
  // But I think this can never happen due to how inotify is written.
They try to recover from that but if events overlap it is fubared anyway..

> 
> Or maybe using sizeof(name) instead of event.len ?

We can receive more events at once, so with that we could read name + part of next
inotify_event.

> 
> > +               if (err != G_IO_STATUS_NORMAL) {
> > +                       error("Error reading inotify event: %d", err);
> > +                       return FALSE;
> > +               }
> 
> Is it necessary to check whether event.len == len here ?

As above, this should not happen... but I'll move error reporting code into label
(to keep loop code short) and check for those anyway...

> 
> Otherwise a short read may not have the necessary "\0" for the
> strcmp() (but see below).
> 
> >
> > -               i += EVENT_SIZE + pevent->len;
> > -       }
> > +               if (strcmp(name, MACHINE_INFO_FILE) != 0)
> > +                       continue;
> 
> What about using strncmp() just to be safe?

Will fix that.

> 
> >
> > -       if (changed != FALSE) {
> >                 DBG(MACHINE_INFO_DIR MACHINE_INFO_FILE
> >                                 " changed, changing names for adapters");
> > +
> >                 manager_foreach_adapter((adapter_cb) adaptername_probe, NULL);
> > +               break;
> 
> what about having " if (strcmp(name, MACHINE_INFO_FILE) == 0) " and
> moving the code above to inside the if() ? The "unconditional" break
> at the end of the while() looks strange IMHO.

Wanted to keep indentation low, but yes, this might look strange.

> 
> >         }
> >
> >         return TRUE;
> 
> Regards,
> 

I'll send V3 in a moment.
Thanks for comments!

-- 
BR
Szymon Janc


