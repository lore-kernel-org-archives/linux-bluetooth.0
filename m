Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3 0/7] Introduce APIs to set advertising data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427151435-24958-1-git-send-email-armansito@chromium.org>
Date: Mon, 23 Mar 2015 17:55:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A95D763A-60B5-4D51-83CD-AC6448E84BB4@holtmann.org>
References: <1427151435-24958-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> *v3: - Addressed Marcel's comments on v2.
> 
> *v2: - Addressed Marcel's comments on v1.
> 
> *v1: - Addressed Marcel's comments.
>     - Included support for setting scan response data and timeouts.
> 
> Arman Uguray (7):
>  Bluetooth: Add definitions for Add/Remove Advertising API
>  Bluetooth: Introduce HCI_ADVERTISING_INSTANCE setting and add AD flags
>  Bluetooth: Add data structure for advertising instance
>  Bluetooth: Implement the Add Advertising command
>  Bluetooth: Implement the Remove Advertising command
>  Bluetooth: Add support for instance scan response
>  Bluetooth: Add support for adv instance timeout
> 
> include/net/bluetooth/hci.h      |   2 +
> include/net/bluetooth/hci_core.h |  18 ++
> include/net/bluetooth/mgmt.h     |  34 +++
> net/bluetooth/hci_core.c         |   1 +
> net/bluetooth/mgmt.c             | 493 +++++++++++++++++++++++++++++++++++++--
> 5 files changed, 534 insertions(+), 14 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

