Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jul 2013 12:52:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] scanparam: Fix handle range check on
 descriptor discovery
Message-ID: <20130730095201.GA12745@x220.p-661hnu-f1>
References: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Jul 29, 2013, Anderson Lizardo wrote:
> When discovering descriptors, if there is only a single descriptor, the
> start handle will be equal to the end handle. It is valid to issue the
> Find Information Request on this case.
> 
> Before this fix, notification for Scan Refresh characteristic was never
> enabled.
> ---
>  profiles/scanparam/scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All patches in this set have been applied. Thanks.

Johan
