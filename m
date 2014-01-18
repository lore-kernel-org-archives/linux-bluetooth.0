Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android: Fix const to non-const issue on android-tester
Date: Sat, 18 Jan 2014 19:21:41 +0100
Message-ID: <7318034.u9cudaOnMb@athlon>
In-Reply-To: <1390056866-21560-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390056866-21560-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Saturday 18 January 2014 10:54:26 Anderson Lizardo wrote:
> According to definition from hardware/bluetooth.h, the "val" field does
> not have const modifier.
> 
> Fix clang errors like:
> 
> android/android-tester.c:760:14: error: initializing 'void *' with an
> expression of type 'const char (*)[18]' discards qualifiers
> [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
