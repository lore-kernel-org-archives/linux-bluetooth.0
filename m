Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 10:51:52 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 12/16] android: Add cap to bind to port < 1024
Message-ID: <20130930075150.GE10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <7348700.bQ9Re4jemt@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7348700.bQ9Re4jemt@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Sep 30, 2013 at 09:36:54AM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > For SDP server we need to bind to lower port, acquire this capability.
> > ---
> >  android/main.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  configure.ac   |    4 ++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/android/main.c b/android/main.c
> > index 5fef095..649867d 100644
> > --- a/android/main.c
> > +++ b/android/main.c
> > @@ -31,6 +31,19 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <sys/prctl.h>
> > +#include <linux/capability.h>
> > +
> > +/**
> > + * Include <sys/capability.h> for host build and
> > + * also for Android 4.3 when it is added to bionic
> > + */
> > +#if (defined(__ANDROID_API__) && (__ANDROID_API__ > 17)) || \
> > +					!defined(__ANDROID_API__)
> > +#include <sys/capability.h>
> > +#endif
> >  
> >  #include <glib.h>
> >  
> > @@ -319,6 +332,43 @@ static void cleanup_mgmt_interface(void)
> >  	mgmt_if = NULL;
> >  }
> >  
> > +static bool android_set_aid_and_cap()
> > +{
> > +	struct __user_cap_header_struct header;
> > +	struct __user_cap_data_struct cap;
> > +
> > +	DBG("%s: pid %d uid %d gid %d", __func__, getpid(), getuid(), getgid());
> 
> DBG macro already adds function name to string so there is no need to double
> that. This applies to other places as well.

Yes, I forgot to remove that when changed debug to DBG.

Best regards 
Andrei Emeltchenko 

