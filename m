Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Apr 2015 15:09:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Provide generic H:4 receive
 framework
Message-ID: <20150406120902.GA20341@t440s.P-661HNU-F1>
References: <1428302699-24839-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428302699-24839-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Apr 05, 2015, Marcel Holtmann wrote:
> Future H:4 based UART drivers require custom packet types and custom
> receive functions. To support this, extended the h4_recv_buf function
> with a packet definition table.
> 
> For the default H:4 packets types of ACL data, SCO data and events,
> provide helpers to reduce the amount of code duplication.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ath.c  |   9 +++-
>  drivers/bluetooth/hci_bcm.c  |   9 +++-
>  drivers/bluetooth/hci_h4.c   | 119 ++++++++++++++++++++++---------------------
>  drivers/bluetooth/hci_uart.h |  33 +++++++++++-
>  4 files changed, 110 insertions(+), 60 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
