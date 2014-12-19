Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 0/4] Bluetooth: Add/Remove Device completion through hci_request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 22:22:31 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A051E96C-5B33-460E-B2CA-FDB1DF33F0AA@holtmann.org>
References: <1419020763-9139-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a second attempt at this set, now rebased against the changes
> with hci_request.{c,h}.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (4):
>      Bluetooth: Add hci_request support for hci_update_background_scan
>      Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
>      Bluetooth: Fix Add Device to wait for HCI before sending cmd_complete
>      Bluetooth: Add return parameter to cmd_complete callbacks
> 
> include/net/bluetooth/hci_core.h |   4 -
> net/bluetooth/hci_core.c         | 147 ----------------------
> net/bluetooth/hci_request.c      |  96 ++++++++++++++
> net/bluetooth/hci_request.h      |   3 +
> net/bluetooth/mgmt.c             | 254 +++++++++++++++++++++++++++++---------
> 5 files changed, 298 insertions(+), 206 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

