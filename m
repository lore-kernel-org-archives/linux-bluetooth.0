Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 00/10] Bluetooth: Fix mgmt cmd_complete events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 5 Dec 2014 12:50:09 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <22D8A2C4-1BC5-45C4-976A-B89D09E0EBF4@holtmann.org>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch set introduces an optional callback that can be set for
> pending mgmt commands so that the generic places sending out these
> events (powering off and removing adapters) can send out correct events
> as specified in our mgmt-api.txt. A further benefit of having this
> callback is that we fix memory leaks caused by hci_conn pointers being
> stored as part of the pending command user data.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (10):
>      Bluetooth: Add callback to create proper cmd_complete events
>      Bluetooth: Store parameter length with pending mgmt commands
>      Bluetooth: Convert Disconnect mgmt command to use cmd_complete callback
>      Bluetooth: Use cmd_complete callback for authentication mgmt commands
>      Bluetooth: Convert Pair Device to use cmd_complete callback
>      Bluetooth: Convert Unpair Device to use cmd_complete callback
>      Bluetooth: Convert discovery commands to use cmd_complete callback
>      Bluetooth: Convert Get Clock Info to use cmd_complete callback
>      Bluetooth: Fix initializing hci_conn RSSI to invalid value
>      Bluetooth: Fix Get Conn Info to use cmd_complete callback
> 
> net/bluetooth/hci_conn.c |   1 +
> net/bluetooth/mgmt.c     | 271 ++++++++++++++++++++++-----------------------
> 2 files changed, 136 insertions(+), 136 deletions(-)

all 10 patches have been applied to bluetooth-next tree.

Regards

Marcel

