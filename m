Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 17:43:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make sure discovery don't interfere with bonding
Message-ID: <20100902144357.GA3212@jh-x301>
References: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 02, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> In situation where the user application keep a discovery session while
> bonding with a device it may cause a delay, or even timeout, due to the
> number of the inquiry responses that the controller has to process.
> 
> Since the discovery can be shared between many applications it may not be
> possible to simple require to each application to stop their discovery
> before trying to pair with a device, so to fix this bluetoothd now
> suspends the discovery while bonding, resuming when completed.
> ---
>  src/adapter.c |   62 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  src/adapter.h |    3 ++
>  src/device.c  |    4 +++
>  3 files changed, 57 insertions(+), 12 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
