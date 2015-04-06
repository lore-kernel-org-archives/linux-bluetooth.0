Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Apr 2015 09:04:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/10] Bluetooth: btbcm: Introduce generic Broadcom
 Bluetooth support
Message-ID: <20150406060402.GA6539@t440s.P-661HNU-F1>
References: <1428299539-8273-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428299539-8273-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Apr 05, 2015, Marcel Holtmann wrote:
> The majority of Broadcom Bluetooth vendor commands are shared between
> USB and UART transports. This creates a separate module that eventually
> will hold all Broadcom specific commands, but for now just start with
> the commands to change the Bluetooth public address and check for the
> default address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Kconfig  |  3 ++
>  drivers/bluetooth/Makefile |  1 +
>  drivers/bluetooth/btbcm.c  | 99 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btbcm.h  | 41 +++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 drivers/bluetooth/btbcm.c
>  create mode 100644 drivers/bluetooth/btbcm.h

All 10 patches have been applied to bluetooth-next. Thanks.

Johan
