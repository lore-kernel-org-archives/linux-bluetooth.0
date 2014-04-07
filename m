Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android: Avoid creating symlinks in lib/
Date: Mon, 07 Apr 2014 12:41:21 +0200
Message-ID: <3048481.QmgHSPWbzg@uw000953>
In-Reply-To: <1396857132-14596-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1396857132-14596-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Monday 07 of April 2014 09:52:11 Andrzej Kaczmarek wrote:
> This patch add bluetooth-headers module which is fake static library
> to provide headers from lib/ directory in proper manner, i.e. from
> bluetooth/ directory. Headers are copied to intermediates directory
> and proper include path is added by build system once dependency to
> this module is added. It's not longer necessary to specify lib/
> directory on include path for each module.
> 
> This is to avoid modyfing source repository by creating symlinks in
> lib/ directory - now it's possible to build BlueZ without touching
> source repository at all.
> ---
>  android/Android.mk | 64 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 25 deletions(-)

Both patches applied. Thanks a lot.

-- 
Best regards, 
Szymon Janc
