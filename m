Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 May 2014 20:41:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] code: Improve handling of unpaired event
Message-ID: <20140519174128.GA27959@t440s.P-661HNU-F1>
References: <1400520830-12651-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400520830-12651-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, May 19, 2014, Szymon Janc wrote:
> Unpaired event is per bearer and and bluetoothd should unpair device
> only on that bearer.
> ---
>  src/adapter.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  src/device.c  | 32 ++++++++++++++++++++++++++++++++
>  src/device.h  |  1 +
>  3 files changed, 71 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
