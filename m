Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 30 Oct 2014 00:34:42 +0100
Message-ID: <CAN_7+YZfdxiYnEjzQCVpy2EDtXZLdHvnPcV6BCq3cYx_BvMdJg@mail.gmail.com>
Subject: Re: [PATCH 0/8] shared/hfp: Add support for HFP HF - part 2
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 10, 2014 at 1:50 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
>
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
>  src/shared/hfp.c    | 207 ++++++++++++++++++++++++++++++++--------------------
>  src/shared/hfp.h    |  28 ++++---
>  unit/test-hfp.c     | 111 +++++++++++++++++++++++++---
>  4 files changed, 334 insertions(+), 196 deletions(-)
>
Ping

This set requires rebase but before I do that it would be nice to get
any comments on that (if any)

\Lukasz
>
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
