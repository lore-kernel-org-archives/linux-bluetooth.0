Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 14:24:01 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Fix issue when setting limited discoverable mode
Message-ID: <20101028182401.GA1693@jh-x301>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 28, 2010, Luiz Augusto von Dentz wrote:
>  	if (discoverable && adapter->pairable && adapter->discov_timeout > 0 &&
> -						adapter->discov_timeout <= 60)
> +						adapter->discov_timeout <= 60) {
> +		adapter->mode = MODE_LIMITED;
>  		adapter_set_limited_discoverable(adapter, TRUE);

Wouldn't it make more sense to do the fix to adapter->mode inside the
adapter_set_limited_discoverable function?

Johan
