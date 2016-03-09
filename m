Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2 3/3] Bluetooth: Add support for limited privacy mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457537434-32250-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 9 Mar 2016 07:53:53 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DCD3EA2E-461B-4F87-A730-AADEDFA26EB6@holtmann.org>
References: <1457537434-32250-1-git-send-email-johan.hedberg@gmail.com> <1457537434-32250-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Introduce a limited privacy mode indicated by value 0x02 to the mgmt
> Set Privacy command.
> 
> With value 0x02 the kernel will use privacy mode with a resolvable
> private address. In case the controller is bondable and discoverable
> the identity address will be used.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 13 ++++++++++--
> net/bluetooth/hci_request.c | 51 +++++++++++++++++++++++++++++++++++++++------
> net/bluetooth/hci_request.h |  2 +-
> net/bluetooth/mgmt.c        | 20 ++++++++++++++++--
> 5 files changed, 76 insertions(+), 11 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

