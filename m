Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: Add option to enable/disable A2MP module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432274165-23569-2-git-send-email-arron.wang@intel.com>
Date: Mon, 25 May 2015 21:06:09 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <669F121F-A1EE-47A7-8A15-27E1A2FAFF26@holtmann.org>
References: <1432274165-23569-1-git-send-email-arron.wang@intel.com> <1432274165-23569-2-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> Make Bluetooth 3.0 HS feature configurable
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> net/bluetooth/Kconfig          |    5 +
> net/bluetooth/Makefile         |    3 +-
> net/bluetooth/a2mp.h           |   19 +++
> net/bluetooth/amp.h            |   11 ++
> net/bluetooth/hci_event.c      |  260 +-----------------------------------
> net/bluetooth/hci_event_a2mp.c |  283 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event_a2mp.h |   91 +++++++++++++
> 7 files changed, 412 insertions(+), 260 deletions(-)
> create mode 100644 net/bluetooth/hci_event_a2mp.c
> create mode 100644 net/bluetooth/hci_event_a2mp.h

I don’t think this is the solution here. I think A2MP support should be self contained and utilises the synchronous HCI command framework we have in place and also use in mgmt.

> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index e7bca37..a558c66 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -27,6 +27,7 @@ menuconfig BT
> 		SMP (Security Manager Protocol) on LE (Low Energy) links
> 	     HCI Device drivers (Interface to the hardware)
> 	     SCO Module (SCO audio links)
> +	     A2MP Module (AMP Manager Protocol)
> 	     RFCOMM Module (RFCOMM Protocol)  
> 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
> 	     CMTP Module (CAPI Message Transport Protocol)
> @@ -53,6 +54,10 @@ config BT_SCO
> 	  SCO link provides voice transport over Bluetooth.  SCO support is
> 	  required for voice applications like Headset and Audio.
> 
> +config BT_A2MP
> +	bool "Bluetooth Alternate MAC/PHY (AMP) features"
> +	depends on BT_BREDR
> +

The option name you are looking for for BT_HS for high speed support. A2MP and AMP support should be hidden behind that config option.

Regards

Marcel

