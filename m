Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Dec 2011 14:45:33 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC] media: assertion to check that transport exists
Message-ID: <20111216174533.GA9701@samus>
References: <1323952435-3244-1-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZJ9QgLPJQoudjRGZfMF5CHV5LaHUNZf8Hcojh5bjMgaTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZJ9QgLPJQoudjRGZfMF5CHV5LaHUNZf8Hcojh5bjMgaTQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10:43 Fri 16 Dec, Luiz Augusto von Dentz wrote:
> Hi Mikel,
> 
> On Thu, Dec 15, 2011 at 2:33 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> > From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >
> > From my understanding, a transport should exist for any non-disconnected
> > gateway.
> >
> > These assertions sometimes fail though. So I would like to clarify if
> > that's a consistent state in BlueZ or there is some bug.
> > ---
> >  audio/media.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/audio/media.c b/audio/media.c
> > index a2ef437..c5fe3d9 100644
> > --- a/audio/media.c
> > +++ b/audio/media.c
> > @@ -28,6 +28,7 @@
> >  #endif
> >
> >  #include <errno.h>
> > +#include <assert.h>
> >
> >  #include <glib.h>
> >  #include <gdbus.h>
> > @@ -620,8 +621,10 @@ static void gateway_state_changed(struct audio_device *dev,
> >                                        gateway_setconf_cb, dev, NULL);
> >                break;
> >        case GATEWAY_STATE_CONNECTED:
> > +               assert(endpoint->transport != NULL);
> >                break;
> >        case GATEWAY_STATE_PLAYING:
> > +               assert(endpoint->transport != NULL);
> >                break;
> >        }
> >  }
> > --
> > 1.7.6.4
> 
> IMO assert on daemon are not that great, it may help while developing
> but why not run with valgrind and let it crash?

This information may help with your worries, from the assert(3) man page:
"If the macro NDEBUG was defined at the moment <assert.h> was last included,
the macro assert() generates no code, and hence does nothing at all."

So we can have assert() do something only when it is compiled in developer mode.

> 
> -- 
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
