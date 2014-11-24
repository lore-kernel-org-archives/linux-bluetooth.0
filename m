Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] shared/hfp: Improvements and fixes to HFP AG parser
Date: Mon, 24 Nov 2014 13:19:57 +0100
Message-ID: <11711981.YTePjHjpjq@leonov>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 20 of November 2014 16:55:07 Lukasz Rymanowski wrote:
> This set brings couple of fixes on parsing AT commands.
> This improves robustness.
> 
> Also some minor fixes has beed done here
> 
> Lukasz Rymanowski (8):
>   shared/hfp: Trivial, fix comments style
>   shared/hfp: Fix setting result pending flag
>   shared/hfp: Improve handling AT command
>   unit/test-hfp: Add test for reading \rAT+X\r
>   shared/hfp: Refactor call_prefix_handler
>   shared/hfp: Remove not used assignment
>   shared/hfp: Improve handling AT commands
>   unit/test-hfp: Fix parsing empty string test
> 
>  src/shared/hfp.c | 123
> +++++++++++++++++++++++++++++++++++--------------------
> unit/test-hfp.c  |  41
> ++++++++++++++++++-
>  2 files changed, 117 insertions(+), 47 deletions(-)

All patches applied, thanks.

-- 
BR
Szymon Janc
