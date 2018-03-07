Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 7 Mar 2018 10:06:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Fix missing Paired property change on non-bonded
 device
Message-ID: <20180307080631.GB28595@x1c>
References: <20180306141514.7413-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306141514.7413-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Mar 06, 2018, Szymon Janc wrote:
> If device is paired but not bonded than Paired property should be
> also updated when device is disconnected.
> ---
>  src/device.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
