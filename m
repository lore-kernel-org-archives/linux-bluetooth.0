Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/4] Bluetooth: Add hci_request parameter to hci_update_background_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418981017-10462-3-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 11:03:44 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3DBBCAB1-FDA2-4CE1-B8B7-3684F6548C04@holtmann.org>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com> <1418981017-10462-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Many places using hci_update_background_scan() try to synchronize
> whatever they're doing with the help of hci_request callbacks. However,
> since the hci_update_background_scan() function hasn't so far accepted a
> hci_request pointer any commands triggered by it have been left out by
> the synchronization. This patch an extra parameter to the function to
> fix the issue. This there are also many places where there is no
> existing hci_request context, the parameter is made optional, i.e. by
> passing NULL hci_update_background_scan() uses its own request and a
> dummy callback.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         |  2 +-
> net/bluetooth/hci_core.c         | 33 ++++++++++++++++++++-------------
> net/bluetooth/hci_event.c        |  4 ++--
> net/bluetooth/mgmt.c             | 19 +++++++++----------
> 5 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 75aaae07037f..d89a359c83ea 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -940,7 +940,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> 						  bdaddr_t *addr,
> 						  u8 addr_type);
> 
> -void hci_update_background_scan(struct hci_dev *hdev);
> +void hci_update_background_scan(struct hci_dev *hdev, struct hci_request *req);

this goes a bit against what we done otherwise in the code base. We normally only give the hci_request pointer since that always provides the hci_dev as well.

I have the feeling that we might better split this into two functions. One just taking hci_dev and the other just taking hci_request. Or we have to make all callers create a hci_request context in the first place.

Regards

Marcel

