Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 7 Mar 2018 10:04:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix storage for adapters without public address
Message-ID: <20180307080441.GA28595@x1c>
References: <20180306132807.6149-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306132807.6149-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Mar 06, 2018, Szymon Janc wrote:
> Since those have adapter folder prefixed with "static-" this needs
> to be taken into account when storing data.
> ---
>  src/adapter.c | 26 +++++++++---------
>  src/adapter.h |  1 +
>  src/device.c  | 87 +++++++++++++++++++++++++++--------------------------------
>  3 files changed, 54 insertions(+), 60 deletions(-)

Applied. Thanks.

Johan
