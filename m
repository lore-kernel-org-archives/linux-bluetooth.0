Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 13/16] Bluetooth: Fix busy condition testing for EIR and class updates
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1361951844-13719-14-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 28 Feb 2013 12:01:05 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DCADC53A-261F-4CF0-A1CB-34DD7A49CA77@holtmann.org>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com> <1361951844-13719-14-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> The add/remove_uuid and set_dev_class mgmt commands can trigger both EIR
> and class HCI commands, so testing just for a pending class command is
> enough. The simplest way to monitor conflicts that should trigger "busy"
> error returns is to check for any pending mgmt command that can trigger
> these HCI commands. This patch adds a helper function for this
> (pending_eir_or_class) and uses it instead of the old HCI_PENDING_CLASS
> flag to test for busy conditions.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c |   39 ++++++++++++++++++++++++++++++---------
> 1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b2a9697..41a3265 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1341,6 +1341,23 @@ unlock:
> 	return err;
> }
> 
> +static bool pending_eir_or_class(struct hci_dev *hdev)
> +{
> +	struct pending_cmd *cmd;
> +
> +	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> +		switch (cmd->opcode) {
> +		case MGMT_OP_ADD_UUID:
> +		case MGMT_OP_REMOVE_UUID:
> +		case MGMT_OP_SET_DEV_CLASS:
> +		case MGMT_OP_SET_POWERED:
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +

I do not like this at all. Why would we do it like this?

The transaction framework should allow us to just process these one at a time. So even if userspace send 20 add_uuid commands at the same time, we would deal with them one after the other.

What I am trying to understand what is the benefit of returning busy here.

Regards

Marcel

