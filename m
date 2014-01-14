Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/15] android/tester: Fix for asynchronous test case condition check
Date: Tue, 14 Jan 2014 19:43:51 +0100
Message-ID: <3520169.Cnd9CED0pn@athlon>
In-Reply-To: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389707686-30766-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 14 January 2014 14:54:32 Grzegorz Kolodziejczyk wrote:
> This patch fixes checking the state of test case. Due to asynchronous of
> callbacks during state check of every single condition, state can be
> checked double time by callback condition check with pass status already
> set in meantime. Now state is kept as one decremented int.
> To pass it must be equal zero and cannot be checked set again.
> 
> Change-Id: I595c9f9606f1da41218a85c62c07881bd7bd8ee8
> ---
>  android/android-tester.c | 44 ++++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)

All patches in this set are now upstream, thanks.

(I fixed Change-Id in 1/15 myself but please pay attention on this in future 
patches)

-- 
Szymon K. Janc
szymon.janc@gmail.com
