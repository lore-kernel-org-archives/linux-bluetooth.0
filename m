Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 29 Aug 2016 10:05:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use command status event for Set IO
 Capability errors
Message-ID: <20160829070506.GB7349@t440s.lan>
References: <1472445117-6527-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472445117-6527-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 29, 2016, Marcel Holtmann wrote:
> In case of failure, the Set IO Capability command is suppose to return
> command status and not command complete.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
