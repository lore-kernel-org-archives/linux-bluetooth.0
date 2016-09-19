Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Bluetooth: hci_uart: Add Marvell support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474295367-13208-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 19 Sep 2016 20:32:30 +0200
Cc: akarwar@marvell.com, linux-bluetooth@vger.kernel.org
Message-Id: <7BA5FF10-DA69-40E4-9180-D48509BD90A7@holtmann.org>
References: <1474295367-13208-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This patch introduces support for Marvell Bluetooth controller over
> UART (8897 for now). In order to send the final firmware at full speed,
> a helper firmware is firstly sent. Firmware download is driven by the
> controller which sends request firmware packets (including expected
> size).
> 
> This driver is a global rework of the one proposed by
> Amitkumar Karwar <akarwar@marvell.com>.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Remove comma from copyright fields
>     Use enum instead of defines for mrvl states
>     Use separate queue for raw data packets
>     Use distinct recv functions for fw_req & chip_ver
>     Remove fixed_data, not used anymore in upstream candidate ver
>     Change protocol name to Marvell

patch has been applied to bluetooth-next tree.

Regards

Marcel

