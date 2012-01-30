Return-Path: <cyrus@holtmann.org>
Message-ID: <1327959703.1955.169.camel@aeonflux>
Subject: Re: [PATCH v3 4/6] Bluetooth: Add hci_le_scan()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 13:41:43 -0800
In-Reply-To: <1327531949-29463-5-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	 <1327531949-29463-5-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> We are not supposed to block in start_discovery() because
> start_discovery code is running in write() syscall context
> and this would block the write operation on the mgmt socket.
> This way, we cannot directly call hci_do_le_scan() to scan
> LE devices in start_discovery(). To overcome this issue a
> derefered work (hdev->le_scan) was created so we can properly
> call hci_do_le_scan().
> 
> The helper function hci_le_scan() simply set LE scan parameters
> and queue hdev->le_scan work. The work is queued on system_long_wq
> since it can sleep for a few seconds in the worst case (timeout).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |   12 ++++++++++++
>  net/bluetooth/hci_core.c         |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 0 deletions(-)

so I am fine with this one, but we might need to make this one generic
as well (if possible).

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


