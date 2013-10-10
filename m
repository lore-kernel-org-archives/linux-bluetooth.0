Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 09:58:27 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 01/15] android: Supress missing initializers warnings
Message-ID: <20131010065825.GC23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 09, 2013 at 09:11:04PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > These types of warnings are disabled in BlueZ makeifiles
> > 
> > main.c:67:2: warning: missing initializer [-Wmissing-field-initializers]
> > main.c:67:2: warning: (near initialization for 'options[1].short_name')
> > 	[-Wmissing-field-initializers]
> > ---
> > android/Android.mk |    3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index ec820ac..5498b41 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -23,6 +23,9 @@ LOCAL_C_INCLUDES := \
> > 
> > LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> > 
> > +# to suppress the "warning: missing initializer near initialization.." warning
> > +LOCAL_CFLAGS += -Wno-missing-field-initializers
> > +
> 
> why are we doing this and not fixing the actual warning?
> 

Do you want me to initialize structures like

{NULL, NULL, NULL, ... }

this way it can be fixed.

Best regards 
Andrei Emeltchenko 
