Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 10:37:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 10/11] android/hid: Add virtual unplug implemention in
 daemon
Message-ID: <20131108083701.GA15597@x220.p-661hnu-f1>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383862220-29968-11-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383862220-29968-11-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> +	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
> +
> +	if (write(fd, &hdr, sizeof(hdr)) < 0) {
> +		error("error while virtual unplug command");
> +		return HAL_STATUS_FAILED;
> +	}
> +
> +	/* Wait either channels to HUP */
> +	if (dev->intr_io)
> +		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
> +
> +	if (dev->ctrl_io)
> +		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);

This looks a bit suspicious. First you try to get the fd from ctrl_io
without checking if it's NULL and then later you have an explicit check
for whether it is NULL or not. Is there some check missing earlier in
the function?

Johan
