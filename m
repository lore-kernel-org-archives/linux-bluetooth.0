Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-pan: Update control_state callback to Android 5 API
Date: Fri, 07 Nov 2014 10:17:07 +0100
Message-ID: <2180843.i8oFEmJdVo@uw000953>
In-Reply-To: <545C8C62.7030108@linux.intel.com>
References: <1415346380-23275-1-git-send-email-szymon.janc@tieto.com> <545C8C62.7030108@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 07 of November 2014 11:09:54 Ravi kumar Veeramally wrote:
> Hi Szymon,
> 
> On 11/07/2014 09:46 AM, Szymon Janc wrote:
> > Callback declaration was changed in Android 5 so parameters order must
> > be updated. Android Framework was also updated so we don't need
> > workaround for it in Android 5.
> > ---
> >   android/hal-pan.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/android/hal-pan.c b/android/hal-pan.c
> > index d9e042a..56fd340 100644
> > --- a/android/hal-pan.c
> > +++ b/android/hal-pan.c
> > @@ -19,6 +19,7 @@
> >   #include <stddef.h>
> >   #include <string.h>
> >   
> > +#include "hal-utils.h"
> >   #include "hal-log.h"
> >   #include "hal.h"
> >   #include "hal-msg.h"
> > @@ -45,19 +46,25 @@ static void handle_ctrl_state(void *buf, uint16_t len, int fd)
> >   {
> >   	struct hal_ev_pan_ctrl_state *ev = buf;
> >   
> > +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> > +	if (cbs->control_state_cb)
> > +		cbs->control_state_cb(ev->state, ev->local_role, ev->status,
> > +							(char *)ev->name);
> > +#else
> >   	/*
> > -	 * FIXME: Callback declared in bt_pan.h is 'typedef void
> > +	 * Callback declared in bt_pan.h is 'typedef void
> >   	 * (*btpan_control_state_callback)(btpan_control_state_t state,
> >   	 * bt_status_t error, int local_role, const char* ifname);
> >   	 * But PanService.Java defined it wrong way.
> >   	 * private void onControlStateChanged(int local_role, int state,
> >   	 * int error, String ifname).
> >   	 * First and third parameters are misplaced, so sending data according
> > -	 * to PanService.Java, fix this if issue fixed in PanService.Java.
> > +	 * to PanService.Java.
> >   	 */
> >   	if (cbs->control_state_cb)
> >   		cbs->control_state_cb(ev->local_role, ev->state, ev->status,
> >   							(char *)ev->name);
> > +#endif
> >   }
> >   
> >   /*
> 
> Have you verified E2E and android-tester also after updating this. E2E 
> tests might brake.

For KK this works as expected, once we switch to L headers E2E tester will be
updated to reflect this change.

-- 
Best regards, 
Szymon Janc
