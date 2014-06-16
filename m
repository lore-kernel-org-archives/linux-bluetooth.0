Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 0/6] HDP initial implementaion
Date: Mon, 16 Jun 2014 18:41:10 +0200
Message-ID: <15250945.IhVFAen3Aa@athlon>
In-Reply-To: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 16 June 2014 18:01:34 Ravi kumar Veeramally wrote:
> v2: Fixed comments from Szymon (optimized cache patch,
>     split notify patch, other issues).
> v1: Fixed comments from szymon.
> 
> RFC_v2: Fixed comments by szymon and fixed issues while sebastian
> testing with PTS.
> 
> RFC_v1: patchset is initial implementaion for HDP at daemon side.
> Cacheing application data and prepare SDP record based on MDEPs
> configuration and notify app state.
> 
> Ravi kumar Veeramally (6):
>   android/health: Cache health application data on app register call
>   android/health: Perform clean up on app unregister call
>   android/health: Add HDP SDP record
>   android/health: Notify application registration status
>   android/health: Notify application deregistration status
>   profile/health: Free sdp list after adding it to record
> 
>  android/health.c           | 717
> ++++++++++++++++++++++++++++++++++++++++++++- profiles/health/hdp_util.c | 
>  2 +
>  2 files changed, 711 insertions(+), 8 deletions(-)

Patches 1-5 are now applied (with changes we discussed on IRC), thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
