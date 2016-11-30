Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 30 Nov 2016 15:15:41 -0500
From: Don Zickus <dzickus@redhat.com>
To: Brennan Ashton <brn@deako.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: d-bus or management api for beacon stuff
Message-ID: <20161130201541.GR35881@redhat.com>
References: <20161123214013.GZ35881@redhat.com>
 <CABBYNZKYf3b8zTzGFNqd_3LGxYZkgo_g4LRs=jf=_qYS3fj1vA@mail.gmail.com>
 <20161128205526.GP35881@redhat.com>
 <CAAu3APY8oK4O57fbwzULRHiMnVT+75KQEbOaAEQRp-W6rJaWHw@mail.gmail.com>
 <CABBYNZ+7n3HR50ENp-Zjjb0uUM=YPPpP5ndRA38w9+gqXROFRw@mail.gmail.com>
 <1480449363.19570.6.camel@deako.com>
 <20161129210137.GX35881@redhat.com>
 <1480454922.19570.9.camel@deako.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1480454922.19570.9.camel@deako.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 29, 2016 at 01:28:42PM -0800, Brennan Ashton wrote:
> > 
> > Sorry for being ignorant (as I can't quite find the filter duplicate
> > code
> > other than the setting of the bit), but would throttling work
> > here?  Cap the
> > duplicates at say every 100ms or 10x/second.  That probably won't
> > help with
> > power consumption (unless start/stop of the radio is quick?).
> > 
> > Just trying to help move this along..  willing to code/test.
> > 
> > Cheers,
> > Don
> > 
> The thread I mentioned is here:
> https://marc.info/?t=147345134200002&r=1&w=2
> 
> The constant of interest is this LE_SCAN_FILTER_DUP_ENABLE.  I had to
> recompile with this disabled because I never wanted the filter for my
> application.  I had proposed making this an option in the adaptor
> interface, but there did not seem to be any interest.

Hi Brennan,

Looking through the code, I am guessing you hacked up

net/bluetooth/hci_request.c::active_scan to set enable_cp.filter_dup = 0?

How did that turn out?  Was there a lot of volume?

I am running 'hcitool lescan --duplicates' with a couple of cc2650 tags I
have (one custom fw) and see about 20-25 adv/second.  That doesn't seem so
bad.

What type of numbers did you see?

Cheers,
Don

