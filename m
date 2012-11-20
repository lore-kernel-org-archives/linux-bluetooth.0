Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 12:25:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] neard: Use ENONET error when adapter is not enabled
Message-ID: <20121120102558.GB6570@x220.ger.corp.intel.com>
References: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 19, 2012, Szymon Janc wrote:
> This results in returning error 'Disabled' instead of 'No such Device'.
> Will allow neard to properly set power state of Bluetooth carrier.
> ---
>  plugins/neard.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All four patches have been applied after some minor coding style fixes
in patches 3 and 4. Thanks.

Johan
