Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2] Bluetooth: Fix address value for early disconnection events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395312856-1992-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 20 Mar 2014 09:15:41 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0ACF2210-9E51-46C4-A2BA-262FD444BD01@holtmann.org>
References: <1395308865-27200-1-git-send-email-johan.hedberg@gmail.com> <1395312856-1992-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to ensure that we do not send events to user space with the
> identity address if we have not yet notified user space of the IRK. The
> code was previously trying to handle this for the mgmt_pair_device
> response (which worked well enough) but this is not the only connection
> related event that might be sent to user space before pairing is
> successful: another important event is Device Disconnected.
> 
> The issue can actually be solved more simply than the solution
> previously used for mgmt_pair_device. Since we do have the identity
> address tracked as part of the remote IRK struct we can just copy it
> over from there to the hci_conn struct once we've for real sent the mgmt
> event for the new IRK.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Move l2cap_conn_update_id_addr to the right place
> 
> net/bluetooth/mgmt.c | 16 ++--------------
> net/bluetooth/smp.c  | 16 +++++++++-------
> 2 files changed, 11 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

