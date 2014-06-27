Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/5] Implement MDL disconnect and reconnect
Date: Fri, 27 Jun 2014 15:32:13 +0200
Message-ID: <5183728.I9e57dWrje@uw000953>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 27 of June 2014 00:30:41 Ravi kumar Veeramally wrote:
> Patshset introduces extra api in haltest tool (close_channel).
> PTS test case for MDL disconnect and reconnect expects only
> channel disconnection/close not deletion. It can not be called
> with current HAL api. This call just shutdown specified fd, which
> triggers channel disconnection. Another attempt for connection
> means simply start with reconnect request.
> 
> Ravi kumar Veeramally (5):
>   android/client/health: Introduce close_channel API.
>   android/health: Implement mdl_closed_cb callback
>   android/health: Fix deleting channels queue
>   android/health: Implement mdl reconnect
>   android/health: Implement destroy_channel call
> 
>  android/client/if-hl.c | 29 +++++++++++++++
>  android/health.c       | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 122 insertions(+), 5 deletions(-)
> 

All patches applied. Thanks. 

-- 
Best regards, 
Szymon Janc
