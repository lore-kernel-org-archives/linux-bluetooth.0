Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 11:26:54 -0300
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object
Message-ID: <20111006142654.GA4507@vigoh>
References: <1317844938-21950-1-git-send-email-luiz.dentz@gmail.com>
 <20111006081647.GA23687@fusion.localdomain>
 <20111006122423.GA15489@aemeltch-MOBL1>
 <CABBYNZLjdGy+kS6S7YyUDJSTXJo8vDjT8hNrXUMoDTfOr2GV0A@mail.gmail.com>
 <20111006135256.GC15489@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20111006135256.GC15489@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2011-10-06 16:52:59 +0300]:

> Hi Luiz,
> 
> On Thu, Oct 06, 2011 at 04:35:26PM +0300, Luiz Augusto von Dentz wrote:
> > Hi Andrei,
> > 
> > On Thu, Oct 6, 2011 at 3:24 PM, Andrei Emeltchenko
> > <andrei.emeltchenko.news@gmail.com> wrote:
> > > Hi guys,
> > >
> > > On Thu, Oct 06, 2011 at 11:16:47AM +0300, Johan Hedberg wrote:
> > >> Hi Luiz,
> > >>
> > >> On Wed, Oct 05, 2011, Luiz Augusto von Dentz wrote:
> > >> > This move the MediaPlayer registration to adapter object on Media
> > >> > interface so we can track players properly.
> > >> > ---
> > >> >  audio/avrcp.c     |  840 +++++++++++------------------------------------------
> > >> >  audio/avrcp.h     |   67 ++++-
> > >> >  audio/device.c    |    3 -
> > >> >  audio/device.h    |    2 -
> > >> >  audio/manager.c   |    7 -
> > >> >  audio/media.c     |  784 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >> >  doc/media-api.txt |  163 +++++++++++
> > >> >  7 files changed, 1179 insertions(+), 687 deletions(-)
> > >>
> > >> All four patches have been applied. Thanks.
> > >
> > > Can it cause this:
> > >
> > > $ LANG=en make
> > > make --no-print-directory all-am
> > >  CC     audio/media.o
> > > cc1: warnings being treated as errors
> > > audio/media.c: In function 'get_setting':
> > > audio/media.c:1106:44: error: cast to pointer from integer of different
> > > size
> > > make[1]: *** [audio/media.o] Error 1
> > > make: *** [all] Error 2
> > >
> > > in the line below:
> > >        <------8<-------------------------------------------------------------
> > >        |  value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
> > >        <------8<-------------------------------------------------------------
> > >
> > > Is patch below OK?
> > >
> > > @@ -1103,7 +1103,8 @@ static int get_setting(uint8_t attr, void
> > > *user_data)
> > >
> > >        DBG("%s", attr_to_str(attr));
> > >
> > > -       value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
> > > +       value = g_hash_table_lookup(mp->settings,
> > > +                                       GUINT_TO_POINTER((uint32_t) attr));
> > >        if (!value)
> > >                return -EINVAL;
> > 
> > Are you using 32 bits? At least Im running 64 bit and Im not seeing
> > this problem.
> 
> Yes, 32 bits.
> 
> I found this define:
> 
> /usr/lib/i386-linux-gnu/glib-2.0/include/glibconfig.h:#define
> GUINT_TO_POINTER(u)	((gpointer)  (u))

Do you confirm that changing this header as below fixes your issue?
GUINT_TO_POINTER(u)	((gpointer) (guint) (u))

In that case we should send the patch below to glib:



>From db167c52918835aba947bb1a23bed3f62502244a Mon Sep 17 00:00:00 2001
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 6 Oct 2011 11:18:03 -0300
Subject: [PATCH] Fix casts on 32 bits

If we don't do the cast to the proper size in 32 bits, things like below
doesn't work:

uint8_t u = 20;
void *p;

p = GUINT_TO_POINTER(u);
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e4235e0..95e3c06 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3361,8 +3361,8 @@ $ac_cv_sizeof_int)
   gintptr_modifier='""'
   gintptr_format='"i"'
   guintptr_format='"u"'
-  glib_gpi_cast=''
-  glib_gpui_cast=''
+  glib_gpi_cast='gint'
+  glib_gpui_cast='guint'
   ;;
 $ac_cv_sizeof_long)
   glib_intptr_type_define=long
-- 
1.7.7

