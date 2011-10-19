Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 10:35:06 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] fix build
Message-ID: <20111019073503.GC28113@aemeltch-MOBL1>
References: <1318866965-11091-1-git-send-email-frederic.danis@linux.intel.com>
 <20111018081952.GA8054@aemeltch-MOBL1>
 <1318955775.15441.137.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1318955775.15441.137.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 18, 2011 at 09:36:13AM -0700, Marcel Holtmann wrote:
> > > src/eir.c: In function 'eir_parse':
> > > src/eir.c:72: error: 'name_len' may be used uninitialized in this function
> > > 
> > > and
> > > 
> > > thermometer/thermometer.c: In function 'destroy_char':
> > > thermometer/thermometer.c:79: error: implicit declaration of function 'g_slist_free_full'
> > > ---
> > >  src/eir.c                 |    2 +-
> > >  thermometer/thermometer.c |    5 +++++
> > >  2 files changed, 6 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/src/eir.c b/src/eir.c
> > > index 8772191..8ada364 100644
> > > --- a/src/eir.c
> > > +++ b/src/eir.c
> > > @@ -69,7 +69,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
> > >  	uuid_t service;
> > >  	char *uuid_str;
> > >  	const char *name = NULL;
> > > -	size_t name_len;
> > > +	size_t name_len = 0;
> > 
> > BTW: shall we change build flags otherwise bluez is not building anymore.
> > 
> > make
> > make --no-print-directory all-am
> >   CC     src/eir.o
> > cc1: warnings being treated as errors
> > src/eir.c: In function ‘eir_parse’:
> > src/eir.c:73:9: error: ‘name_len’ may be used uninitialized in this
> > function
> > make[1]: *** [src/eir.o] Ошибка 1
> > make: *** [all] Ошибка 2
> 
> it builds fine if you install a recent distro with a recent gcc.

What is the recent gcc I need to have? I have Ubuntu 11.04 with gcc:

gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu4)

Actually several weeks ago new Ubuntu was introduced 11.10, hopefully they
have right gcc :-)

Best regards 
Andrei Emeltchenko 
