Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3] android: Add initial MCAP common code
Date: Mon, 07 Apr 2014 13:41:23 +0200
Message-ID: <14555936.fs64HG9Pl0@uw000953>
In-Reply-To: <1396867385-26545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1396867385-26545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 07 of April 2014 13:43:05 Ravi kumar Veeramally wrote:
> The patch keeps all MCAP specific logic in mcap-lib until it receives
> proper unit tests and then eventually will be used by health profile
> code as well.
> ---
> v3: Fixed Szymon's comments (Copyright and android build issues)
> ---
>  android/Android.mk  |    1 +
>  android/Makefile.am |    1 +
>  android/mcap-lib.c  | 3154 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/mcap-lib.h  |  441 +++++++
>  4 files changed, 3597 insertions(+)
>  create mode 100644 android/mcap-lib.c
>  create mode 100644 android/mcap-lib.h

Pushed. Thanks.

-- 
Best regards, 
Szymon Janc
