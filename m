Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Richard Palethorpe <richard@lm-technologies.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: Fix compilation error in C++ due to inline function
Date: Fri, 27 Mar 2015 11:59:38 +0100
Message-ID: <35689164.lY2YZdPzLT@leonov>
In-Reply-To: <CAFSTUk7pB_V6ossJAGUmvK6HGuQ2qLAdTzENH76VTzKRgy9SUg@mail.gmail.com>
References: <1427208744-11805-1-git-send-email-richard@lm-technologies.com> <2438722.WgYkM0ao6e@leonov> <CAFSTUk7pB_V6ossJAGUmvK6HGuQ2qLAdTzENH76VTzKRgy9SUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 27 of March 2015 10:53:05 Richard Palethorpe wrote:
> Hello Szymon,
> 
> Sorry, I haven't submitted a patch before, so should I add the spaces
> then resubmit it as [PATCH V2] with it signed off by you?

Yes, please resend as [PATCH V2]. Since we don't use SOB in userspace code 
don't add any.

Also put sample compilation error in commit message (we usually do that for 
compilation fix patches).

And please don't top post.

> 
> On Fri, Mar 27, 2015 at 7:40 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Hi Richard,
> > 
> > On Tuesday 24 of March 2015 14:52:24 Richard Palethorpe wrote:
> >> This adds explicit typecasts to an inline function to make it C++
> >> compatible. ---
> >> 
> >>  lib/bluetooth.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> >> index 6ca64b6..ab24443 100644
> >> --- a/lib/bluetooth.h
> >> +++ b/lib/bluetooth.h
> >> @@ -345,8 +345,8 @@ typedef struct {
> >> 
> >>  static inline void bswap_128(const void *src, void *dst)
> >>  {
> >> 
> >> -     const uint8_t *s = src;
> >> -     uint8_t *d = dst;
> >> +     const uint8_t *s = (const uint8_t *)src;
> >> +     uint8_t *d = (uint8_t *)dst;
> >> 
> >>       int i;
> > 
> > Just a nitpick: there should be space after cast
> > (see M5 in doc/coding-style.txt).
> > 
> >>       for (i = 0; i < 16; i++)
> > 
> > Other than that patch looks good to me.
> > 
> > --
> > BR
> > Szymon Janc

-- 
BR
Szymon Janc
