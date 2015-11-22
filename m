Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 22 Nov 2015 16:02:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Add instance range check for Add
 Advertising command
Message-ID: <20151122130253.GA7091@t440s>
References: <1447946203-17620-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447946203-17620-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 19, 2015, Marcel Holtmann wrote:
> The instance range check for Add Advertising command is missing. If the
> provided instance is out of range an Invalid Parameters error should be
> returned. At the moment, the generic Failed error is returned. This
> extra check ensures that clear error messages are returned.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)

Patches 1 and 2 have been applied. Thanks.

Johan
