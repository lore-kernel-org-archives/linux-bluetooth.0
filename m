Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Sep 2014 07:17:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Provide HCI command opcode information to
 driver
Message-ID: <20140915041728.GB722@t440s.P-661HNU-F1>
References: <1410728788-5170-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410728788-5170-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 14, 2014, Marcel Holtmann wrote:
> The Bluetooth core already does processing of the HCI command header
> and puts it together before sending it to the driver. It is not really
> efficient for the driver to look at the HCI command header again in
> case it has to make certain decisions about certain commands. To make
> this easier, just provide the opcode as part of the SKB control buffer
> information. The extra information about the opcode is optional and
> only provided for HCI commands.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 1 +
>  net/bluetooth/hci_core.c          | 1 +
>  2 files changed, 2 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
