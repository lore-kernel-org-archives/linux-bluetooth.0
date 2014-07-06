Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Use lower timeout for LE auto-connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404643275-22676-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 6 Jul 2014 12:52:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <627C26AC-1CA3-413C-B550-59CB1D8BEBE3@holtmann.org>
References: <1404643275-22676-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we establish connections as a consequence of receiving an
> advertising report it makes no sense to wait the normal 20 second LE
> connection timeout. This patch modifies the hci_connect_le function to
> take an extra timeout value and uses a lower 2 second timeout for the
> auto-connection case. This timeout is intentionally chosen to be just a
> bit higher than the 1.28 second timeout that High Duty Cycle Advertising
> uses.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h      | 1 +
> include/net/bluetooth/hci_core.h | 4 +++-
> net/bluetooth/hci_conn.c         | 4 +++-
> net/bluetooth/hci_event.c        | 4 ++--
> net/bluetooth/l2cap_core.c       | 2 +-
> net/bluetooth/mgmt.c             | 3 ++-
> 6 files changed, 12 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

