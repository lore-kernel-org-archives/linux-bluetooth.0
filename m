Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 08:50:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read LE Advertising Channel TX Power only
 when available
Message-ID: <20140713055043.GA9869@t440s.P-661HNU-F1>
References: <1405200050-23210-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405200050-23210-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 12, 2014, Marcel Holtmann wrote:
> The Read LE Advertising Channel TX Power command is not mandatory for
> a Bluetooth HCI controller only supporting receiption. Move the command
> to the third stage of the controller initialization and only execute it
> when support for it has been indicated.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
