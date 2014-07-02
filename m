Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 16:42:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for default address of Broadcom
 BCM20702A0 controllers
Message-ID: <20140702134201.GD15249@t440s.P-661HNU-F1>
References: <1404297502-26014-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404297502-26014-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> The Broadcom BCM20702A0 USB controllers might come with the default
> address 00:20:70:02:A0:00 when booting up. If this happens, then warn
> about such address being used.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
