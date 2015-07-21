Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Atul Rai <a.rai@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] android/client/if-bt.c: Fix memory leak while using realloc()
Date: Tue, 21 Jul 2015 14:22:15 +0200
Message-ID: <1908230.joeMt6gWeu@leonov>
In-Reply-To: <1437480104-10197-1-git-send-email-a.rai@samsung.com>
References: <1437480104-10197-1-git-send-email-a.rai@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Tuesday 21 of July 2015 17:31:44 Atul Rai wrote:
> ping

I looks like I never got the original patch.

> > ------- Original Message -------
> > Sender : Atul Kumar Rai<a.rai@samsung.com> Lead Engineer (1)/SRI-Delhi-SWC
> > Group/Samsung Electronics Date : Jun 23, 2015 13:38 (GMT+05:30)
> > Title : [PATCH] android/client/if-bt.c: Fix memory leak while using
> > realloc()

Patch prefix "android/client" should be enough.

> > 
> > While reallocating space to store additional "remote device set" using
> > realloc, if realloc() fails, the original block is left untouched but
> > reference to that block is lost as NULL is assigned to remote_devices.
> > The original block needs to be freed before return.
> > 
> > Signed-off-by: Atul Rai <a.rai@samsung.com>

Please remove Signed-off-by as we don't use it for userspace patches.

> > ---
> > 
> >  android/client/if-bt.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> > index 4723024..4f0c2e9 100644
> > --- a/android/client/if-bt.c
> > +++ b/android/client/if-bt.c
> > @@ -94,6 +94,7 @@ static int remote_devices_capacity = 0;
> > 
> >  void add_remote_device(const bt_bdaddr_t *addr)
> >  {
> >  
> >  	int i;
> > 
> > +	bt_bdaddr_t *tmp = NULL;

No need to initialize it.

> > 
> >  	if (remote_devices == NULL) {
> >  	
> >  		remote_devices = malloc(4 * sizeof(bt_bdaddr_t));
> > 
> > @@ -119,9 +120,17 @@ void add_remote_device(const bt_bdaddr_t *addr)
> > 
> >  	/* Realloc space if needed */
> >  	if (remote_devices_cnt >= remote_devices_capacity) {
> >  	
> >  		remote_devices_capacity *= 2;
> > 
> > +		/*
> > +		 * Save reference to previously allocated memory block so that
> > +		 * it can be freed in case realloc fails.
> > +		 */
> > +		tmp = remote_devices;
> > +
> > 
> >  		remote_devices = realloc(remote_devices, sizeof(bt_bdaddr_t) *
> >  		
> >  						remote_devices_capacity);
> >  		
> >  		if (remote_devices == NULL) {
> > 
> > +			if (NULL != tmp)
> > +				free(tmp);

free() already checks for NULL pointer so no need to double check it.

> > 
> >  			remote_devices_capacity = 0;
> >  			remote_devices_cnt = 0;
> >  			return;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
BR
Szymon Janc
