Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 00/10] shared\hfp: Add support for HFP-HF
Date: Wed, 05 Nov 2014 08:54:21 +0100
Message-ID: <2683632.9sIy0RRORA@uw000953>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 03 of November 2014 10:35:51 Lukasz Rymanowski wrote:
> This set is continuation of adding support for HFP-HF.
> Most of the patches is refactor of handling hfp result.
> No it is commong hfp_context which can be parsed by GW and HF
> with API funtions hfp_context_*
> 
> There is also CME ERROR handling added and couple of unit test.
> 
> v2
> * rebase
> * Handled Marcin comment.
> * Added two more patches for skipping field in hfp_context 
> 
> Lukasz Rymanowski (10):
>   shared/hfp: Rename hfp_gw_result to hfp_context
>   shared/hfp: Rename hfp_hf_result to common hfp_context
>   shared/hfp: Rename functions operating on context
>   shared/hfp: Add handling +CME ERROR to parser
>   shared/hfp: Minor fix in container close function
>   shared/hfp: Add hfp_context_get_range function
>   unit/hfp: Add unit tests for parsing hfp_context
>   unit/hfp: Add test for +CME ERROR: response
>   shared/hfp: Add function to skip field in hfp_context
>   unit/test-hfp: Test for skip hfp_context field
> 
>  android/handsfree.c | 184 ++++++++++++++++++++--------------------
>  src/shared/hfp.c    | 237 +++++++++++++++++++++++++++++++++-------------------
>  src/shared/hfp.h    |  35 ++++----
>  unit/test-hfp.c     | 136 +++++++++++++++++++++++++++---
>  4 files changed, 389 insertions(+), 203 deletions(-)
> 

All patches applied, thanks. 

-- 
Best regards, 
Szymon Janc
