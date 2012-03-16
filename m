Return-Path: <cyrus@holtmann.org>
Message-ID: <1331914843.14217.160.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value
 to DeviceID source
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Fri, 16 Mar 2012 09:20:43 -0700
In-Reply-To: <20120316161310.GC22160@x220>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
	 <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
	 <20120316150615.GB19444@joana> <20120316161310.GC22160@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > Reply with MGMT_STATUS_INVALID_PARAMS when userspace is trying to set
> > > source with out-of-scope value.
> > > 
> > > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > > ---
> > >  net/bluetooth/mgmt.c |    9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > This one should go to bluetooth.git first.
> > 
> > Acked-by: Gustavo Padovan <gustavo@padovan.org>
> 
> I went ahead and applied both directly to my bluetooth-next tree. I
> don't think this one is critical enough to deserve to go to
> bluetooth.git.

you are both kidding me here right now, right? Of course this is not
going into bluetooth.git since it is not even in net-next or scheduled
for the next merge window.

And nothing goes into bluetooth.git first (unless it only applies
there). Everything goes into bluetooth-next.git first.

Regards

Marcel


