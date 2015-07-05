Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jul 2015 17:07:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel: Create common function for Intel
 version info
Message-ID: <20150705140735.GC22814@t440s.P-661HNU-F1>
References: <1436101327-97285-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436101327-97285-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 05, 2015, Marcel Holtmann wrote:
> The Intel version information is shared between USB and UART drivers
> and with that move it into a generic function of the Intel module.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c   | 21 +++++++++++++++++++++
>  drivers/bluetooth/btintel.h   |  5 +++++
>  drivers/bluetooth/btusb.c     | 23 +----------------------
>  drivers/bluetooth/hci_intel.c | 23 +----------------------
>  4 files changed, 28 insertions(+), 44 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
