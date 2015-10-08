Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:06:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enforce packet types in hci_recv_frame driver
 function
Message-ID: <20151008070614.GJ25309@t440s.lan>
References: <1444266868-78229-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444266868-78229-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> When calling the hci_recv_frame driver function check for valid packet
> types that the core should process. This should catch issues with
> drivers trying to feed vendor packet types through this interface.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
