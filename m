Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Rename hci_send_to_control to hci_send_to_channel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424431584-29831-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 20 Feb 2015 09:21:47 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A274E424-1843-4D2F-AA72-E9E3984087FA@holtmann.org>
References: <1424431584-29831-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_send_to_control() can be made more general purpose with a small
> change of passing the desired HCI channel as a parameter to it. This
> allows using it for the monitor channel as well as e.g. 6lowpan in the
> future.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 3 ++-
> net/bluetooth/hci_sock.c         | 9 +++++----
> net/bluetooth/mgmt.c             | 3 ++-
> 3 files changed, 9 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

