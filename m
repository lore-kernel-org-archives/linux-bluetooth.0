Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2] Bluetooth: Merge ADV_IND/ADV_SCAN_IND and SCAN_RSP together
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395737512-16757-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 01:56:41 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <44EF89A3-813B-4106-A6B0-52102392C043@holtmann.org>
References: <1395737512-16757-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To avoid too many events being sent to user space and to help parsing of
> all available remote device data it makes sense for us to wait for the
> scan response and send a single merged Device Found event to user space.
> 
> This patch adds a few new variables to hci_dev to track the last
> received ADV_IND/ADV_SCAN_IND, i.e. those which will cause a SCAN_REQ to
> be send in the case of active scanning. When the SCAN_RSP is received
> the pending data is passed together with the SCAN_RSP to the
> mgmt_device_found function which takes care of merging them into a
> single Device Found event.
> 
> We also need a bit of extra logic to handle situations where we don't
> receive a SCAN_RSP after caching some data. In such a scenario we simply
> have to send out the pending data as it is and then operate on the new
> report as if there was no pending data.
> 
> We also need to send out any pending data when scanning stops as
> well as ensure that the storage is empty at the start of a new active
> scanning session. These both cases are covered by the update to the
> hci_cc_le_set_scan_enable function in this patch.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |   4 ++
> net/bluetooth/hci_event.c        | 103 ++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 105 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

