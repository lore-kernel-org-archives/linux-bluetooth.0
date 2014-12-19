Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] Bluetooth: Split hci_update_page_scan into two functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 12:53:51 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7B09510D-3599-477C-8AD2-4B792B624F5F@holtmann.org>
References: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To keep the parameter list and its semantics clear it makes sense to
> split the hci_update_page_scan function into two separate functions: one
> taking a hci_dev and another taking a hci_request. The one taking a
> hci_dev constructs its own hci_request and then calls the other
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  3 ++-
> net/bluetooth/hci_core.c         | 17 ++++++++++++-----
> net/bluetooth/hci_event.c        |  4 ++--
> net/bluetooth/mgmt.c             | 16 ++++++++--------
> 4 files changed, 24 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

