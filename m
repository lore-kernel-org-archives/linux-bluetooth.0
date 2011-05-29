Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:26:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Add messages backend initialization and
 finalization
Message-ID: <20110529192630.GI32088@dell.ger.corp.intel.com>
References: <1306391182-11550-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306391182-11550-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, May 26, 2011, Slawomir Bochenski wrote:
> +	tmp = getenv("HOME");
> +	if (!tmp)
> +		return -1;

Try to use return -<some suitable POSIX errno> whenever possible. This
makes error tracking easier in the long run when some higher layer in
the call stack logs the error and you don't have to figure out which of
the 10 places with "return -1" on the lower layers was the cause of it.
Yes, we might have existing places with -1 in the code, but I'd
appreciate if we didn't do it at least for new code.

Johan
