Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Apr 2015 15:10:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: btintel: Introduce generic Intel
 Bluetooth support
Message-ID: <20150406121030.GB20341@t440s.P-661HNU-F1>
References: <1428306734-14210-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428306734-14210-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Apr 06, 2015, Marcel Holtmann wrote:
> The majority of Intel Bluetooth vendor commands are shared between USB
> and UART transports. This creates a separate module that eventually
> will hold all Intel specific commands, but for now just start with the
> commands to change the Bluetooth public address and check for the
> default address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Kconfig   |   3 ++
>  drivers/bluetooth/Makefile  |   1 +
>  drivers/bluetooth/btintel.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  41 ++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 drivers/bluetooth/btintel.c
>  create mode 100644 drivers/bluetooth/btintel.h

All four patches in this set have been applied to bluetooth-next.
Thanks.

Johan
