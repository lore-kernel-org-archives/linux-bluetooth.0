Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 0/4] Add HDP profile support at HAL side
Date: Mon, 17 Mar 2014 14:54:43 +0100
Message-ID: <2104414.ho3njAVuqA@leonov>
In-Reply-To: <1394803858-10052-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394803858-10052-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 14 of March 2014 15:30:54 Ravi kumar Veeramally wrote:
> v3: Patch set contains 10-13 from v2. Solved Szymon comments (strings
>  copying to byte array with null terminated character).
> 
> v2: Solved Luiz, Szymon, Andrzej and Grzegorz comments.
> 
> v1: Patch set contains HDP profile support at HAL side and initial
>  profile registration support at daemon side.
> 
> Ravi kumar Veeramally (4):
>   android/hal-health: Add HDP .register_application method
>   android/hal-health: Add HDP .unregister_application method
>   android/hal-health: Add HDP .connect_channel method
>   android/hal-health: Add HDP .destroy_channel method
> 
>  android/hal-health.c | 175
> +++++++++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 171
> insertions(+), 4 deletions(-)

I've applied patches 2-4 so no need to resend them.

-- 
BR
Szymon Janc
