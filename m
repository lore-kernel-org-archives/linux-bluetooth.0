Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/6] android/hal-audio: Fixes
Date: Mon, 03 Feb 2014 22:16:41 +0100
Message-ID: <3075172.1B9h1D5kHk@athlon>
In-Reply-To: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Monday 03 February 2014 17:55:43 Andrzej Kaczmarek wrote:
> v1 -> v2
> fixed build error introduced during rebase
> 
> 
> Andrzej Kaczmarek (6):
>   android/hal-audio: Remove unsupported mono channel mode
>   android/hal-audio: Be more verbose on SBC errors
>   android/hal-audio: Print calculated SBC parameters
>   android/hal-audio: Fix audio with large omtu value
>   android/hal-audio: Fix RTP sequence numbers
>   android/hal-audio: Add RTP timestamps
> 
>  android/hal-audio.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)

All patches in this set have been applied, thanks a lot.

-- 
Szymon K. Janc
szymon.janc@gmail.com
