Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 21:31:21 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	ulrik.lauren@stericsson.com, henrik.possung@stericsson.com
Subject: Re: [PATCH 2/2] Bluetooth: Fix usage of sk_sndtimeo value
Message-ID: <20111218233121.GE2621@joana>
References: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1320917845-20135-3-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320917845-20135-3-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej.

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2011-11-10 10:37:25 +0100]:

> sk_sndtimeo timeout value is specified in jiffes and should be
> converted to miliseconds when used as input to __set_chan_timer.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

I think those one doesn't make sense anymore after the move to workqueues.

	Gustavo
