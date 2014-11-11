Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2] Bluetooth: Fix mgmt connected notification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415698404-21967-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 11 Nov 2014 18:36:18 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2B23799-3EFA-401D-ADA6-0F05834DB01B@holtmann.org>
References: <1415632226-22962-1-git-send-email-johan.hedberg@gmail.com> <1415698404-21967-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes a regression that was introduced by commit
> cb77c3ec075a50e9f956f62dc2e4c0394df1d578. In addition to BT_CONFIG,
> BT_CONNECTED is also a state in which we may get a remote name and need
> to indicate over mgmt the connection status. This scenario is
> particularly likely to happen for incoming connections that do not need
> authentication since there the hci_conn state will reach BT_CONNECTED
> before the remote name is received.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Added code comment to explain the conn->state checks
> 
> net/bluetooth/hci_event.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

