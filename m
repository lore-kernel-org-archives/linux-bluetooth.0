Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 18:44:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v3] android: Add set/get for discovery timeout
Message-ID: <20131107164431.GA30100@x220.p-661hnu-f1>
References: <1383839864-5470-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383839864-5470-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 07, 2013, Lukasz Rymanowski wrote:
> Android handles discoverable timeout in Settings app, however still
> expects BT stack to maintain this value so we should do it as well.
> Otherwise we will get some unexpected behaviour.
> For now we keep discovery_timeout only during runtime, but we need to move
> it to some local storage once we will have it.
> 
> Note: That since Android Settings up handles timer there is no reason to
> use discovery timer we have in kernel.
> ---
>  android/adapter.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)

Applied, but I still had to tweak around the coding style a bit:

> +	memcpy(&ev->props[0].val, &adapter->discoverable_timeout,
> +						sizeof(uint32_t));

You can indent this second line more here. General rule is indent as
long as you stay under 80 characters.

> +	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
> +				HAL_EV_ADAPTER_PROPS_CHANGED,
> +					sizeof(buf), ev, -1);

Here you're not only under-indented but the second continuation line
doesn't match the first continuation line (the coding style is to keep
lines 2-n with the same indentation).

Johan
