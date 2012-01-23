Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 12:56:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 1/2] Remove dead code from bonding_request_new
Message-ID: <20120123105617.GC13100@x220>
References: <1327073187-1009-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327073187-1009-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jan 20, 2012, Szymon Janc wrote:
> agent_create always return valid pointer so there is not need to check
> for NULL as this will never happen.
> ---
>  src/device.c |    9 +--------
>  1 files changed, 1 insertions(+), 8 deletions(-)

Both patches have been applied. Thanks.

Johan
