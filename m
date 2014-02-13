Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Feb 2014 10:21:32 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/4] android/haltest: Remove unneeded assignment
Message-ID: <20140213081922.GC25950@aemeltch-MOBL1>
References: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJq3wWht-Jk7BP=dkEnsTG2o8fXiF8JycJr_prMvQe0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJq3wWht-Jk7BP=dkEnsTG2o8fXiF8JycJr_prMvQe0NA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 10, 2014 at 02:16:09PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Fri, Feb 7, 2014 at 2:11 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > ---
> >  android/client/if-audio.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/android/client/if-audio.c b/android/client/if-audio.c
> > index 8c640a1..5ab11a6 100644
> > --- a/android/client/if-audio.c
> > +++ b/android/client/if-audio.c
> > @@ -225,10 +225,8 @@ static void *playback_thread(void *data)
> >                 pthread_mutex_unlock(&outstream_mutex);
> >         } while (len && w_len > 0);
> >
> > -       if (in) {
> > +       if (in)
> >                 fclose(in);
> > -               in = NULL;
> > -       }
> >
> >         pthread_cleanup_pop(1);
> >         return NULL;
> > --
> > 1.8.3.2
> 
> Pushed, note that I did move the changes from audio to android since
> the audio code will be dropped as it is not unit tested.

I still think that those patches needs to applied otherwise we have
following warnings:

...
  CC       profiles/audio/bluetoothd-avdtp.o
profiles/audio/avdtp.c:2735:2: warning: Null pointer passed as an argument
to a 'nonnull' parameter
        memcpy(req->data, buffer, size);
        ^                 ~~~~~~
profiles/audio/avdtp.c:3290:2: warning: Null pointer passed as an argument
to a 'nonnull' parameter
        memcpy(cap->data, data, length);
        ^                 ~~~~
2 warnings generated.
...

You may choose to fix those warns other ways though.

Best regards 
Andrei Emeltchenko 

