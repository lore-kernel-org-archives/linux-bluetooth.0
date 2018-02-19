Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 19 Feb 2018 19:16:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] adapter: Fix not clearing connectable setting on
 power off
Message-ID: <20180219171620.GA21899@x1c.home>
References: <20180219124335.16528-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180219124335.16528-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Feb 19, 2018, Szymon Janc wrote:
> When kernel control of connectable is used daemon doesn't enable
> connectable setting unless discoverable. Both settings are permanent
> over power toggle unless discoverable timeout was set. In that case
> discoverable flag is cleared by kernel on power off. This leads to
> connectable flag being left enabled when toggling power on discoverable
> adapter with timeout set.
> 
> This has some implications on system behaviour:
>  - accepting connection from unknown devices
>  - not being able to advertise as broadcaster
> 
> Since kernel doens't know the reason for enabling connectable flag (and
> thus if disable if on power off) this needs to be handled in bluetoothd.
> ---
>  src/adapter.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Applied. Thanks.

Johan
