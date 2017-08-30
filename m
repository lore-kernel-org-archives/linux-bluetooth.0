Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 30 Aug 2017 22:13:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add option for disabling legacy ioctl
 interfaces
Message-ID: <20170830191329.GA13956@x1c.home>
References: <20170821082908.12296-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170821082908.12296-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 21, 2017, Marcel Holtmann wrote:
> The legacy ioctl interfaces are only useful for BR/EDR operation and
> since Linux 3.4 no longer needed anyway. This options allows disabling
> them alltogether and use only management interfaces for setup and
> control.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/Kconfig    | 10 ++++++++++
>  net/bluetooth/hci_sock.c |  6 ++++++
>  2 files changed, 16 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
