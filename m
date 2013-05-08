Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 May 2013 10:13:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/2] neard: Fix checking for unknown carrier power state
Message-ID: <20130508071316.GA9401@x220>
References: <1367846452-23303-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367846452-23303-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, May 06, 2013, Szymon Janc wrote:
> Message might not contain State field and CPS needs to be set to
> unknown before processing message from neard. This fix processing
> RequestOOB called without parameters.
> ---
>  plugins/neard.c | 3 +++
>  1 file changed, 3 insertions(+)

Both patches have been applied. Thanks.

Johan
