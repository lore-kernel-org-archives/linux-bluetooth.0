Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 6 Mar 2018 09:47:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Fix bearer selection with single mode controller
Message-ID: <20180306074716.GA2732@x1c.lan>
References: <20180305161635.25898-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180305161635.25898-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 05, 2018, Szymon Janc wrote:
> If remote device is dual mode and advertises without "BR/EDR flag
> not supported" set than device is marked as supporting BR/EDR
> even if controller is doing LE only. This results in bluetoothd
> trying to connect over BR/EDR since this is prefered transport
> if none is connected.
> 
> Fix this by checking if adapter supports specified technology
> before doing heuristic transport selection.
> ---
>  src/adapter.c | 8 ++++++++
>  src/adapter.h | 1 +
>  src/device.c  | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
