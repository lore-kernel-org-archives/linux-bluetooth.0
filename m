Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v6 1/2] Bluetooth: hci_intel: Add Intel baudrate configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440518144-14709-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 25 Aug 2015 10:18:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <260DEC3C-5AB5-4575-8040-65DF1515C53C@holtmann.org>
References: <1440518144-14709-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Implement the set_baudrate callback for hci_intel.
> - Controller requires a read Intel version command before updating
>   its baudrate.
> - The operation consists in an async cmd since the controller does
>   not respond at the same speed.
> - Wait 100ms to let the controller change its baudrate.
> - Clear RTS until we change our own UART speed
> 
> Manage speed change in the setup function, we need to restore the oper
> speed once chip has booted on patched firmware.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: simplify baudrate change, update commit message,
>     set missing set_baudrate callback.
> v3: Remove unused 'err' variable in intel_set_baudrate
> v4: Move set_bit STATE_BOOTING after speed changing in setup
>     change patch title, hci_uart->hci_intel
> v5: Direclty enqueue speed cmd instead of hacking hci_cmd_sync
>     intel_set_baudrate refactoring.
>     keep STATE_SPEED_CHANGING flag in order to ignore incoming packet
>     during transition. Could be used later to indicate cmd complete,
>     avoiding msleep usage.
> v6: use hci_uart_set_flow_control to clear RTS during speed transition
>     dont need STATE_SPEED_CHANGING flag anymore
> 
> drivers/bluetooth/hci_intel.c | 119 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 119 insertions(+)

patch has been applied to bluetooth-next tree.

Just a heads up that the patch 2/2 never made it to the mailing list.

Regards

Marcel

