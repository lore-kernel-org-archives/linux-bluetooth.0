Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] shared/hfp: Add support for HFP HF - part 2
Date: Fri, 31 Oct 2014 20:32:49 +0100
Message-ID: <2651171.yOGlzQfTJK@leonov>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 10 of October 2014 01:50:44 Lukasz Rymanowski wrote:
> Following patches applies on:
> [PATCH v4 00/11] shared/hfp: Add support for HFP HF
> 
> This is last part of patches for HFP HF in shared code. Next ones
> will be done in android part.
> 
> This set mostly affects functions which help to parse hfp response.
> This has been unified so it can be used by hfp gw and hf.
> 
> Also handling of +CME ERROR has been added and couple of unit tests.
> 
> Sending it now as I want to get early comments on approach. Future work
> depends on it very much so I want to avoid too much rebasing.
> 
> Lukasz Rymanowski (8):
>   shared/hfp: Rename hfp_gw_result to hfp_context
>   shared/hfp: Rename hfp_hf_result to common hfp_context
>   shared/hfp: Rename functions operating on context
>   shared/hfp: Add handling +CME ERROR to parser
>   shared/hfp: Minor fix in container close function
>   shared/hfp: Add hfp_context_get_range function
>   unit/hfp: Add unit tests for parsing hfp_context
>   unit/hfp: Add test for +CME ERROR: response
> 
>  android/handsfree.c | 184 +++++++++++++++++++++++-----------------------
>  src/shared/hfp.c    | 207
> ++++++++++++++++++++++++++++++++-------------------- src/shared/hfp.h    | 
> 28 ++++---
>  unit/test-hfp.c     | 111 +++++++++++++++++++++++++---
>  4 files changed, 334 insertions(+), 196 deletions(-)

Those looks OK to me. Please send rebased version (and add clarifying comment 
in 4/8). Thanks.


-- 
BR
Szymon Janc
