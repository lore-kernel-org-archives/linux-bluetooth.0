Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 29 Nov 2016 16:36:40 -0500
From: Don Zickus <dzickus@redhat.com>
To: Brennan Ashton <brn@deako.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: d-bus or management api for beacon stuff
Message-ID: <20161129213640.GA35881@redhat.com>
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
> > > I have had to resort to using the HCI interface to work with
> > > scanning
> > > and advertising beacon packets.  I had mentioned in an earlier
> > > thread
> > > the issue with duplicates.  Not only do you end up with a lot of
> > > spam
> > > on the dbus interface you end up with an ever increasing number of
> > > bluetooth devices.  The Bluetooth mesh uses this transport, so I
> > > really
> > > would like to see a nice interface to support rx/tx of these
> > > packets.
> > 
> > Hi,
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

Yup, I saw that thread earlier and that flag.  I wasn't sure how that flag
was being propagated.  Does it go right to the device?  I guess I thought
the kernel was filtering duplicates, but perhaps not?

Cheers,
Don
