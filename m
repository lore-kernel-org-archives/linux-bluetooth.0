Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Nov 2011 17:59:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Create a unique mgmt error code hierarchy
Message-ID: <20111111155926.GA32446@fusion.localdomain>
References: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
 <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_PLSU5wckLrXRjnL8WJb-YAq49s1oMwA_Y72rTbE_pPEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PLSU5wckLrXRjnL8WJb-YAq49s1oMwA_Y72rTbE_pPEQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Nov 11, 2011, Anderson Lizardo wrote:
> On Fri, Nov 11, 2011 at 10:18 AM,  <johan.hedberg@gmail.com> wrote:
> > +#ifndef NELEM
> > +#define NELEM(arr) (sizeof(arr) / sizeof((arr)[0]))
> > +#endif
> > +
> 
> What about using ARRAY_SIZE() from  kernel.h ?
> 
> include/linux/kernel.h:#define ARRAY_SIZE(arr) (sizeof(arr) /
> sizeof((arr)[0]) + __must_be_array(arr))

Yeah, I was looking for something like that but failed to find it.
Thanks for the pointer! I'll send an updated patch soon.

Johan
