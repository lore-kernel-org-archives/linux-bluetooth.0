Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 22:13:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for creating HCI UART based AMP
 controllers
Message-ID: <20120224201304.GB21313@x220.P-661HNU-F1>
References: <1330099778-9107-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330099778-9107-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 24, 2012, Marcel Holtmann wrote:
> In reality this might never be used for real hardware, but it is a nice
> feature for emulating AMP controllers within a virtual machine.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c |    5 +++++
>  drivers/bluetooth/hci_uart.h  |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
