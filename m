Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix redundant device (un)blocked events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404241787-8224-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 21:17:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E3053263-6B63-426E-B5B3-C4284E4E0D45@holtmann.org>
References: <1404241787-8224-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For the Block/Unblock Device mgmt commands we should only emit the
> Blocked/Unblocked events on any socket except for the one which received
> the command. The code was previously incorrectly trying to look up a
> non-existent pending command and thereby ending up not skipping the
> command socket for the event.
> 
> We can simplify the code a lot by simply sending the event directly from
> the command handler functions. We have the reference to the command
> socket available there which makes it easy to pass to the mgmt_event
> function for skipping.
> 
> The only notable side-effect of this is that the old blacklisting
> ioctl's no-longer cause mgmt events to be emitted, however as user space
> versions using these ioctl's are not mgmt-aware this is acceptable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 --
> net/bluetooth/hci_core.c         |  4 ++--
> net/bluetooth/mgmt.c             | 50 +++++++++++++---------------------------
> 3 files changed, 18 insertions(+), 38 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

