Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jan 2014 13:39:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Fix discovering new devices
Message-ID: <20140114113920.GD4709@x220.p-661hnu-f1>
References: <1389691863-4827-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389691863-4827-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jan 14, 2014, Szymon Janc wrote:
> +	} else {
> +		GSList *l;
> +
> +		for(l = devices; l; l = g_slist_next(l)) {

Coding style thing here (space after 'for'). You might wanna consider a
helper function and g_slist_foreach here tough.

> +static bool device_found_needed(struct device *dev)
> +{
> +	if (!dev)
> +		return true;
> +
> +	if (dev->bond_state == HAL_BOND_STATE_BONDED)
> +		return false;
> +
> +	return !dev->found;
> +}

I think you should provide lots more code comments here with proper
explanations of each if-statement. E.g. your commit message doesn't
mention anything about bonded devices and yet you have a check for this
state here.

Johan
