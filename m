Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v5 0/5] Bluetooth: Get Connection Information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400067786-10677-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 15 May 2014 21:48:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <75BF9178-B13B-4125-8B6B-0723723FA504@holtmann.org>
References: <1400067786-10677-1-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> Changes in v4:
> - include max_tx_power when declaring structs for 1st time, request will
>  just reply with HCI_TX_POWER_INVALID without other patches for max_tx_power
> - fixed debugfs to have basic validation
> 
> Changes in v5:
> - removed unnecessary #define from mgmt.h
> 
> 
> Andrzej Kaczmarek (5):
>  Bluetooth: Add conn info lifetime parameters to debugfs
>  Bluetooth: Add support to get connection information
>  Bluetooth: Avoid polling TX power for LE links
>  Bluetooth: Store max TX power level for connection
>  Bluetooth: Add support for max_tx_power in Get Conn Info
> 
> include/net/bluetooth/hci_core.h |   9 ++
> include/net/bluetooth/mgmt.h     |  12 +++
> net/bluetooth/hci_conn.c         |   1 +
> net/bluetooth/hci_core.c         |  63 ++++++++++++
> net/bluetooth/hci_event.c        |  12 ++-
> net/bluetooth/mgmt.c             | 213 +++++++++++++++++++++++++++++++++++++++
> 6 files changed, 309 insertions(+), 1 deletion(-)

all 5 patches have been applied to bluetooth-next tree.

Time to get mgmt-api.txt change merged and also provide btmgmt and mgmt-tester patches.

Regards

Marcel

