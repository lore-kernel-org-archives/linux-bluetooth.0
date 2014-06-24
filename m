Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/6] Bluetooth: Move mgmt event sending out from hci_add_link_key()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403604953-19539-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 12:38:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D06EE800-2A1C-45FF-BB71-9DC3A02BD86E@holtmann.org>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com> <1403604953-19539-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are two callers of hci_add_link_key(). The first one is the HCI
> Link Key Notification event and the second one the mgmt code that
> receives a list of link keys from user space. Previously we've had the
> hci_add_link_key() function being responsible for also emitting a mgmt
> signal but for the latter use case this should not happen. Because of
> this a rather awkward new_key paramter has been passed to the function.
> 
> This patch moves the mgmt event sending out from the hci_add_link_key()
> function, thereby making the code a bit more understandable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  4 ++--
> net/bluetooth/hci_core.c         | 17 +++++------------
> net/bluetooth/hci_event.c        | 18 +++++++++++++++---
> net/bluetooth/mgmt.c             |  4 ++--
> 4 files changed, 24 insertions(+), 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

