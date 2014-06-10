Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/7] HDP initial implementaion
Date: Tue, 10 Jun 2014 14:58:10 +0200
Message-ID: <1866125.RrnrpgSxxZ@uw000953>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 09 of June 2014 17:28:07 Ravi kumar Veeramally wrote:
> This patchset is initial implementaion for HDP at daemon side.
> Cacheing application data and prepare SDP record based on MDEPs
> configuration and notify app state.
> 
> Ravi kumar Veeramally (7):
>   android/hal-health: Fix passing buf not cmd for passing data
>   android/hal-msg: Add application id to mdep config cmd struct
>   android/health: Cache health application data on app register call
>   android/health: Perform clean up on app unregister call
>   android/health: Add HDP SDP record
>   android/hal-health: Add app state event handler
>   android/health: Notify application registration status
> 
>  android/hal-health.c |  16 +-
>  android/hal-msg.h    |   1 +
>  android/health.c     | 710 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 717 insertions(+), 10 deletions(-)

Patches 1,2 and 6 are now applied. Thanks. 

-- 
Best regards, 
Szymon Janc
