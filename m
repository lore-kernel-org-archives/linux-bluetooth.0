Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:18:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: Re: [PATCH BlueZ v2] Fix remove emitting Paired=false when deleting
 device
Message-ID: <20110927091807.GR3952@dell>
References: <1316545790-3065-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316545790-3065-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Sep 20, 2011, Dmitriy Paliy wrote:
> When adapter is requested to remove device, device's property
> Paired=false is emitted after the adapter notifies clients that
> list Devices is empty. Some clients get confused.
> 
> Emitting property was introduced in clean-up patch
> c92a4af85f480c16f3ff017783c821304c899ce5. Since such notification
> does not have practical meaning, it is better to remove it.
> ---
>  src/device.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
