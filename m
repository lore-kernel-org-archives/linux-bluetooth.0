Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 14:51:17 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 1/2] android/daemon: Implement get adapter name
Message-ID: <20131104125115.GB18874@aemeltch-MOBL1>
References: <1383562180-21646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 04, 2013 at 01:17:35PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Mon, Nov 4, 2013 at 12:49 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > ---
> >  android/adapter.c |   11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/android/adapter.c b/android/adapter.c
> > index af461b8..fdac82e 100644
> > --- a/android/adapter.c
> > +++ b/android/adapter.c
> > @@ -1017,13 +1017,14 @@ static void send_adapter_address(void)
> >         g_free(ev);
> >  }
> >
> > -static bool get_name(void)
> > +static bool send_adapter_name(void)
> >  {
> > -       DBG("Not implemented");
> > +       if (!adapter->name)
> > +               return false;
> >
> > -       /* TODO: Add implementation */
> > +       adapter_name_changed((uint8_t *) adapter->name);
> >
> > -       return false;
> > +       return true;
> >  }
> >
> >  static bool get_uuids(void)
> > @@ -1098,7 +1099,7 @@ static bool get_property(void *buf, uint16_t len)
> >                 send_adapter_address();
> >                 return true;
> >         case HAL_PROP_ADAPTER_NAME:
> > -               return get_name();
> > +               return send_adapter_name();
> 
> Not sure why you are changing the name here, all the other properties
> is using the same format as get_<name of property>.

I am following style, look at previous function: send_adapter_address. So
shall I change that one also in a separate patch?

Best regards 
Andrei Emeltchenko 

