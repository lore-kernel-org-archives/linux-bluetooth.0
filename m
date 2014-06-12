Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC_v2 0/6] HDP initial implementaion
Date: Thu, 12 Jun 2014 12:10:41 +0200
Message-ID: <14170751.VX3tVODdaQ@uw000953>
In-Reply-To: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tuesday 10 of June 2014 16:21:57 Ravi kumar Veeramally wrote:
> v2: Fixed comments by szymon and fixed issues while sebastian
> testing with PTS.
> 
> v1: patchset is initial implementaion for HDP at daemon side.
> Cacheing application data and prepare SDP record based on MDEPs
> configuration and notify app state.
> 
> Ravi kumar Veeramally (6):
>   android/hal-ipc-txt: Update Health MDEP command parameter
>   android/health: Fix MDEP data type is 2 octets
>   android/health: Cache health application data on app register call
>   android/health: Perform clean up on app unregister call
>   android/health: Add HDP SDP record
>   android/health: Notify application registration status
> 
>  android/hal-ipc-api.txt |   5 +-
>  android/hal-msg.h       |   2 +-
>  android/health.c        | 712 +++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 707 insertions(+), 12 deletions(-)
> 
> 

I applied patches 1 and 2. Thanks.

-- 
Best regards, 
Szymon Janc
