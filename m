Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Add timeout for LE connection attempts
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393602346-14676-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 28 Feb 2014 08:32:25 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9E21B8E5-8A32-4BF3-9551-CE41F2536F05@holtmann.org>
References: <1393602346-14676-1-git-send-email-johan.hedberg@gmail.com> <1393602346-14676-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> LE connection attempts do not have a controller side timeout in the same
> way as BR/EDR has (in form of the page timeout). Since we always do
> scanning before initiating connections the attempts are always expected
> to succeed in some reasonable time.
> 
> This patch adds a timer which forces a cancellation of the connection
> attempt within 20 seconds if it has not been successful by then. This
> way we e.g. ensure that mgmt_pair_device times out eventually and gives
> an error response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h      |  1 +
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_conn.c         | 13 +++++++++++++
> net/bluetooth/hci_event.c        | 12 ++++++++++++
> 4 files changed, 27 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

