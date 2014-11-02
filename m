Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 10:00:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Print error message for HCI_Hardware_Error
 event
Message-ID: <20141102080044.GB20526@t440s.P-661HNU-F1>
References: <1414893401-85774-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414893401-85774-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> When the HCI_Hardware_Error event is send by the controller or
> injected by the driver, then at least print an error message.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  5 +++++
>  net/bluetooth/hci_event.c   | 11 +++++++++++
>  2 files changed, 16 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
