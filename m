Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 10:03:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce BT_BREDR and BT_LE config options
Message-ID: <20141102080337.GD20526@t440s.P-661HNU-F1>
References: <1414895545-108621-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414895545-108621-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> The current kernel options do not make it clear which modules are for
> Bluetooth Classic (BR/EDR) and which are for Bluetooth Low Energy (LE).
> 
> To make it really clear, introduce BT_BREDR and BT_LE options with
> proper dependencies into the different modules. Both new options
> default to y to not create a regression with previous kernel config
> files.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/Kconfig        | 20 +++++++++++++++-----
>  net/bluetooth/bnep/Kconfig   |  2 +-
>  net/bluetooth/cmtp/Kconfig   |  2 +-
>  net/bluetooth/hidp/Kconfig   |  2 +-
>  net/bluetooth/rfcomm/Kconfig |  2 +-
>  5 files changed, 19 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
