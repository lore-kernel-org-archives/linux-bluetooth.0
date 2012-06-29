Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:25:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] audio: Remove not needed NULL pointer checks
Message-ID: <20120629112552.GA24842@x220>
References: <1339617199-5490-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339617199-5490-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jun 13, 2012, Szymon Janc wrote:
> g_new0 always returns valid pointer and there is no need to check that.
> ---
>  audio/a2dp.c  |    2 --
>  audio/avctp.c |    2 --
>  audio/avdtp.c |    2 --
>  audio/avrcp.c |    2 --
>  4 files changed, 8 deletions(-)

Applied. Thanks.

Johan
