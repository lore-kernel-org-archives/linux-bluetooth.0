Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 0/5] Implement disconenct and reconnect
Date: Mon, 30 Jun 2014 21:59:56 +0200
Message-ID: <2908792.A2SPhYzojf@athlon>
In-Reply-To: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 30 June 2014 19:58:23 Ravi kumar Veeramally wrote:
> v2: Fixed Szymon's comment.
> 
> v1: Patchset supports incoming MCL and MDL disconnection and
> reconnection.
> 
> Ravi kumar Veeramally (5):
>   android/health: Implement mcl_disconnected cb
>   android/health: Implement mcl_uncached callback
>   android/health: Fix do not set mdl callbacks on mcl_reconneced call
>     back
>   android/health: Implement MDL reconnection from remote device
>   android/health: Update PTS result
> 
>  android/health.c    | 127
> +++++++++++++++++++++++++++++++++++++++++++++++----- android/pts-hdp.txt | 
> 24 ++++++++--
>  2 files changed, 136 insertions(+), 15 deletions(-)

All patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
