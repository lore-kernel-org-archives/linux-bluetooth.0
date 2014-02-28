Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/2] Bluetooth: Remove unnecessary stop_scan_complete function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393611973-3183-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 28 Feb 2014 10:39:08 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C60DAD3-716B-44ED-80D8-EA9DF67902B0@holtmann.org>
References: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com> <1393611973-3183-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The stop_scan_complete function was used as an intermediate step before
> doing the actual connection creation. Since we're using hci_request
> there's no reason to have this extra function around, i.e. we can simply
> put both HCI commands into the same request.
> 
> The single task that the intermediate function had, i.e. indicating
> discovery as stopped is now taken care of by a new
> HCI_LE_SCAN_INTERRUPTED flag which allows us to do the discovery state
> update when the stop scan command completes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 51 +++++++--------------------------------------
> net/bluetooth/hci_event.c   |  7 +++++++
> 3 files changed, 16 insertions(+), 43 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

