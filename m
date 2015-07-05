Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jul 2015 17:07:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel: Create common Intel Secure Send
 function
Message-ID: <20150705140721.GB22814@t440s.P-661HNU-F1>
References: <1436100936-94207-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436100936-94207-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 05, 2015, Marcel Holtmann wrote:
> The Intel Secure Send command is used the same in USB and UART drivers
> and with that move a generic version into the Intel module.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c   | 25 +++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h   |  9 +++++++++
>  drivers/bluetooth/btusb.c     | 33 ++++-----------------------------
>  drivers/bluetooth/hci_intel.c | 32 ++++----------------------------
>  4 files changed, 42 insertions(+), 57 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
