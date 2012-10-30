Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Oct 2012 02:12:03 +0200
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYw==?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 04/10] sbc: Add msbc flag and generic C primitive
Message-ID: <20121030021203.7fd1249c@i7>
In-Reply-To: <CA+QXtDtX0q=Zs3yu1VV8+ZWmOQEtsxoR96QZ=_A8_ZREWiaO=Q@mail.gmail.com>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-5-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028011948.30f09efe@i7>
	<CA+QXtDtX0q=Zs3yu1VV8+ZWmOQEtsxoR96QZ=_A8_ZREWiaO=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 29 Oct 2012 07:47:03 +0100
"Dalleau, Frederic" <frederic.dalleau@intel.com> wrote:

> Hi Siarhei,
> 
> Thanks for review,

Hi Frederic. Thanks for providing the initial working prototype of
mSBC support and for your progress polishing the remaining rough edges.

> I mostly agree but have a few remarks.

> On Sun, Oct 28, 2012 at 12:19 AM, Siarhei Siamashka
> <siarhei.siamashka@gmail.com> wrote:
> > On Fri, 26 Oct 2012 19:20:30 +0200
> > If "position" was not decremented by 16 for 8 samples here, then you
> > would not need to do
> >         if (state->pending == state->position)
> >                 x += 8;
> > elsewhere.
> 
> Good idea, just note that in this case, one sample  (x[1]  = PCM(0 + 7
> * nchannels))
> will receive a negative index x[-7]. there is no technical problème
> just a matter of style.
> 
> 
> > One more nitpick about "sbc_encoder_process_input_s8". The old
> > variant was taking "position" as a function argument and returning
> > an updated position.
> 
> Addtionnally, sbc_encoder_process_input_s8 would return void, and
> state->position
> would be used directly from process_input function. However, it requires changes
> in the neon code, which I'd rather avoid for now. I can send a patch
> later for this one.

Not having the need for 'state->pending' actually allows to keep both
the arguments and return value intact for "sbc_encoder_process_input_*"
functions and make the changes a bit less invasive as a side effect.

It might be even possible to make all the even/odd block checks based on
address alignment instead of "position" divisibility by 16 and get rid
of "state->odd" variable. But this would either require increasing the
effect of SBC_ALIGNED attribute to 32 bytes and make the code
non-portable and GCC specific (right now at least the C implementation
should work correctly with any compiler). Or alternatively the "X"
buffer could be allocated with manual realignment just like the "priv"
struct here:
    http://git.kernel.org/?p=bluetooth/sbc.git;a=blob;f=sbc/sbc.c;h=f0c77c7cb546#l943
Which in turn may become rather invasive and wacky, so I wouldn't go
that far.

-- 
Best regards,
Siarhei Siamashka
