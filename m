Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:45:58 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Simplify bachk function
Message-ID: <20110304184558.GC21452@jh-x301>
References: <1299061167-8323-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299061167-8323-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Mar 02, 2011, Szymon Janc wrote:
> ---
>  lib/bluetooth.c |   21 ++++++---------------
>  1 files changed, 6 insertions(+), 15 deletions(-)

Pushed upstream. Thanks. For non-trivial changes please add more
descriptive commit messages in the future (it would have saved me some
time in reviewing the patch for correctness).

Johan
