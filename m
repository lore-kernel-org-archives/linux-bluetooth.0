Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 0/5] LE scanning fixes & cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 3 Jul 2014 18:45:53 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2ECC0438-8B28-43EF-B456-F7BEDE100DB8@holtmann.org>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Fix missing update of pend_le_reports
>      Bluetooth: Remove redundant IRK lookup
>      Bluetooth: Use hci_conn_params in pend_le_conns
>      Bluetooth: Remove unnecessary checks for auto-connected devices
>      Bluetooth: Add identity address check in param lookup functions
> 
> include/net/bluetooth/hci_core.h |  9 +++--
> net/bluetooth/hci_core.c         | 76 +++++++++++++++-----------------------
> net/bluetooth/hci_event.c        | 45 ++++++++++------------
> net/bluetooth/mgmt.c             |  7 +++-

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

