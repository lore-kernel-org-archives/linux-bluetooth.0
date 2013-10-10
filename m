Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 16:01:29 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 11/15] android: Add cap to bind to port < 1024
Message-ID: <20131010130128.GP23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <8E82FD20-395B-4EFC-8D5F-DB349B8227C5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8E82FD20-395B-4EFC-8D5F-DB349B8227C5@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 09, 2013 at 09:48:33PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > For SDP server we need to bind to lower port, acquire this capability.
> > ---
> > android/main.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > configure.ac   |    4 ++++
> > 2 files changed, 75 insertions(+)
> > 
> > diff --git a/android/main.c b/android/main.c
> > index 7968ed0..a100013 100644
> > --- a/android/main.c
> > +++ b/android/main.c
> > @@ -32,6 +32,22 @@
> > #include <stdlib.h>
> > #include <stdbool.h>
> > #include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <sys/prctl.h>
> > +#include <linux/capability.h>
> > +
> > +/**
> > + * Include <sys/capability.h> for host build and
> > + * also for Android 4.3 when it is added to bionic
> > + */
> 
> why focus on anything before Android 4.3?

Because we have currently 4.2.2 and test with hardware running 4.2.2. Do
you want us to write theoretical code? And do you believe that Google
magically fix everything in 4.4?

Best regards 
Andrei Emeltchenko 
