Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Jan 2015 11:00:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Limit hardware error handling to Intel
 Snowfield Peak
Message-ID: <20150130090008.GA29207@t440s.lan>
References: <1422566040-21714-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422566040-21714-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 29, 2015, Marcel Holtmann wrote:
> In general all Intel Bluetooth devices support retrieving of additional
> exception information. However for older generations including Wilkens
> Peak and Stone Peak it is not as simple. So for now only enable the
> Intel specific error handling for Snowfield Peak and later devices.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
