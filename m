Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 0/7] Bluetooth: Move more code to hci_request.c & req_workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Nov 2015 13:16:24 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AFF7CBD3-6F35-4E26-B38D-4CEADB1B42DC@holtmann.org>
References: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches continues the trend of moving HCI activity from
> mgmt.c to hci_request.c and running as much of it as possible through
> the same hdev->req_workqueue with the help of hci_req_sync.
> 
> I'll have many more updates coming still after these, but wanted to send
> what I have at this point since I've sucessfully ran tests on them with
> mgmt-tester, btmgmt and bluetoothd/bluetoothctl without seeing any
> breakage (doesn't mean it isn't there though).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (7):
>      Bluetooth: Run page scan updates through hdev->req_workqueue
>      Bluetooth: Move __hci_update_background_scan up in hci_request.c
>      Bluetooth: Move advertising instance management to hci_request.c
>      Bluetooth: Move connectable changes to hdev->req_workqueue
>      Bluetooth: Perform Class of Device changes through hdev->req_workqueue
>      Bluetooth: Move discoverable changes to hdev->req_workqueue
>      Bluetooth: Move discoverable timeout behind hdev->req_workqueue
> 
> include/net/bluetooth/hci_core.h |  15 +-
> net/bluetooth/hci_conn.c         |   2 +-
> net/bluetooth/hci_core.c         |  32 +-
> net/bluetooth/hci_event.c        |   8 +-
> net/bluetooth/hci_request.c      | 833 +++++++++++++++++++++++++++++++++----
> net/bluetooth/hci_request.h      |  24 +-
> net/bluetooth/mgmt.c             | 843 ++++----------------------------------
> 7 files changed, 876 insertions(+), 881 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

