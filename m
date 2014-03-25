Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 4/4] Bluetooth: Add directed advertising support through connect()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395736249-11450-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 01:46:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37B501F3-AC38-4AD4-9800-69C580A3EAA4@holtmann.org>
References: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com> <1395736249-11450-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're in peripheral mode (HCI_ADVERTISING flag is set) the most
> natural mapping of connect() is to perform directed advertising to the
> peer device.
> 
> This patch does the necessary changes to enable directed advertising and
> keeps the hci_conn state as BT_CONNECT in a similar way as is done for
> central or BR/EDR connection initiation.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 77 ++++++++++++++++++++++++++++++++++++++++-----
> net/bluetooth/hci_event.c   | 19 +++++++++--
> 3 files changed, 87 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

