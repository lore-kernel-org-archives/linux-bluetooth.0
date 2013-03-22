Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 13:09:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Fix HCI request for Inquiry command
Message-ID: <20130322110909.GA11186@x220.ger.corp.intel.com>
References: <1363788708-28355-1-git-send-email-andre.guedes@openbossa.org>
 <1363788708-28355-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363788708-28355-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Mar 20, 2013, Andre Guedes wrote:
> @@ -1079,6 +1077,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>  {
>  	BT_DBG("%s status 0x%2.2x", hdev->name, status);
>  
> +	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
> +
>  	if (status) {
>  		hci_conn_check_pending(hdev);
>  		hci_dev_lock(hdev);

What about the hci_req_cmd_status call in the  hci_cmd_status_evt
function? hci_req_cmd_status could call hci_req_cmd_complete in which
case you'd get two calls to that function for the same event.

I have a feeling that if you really want to consider all commands as
completed based on command status events we should just skip the whole
hci_req_cmd_status/complete distinction and remove the
hci_req_cmd_status function completely (always calling cmd_complete).

Johan
