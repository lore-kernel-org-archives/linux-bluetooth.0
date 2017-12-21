Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 21 Dec 2017 16:58:49 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix remote advertising data
Message-ID: <20171221155849.GA417@x1c>
References: <20171221084339.6761-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221084339.6761-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 21, 2017, Szymon Janc wrote:
> Advertising Data doesn't have terminator field like EIR. This was
> causing error logs from kernel when data length was corrected.
> ---
>  android/tester-main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied. Thanks.

Johan
