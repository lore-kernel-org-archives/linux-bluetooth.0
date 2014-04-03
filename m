Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Apr 2014 10:20:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools: Fix bccmd build with GCC 4.9
Message-ID: <20140403072033.GA19304@t440s.lan>
References: <1396469715-6321-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1396469715-6321-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Apr 02, 2014, Szymon Janc wrote:
> Make sure accessing array[63 * 2 + 4] is legal.
> 
> tools/bccmd.c: In function ‘cmd_buildname’:
> tools/bccmd.c:406:18: error: iteration 63u invokes undefined behavior
>      [-Werror=aggressive-loop-optimizations]
>    name[i] = array[(i * 2) + 4];
> ---
>  tools/bccmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
