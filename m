Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121028011948.30f09efe@i7>
References: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1351272036-4875-5-git-send-email-frederic.dalleau@linux.intel.com>
	<20121028011948.30f09efe@i7>
Date: Mon, 29 Oct 2012 07:47:03 +0100
Message-ID: <CA+QXtDtX0q=Zs3yu1VV8+ZWmOQEtsxoR96QZ=_A8_ZREWiaO=Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sbc: Add msbc flag and generic C primitive
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

Thanks for review, I mostly agree but have a few remarks.

On Sun, Oct 28, 2012 at 12:19 AM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Fri, 26 Oct 2012 19:20:30 +0200
> If "position" was not decremented by 16 for 8 samples here, then you
> would not need to do
>         if (state->pending == state->position)
>                 x += 8;
> elsewhere.

Good idea, just note that in this case, one sample  (x[1]  = PCM(0 + 7
* nchannels))
will receive a negative index x[-7]. there is no technical problème
just a matter of style.


> One more nitpick about "sbc_encoder_process_input_s8". The old
> variant was taking "position" as a function argument and returning
> an updated position.

Addtionnally, sbc_encoder_process_input_s8 would return void, and
state->position
would be used directly from process_input function. However, it requires changes
in the neon code, which I'd rather avoid for now. I can send a patch
later for this one.

Regards,
Frédéric
