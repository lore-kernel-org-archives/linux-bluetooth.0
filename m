Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131031142138.GM27517@aemeltch-MOBL1>
References: <1383228038-4306-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<20131031142138.GM27517@aemeltch-MOBL1>
Date: Thu, 31 Oct 2013 16:16:36 +0100
Message-ID: <CAMv5GbeKqnr=aWUTbJXGaSgaO4LfHBdtRZuw2fD9nuaCPBJ5Vg@mail.gmail.com>
Subject: Re: [PATCH] android: Add support for setting adapters name
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 31 October 2013 15:21, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> Hi Grzegorz,
>
> On Thu, Oct 31, 2013 at 03:00:38PM +0100, Grzegorz Kolodziejczyk wrote:
> > ---
> >  android/adapter.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  android/hal-msg.h |  2 ++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/android/adapter.c b/android/adapter.c
> > index 15b65e5..5dadc2e 100644
> > --- a/android/adapter.c
> > +++ b/android/adapter.c
> > @@ -129,6 +129,27 @@ static void scan_mode_changed(void)
> >       g_free(ev);
> >  }
> >
> > +static void adapter_name_changed(const uint8_t *name)
> > +{
> > +     struct hal_ev_adapter_props_changed *ev;
> > +     uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) +
> > +                                                     HAL_MAX_NAME_LENGTH];
> > +
> > +     memset(buf, 0, sizeof(buf));
> > +     ev = (void *) buf;
> > +
> > +     ev->num_props = 1;
> > +     ev->status = HAL_STATUS_SUCCESS;
> > +     ev->props[0].type = HAL_PROP_ADAPTER_NAME;
> > +     ev->props[0].len = HAL_MAX_NAME_LENGTH;
>
> Do we need to pass always HAL_MAX_NAME_LENGTH ?
>

Yes, HAL expect 249 byte size array. IPC should map to HAL calls,
where name is expected to have 249 bytes.

Best regards,
Grzegorz Kołodziejczyk
