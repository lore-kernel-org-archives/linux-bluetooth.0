Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111006122423.GA15489@aemeltch-MOBL1>
References: <1317844938-21950-1-git-send-email-luiz.dentz@gmail.com>
 <20111006081647.GA23687@fusion.localdomain> <20111006122423.GA15489@aemeltch-MOBL1>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 6 Oct 2011 09:28:57 -0300
Message-ID: <CAMOw1v7JC1scx+CAca-+TccPenJS-sJW14y0uozG18RVP_Eikw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 6, 2011 at 9:24 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> Hi guys,
>
> On Thu, Oct 06, 2011 at 11:16:47AM +0300, Johan Hedberg wrote:
> > Hi Luiz,
> >
> > On Wed, Oct 05, 2011, Luiz Augusto von Dentz wrote:
> > > This move the MediaPlayer registration to adapter object on Media
> > > interface so we can track players properly.
> > > ---
> > >  audio/avrcp.c     |  840 +++++++++++------------------------------------------
> > >  audio/avrcp.h     |   67 ++++-
> > >  audio/device.c    |    3 -
> > >  audio/device.h    |    2 -
> > >  audio/manager.c   |    7 -
> > >  audio/media.c     |  784 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  doc/media-api.txt |  163 +++++++++++
> > >  7 files changed, 1179 insertions(+), 687 deletions(-)
> >
> > All four patches have been applied. Thanks.
>
> Can it cause this:
>
> $ LANG=en make
> make --no-print-directory all-am
>  CC     audio/media.o
> cc1: warnings being treated as errors
> audio/media.c: In function 'get_setting':
> audio/media.c:1106:44: error: cast to pointer from integer of different
> size
> make[1]: *** [audio/media.o] Error 1
> make: *** [all] Error 2
>
> in the line below:
>        <------8<-------------------------------------------------------------
>        |  value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
>        <------8<-------------------------------------------------------------
>
> Is patch below OK?
>
> @@ -1103,7 +1103,8 @@ static int get_setting(uint8_t attr, void
> *user_data)
>
>        DBG("%s", attr_to_str(attr));
>
> -       value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
> +       value = g_hash_table_lookup(mp->settings,
> +                                       GUINT_TO_POINTER((uint32_t) attr));

What glib are you using?

Recent glib has this implementation, which does not causes warnings here:

#define GUINT_TO_POINTER(u) ((gpointer) (gulong) (u))



regards,
Lucas De Marchi
