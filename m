Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Create separate module for Realtek BT driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431593349-28386-1-git-send-email-carlo@caione.org>
Date: Thu, 14 May 2015 12:06:10 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>, larry.finger@lwfinger.net,
	Champion Chen <champion_chen@realsil.com.cn>,
	Daniel Drake <drake@endlessm.com>,
	Carlo Caione <carlo@endlessm.com>
Message-Id: <1CA91997-BBF8-460D-B030-932EDC006184@holtmann.org>
References: <1431593349-28386-1-git-send-email-carlo@caione.org>
To: Carlo Caione <carlo@caione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

> As already done for btintel and btbcm export setup as separate function
> in a vendor-specific module to hold all the Realtek specific commands.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
> 
> Changelog:
> v2:
>   * Fixed typos and authorship attribution
>   * Removed status check as already performed by __hci_cmd_sync
>   * s/btusb_/btrtl_/g in btrtl.c
>   * moved defines from btrtl.h to btrtl.c
> 
> ---
> drivers/bluetooth/Kconfig  |  15 ++
> drivers/bluetooth/Makefile |   1 +
> drivers/bluetooth/btrtl.c  | 390 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btrtl.h  |  52 ++++++
> drivers/bluetooth/btusb.c  | 377 +------------------------------------------
> 5 files changed, 462 insertions(+), 373 deletions(-)
> create mode 100644 drivers/bluetooth/btrtl.c
> create mode 100644 drivers/bluetooth/btrtl.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

