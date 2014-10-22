Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Oct 2014 16:37:44 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] bnep: Return errno instead of -1 and print error
Message-ID: <20141022133742.GA14103@aemeltch-MOBL1>
References: <1413976251-32402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1413976251-32402-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAMv5Gbck+=b9kY-s+gd3shJsLUDAEZib5dKGM09ZBWkP==ufFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMv5Gbck+=b9kY-s+gd3shJsLUDAEZib5dKGM09ZBWkP==ufFw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, Oct 22, 2014 at 02:55:54PM +0200, Grzegorz Kolodziejczyk wrote:
> Hi Andrei,
> 
> On 22 October 2014 13:10, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Make code consistent with the rest returning -errno and printing error
> > message.
> > ---
> >  profiles/network/bnep.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> > index 4cf38d9..09d4b65 100644
> > --- a/profiles/network/bnep.c
> > +++ b/profiles/network/bnep.c
> > @@ -231,7 +231,7 @@ static int bnep_if_down(const char *devname)
> >         if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
> >                 err = -errno;
> >                 error("bnep: Could not bring down %s: %s(%d)",
> > -                               devname, strerror(-err), -err);
> > +                                               devname, strerror(-err), -err);
> 
> Why don't you fix this indention in first patch ? (this line is added
> in previous patch)

Sorry, resend the series.

Best regards 
Andrei Emeltchenko 

