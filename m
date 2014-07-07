Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove auth_type parameter from hci_connect_le()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 15:21:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FCAA3470-FE4E-4B8D-A0A8-AD4890499AAC@holtmann.org>
References: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The auth_type value which gets assigned to hci_conn->auth_type is
> something that's only used for BR/EDR connections and is of no value for
> LE connections. It makes therefore little sense to pass it to the
> hci_connect_le() function. This patch removes the parameter from the
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 3 +--
> net/bluetooth/hci_conn.c         | 5 +----
> net/bluetooth/hci_event.c        | 2 +-
> net/bluetooth/l2cap_core.c       | 6 ++----
> net/bluetooth/mgmt.c             | 3 +--
> 5 files changed, 6 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

