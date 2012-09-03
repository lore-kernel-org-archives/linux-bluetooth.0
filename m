Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Sep 2012 15:01:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v3 2/2] rctest: add option to save received data to file
Message-ID: <20120903120104.GC30636@x220>
References: <1346446228-11105-1-git-send-email-gustavo@padovan.org>
 <1346446228-11105-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346446228-11105-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Aug 31, 2012, Gustavo Padovan wrote:
> +		if (save_fd < 0)
> +			syslog(LOG_ERR, "Failed to open file to save "
> +								"recv data");

Please don't split strings like this if not necessary. It makes greping
harder (you see something in the command output and try to locate it in
the source). Split after "LOG_ERR," instead.

> +static void sig_child_exit(int code)
> +{
> +	syslog(LOG_INFO, "Exit");
> +	exit(0);
> +
> +	if (save_fd >= 0)
> +		close(save_fd);
> +}

This doesn't look right as nothing after the exit() call will get
executed. I suppose you meant to ahve the save_fd closing before the
exit call?

Johan
