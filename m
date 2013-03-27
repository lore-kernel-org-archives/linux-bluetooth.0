Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 10/17] sbc: Fix input reordering for 15 blocks case
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362565163-3567-11-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 19:20:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <500DB19C-20A5-40E0-B57B-502CE5EFAB76@holtmann.org>
References: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com> <1362565163-3567-11-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> SBC analysis handles 8 samples at a time. The optimisation requires 8 samples
> forming an "odd" block, followed by 8 samples, forming an "even" block. Until
> now SBC was used for encoding 4, 8, 12, or 16 blocks in a frame. Reordering
> took a frame and for each 16 samples (ie 2 blocks) it produced one "odd" block
> and one "even" block.
> A mSBC frame encodes 15 blocks of 8 samples. 14 blocks are processed as before,
> two at a time. If 8 samples are remaining, it will form the first half of two
> blocks (a bit of an "odd" block, and a bit of an "even" block). When processing
> the next frame, we detect eight samples were missing at previous iteration and
> the two block can be finished.
> 
> This reordering is possible because only one sample is moved (x[-7]) AND the
> first coefficient in the coef table is 0. Thus x[0] doesn't need to be set and
> 0 can be used in calculation instead. Note that x[-7] is not used in
> analysis for this block.
> see: analysis_consts_fixed8_simd_odd.
> 
> To detect that two blocks are not completed, the number of processed samples
> can be used. This value is stored in position. position starts at
> SBC_X_BUFFER_SIZE-72 and is decremented by 16 as long as two blocks can be
> formed. If only 8 samples are remaining in input, then position is decremented
> by 8 *arbitrarly*, thus indicating that some samples are pending. During next
> frame reordering, position will be decremented by 8 again, back to a 16
> multiple.
> 
> This logic works for SBC_X_BUFFER_SIZE-72 multiple of 16 and bigger than
> 8*2*15+72=312 and less than 8*3*15+72=432. The current value of 328 matches this
> constraint and X buffer is shifted every two frames (30 blocks) in mSBC. This
> way, we don't need to care about x[-7] when shifting, we also know that it
> won't be before X.
> ---
> sbc/sbc_primitives.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index 319e625..9c6e56a 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -6,6 +6,7 @@
>  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
>  *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
>  *  Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
> + *  Copyright (C) 2012       Intel Corporation

make it 2012-2013 now.

Regards

Marcel

