Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jun 2014 11:47:43 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/17] mcap: Fix possible overflow
Message-ID: <20140618084741.GD12463@aemeltch-MOBL1>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1402905472-17643-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <13363908.gOkADGD5ib@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13363908.gOkADGD5ib@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jun 17, 2014 at 11:11:01PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 16 June 2014 10:57:44 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > ---
> >  profiles/health/mcap_sync.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
> > index cc89d47..a0cc02a 100644
> > --- a/profiles/health/mcap_sync.c
> > +++ b/profiles/health/mcap_sync.c
> > @@ -187,7 +187,7 @@ void mcap_sync_stop(struct mcap_mcl *mcl)
> > 
> >  static uint64_t time_us(struct timespec *tv)
> >  {
> > -	return tv->tv_sec * 1000000 + tv->tv_nsec / 1000;
> > +	return tv->tv_sec * 1000000ll + tv->tv_nsec / 1000ll;
> >  }
> > 
> >  static int64_t bt2us(int bt)
> 
> Commit message explaining why there is possible overflow would be nice.
> 

We have this 'll' in newer code dealing with similar conversions, I suppose
we might use 32 bit arithmetic and then widen to 64 bit.

Best regards 
Andrei Emeltchenko 
