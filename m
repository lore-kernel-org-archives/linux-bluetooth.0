Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 23:16:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add Device Added and Device Removed
 management events
Message-ID: <20140629201604.GA24273@t440s.P-661HNU-F1>
References: <1404066386-10741-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404066386-10741-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> +static void device_added(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
> +			 u8 action)
> +{
> +	struct pending_cmd *cmd;
> +	struct mgmt_ev_device_added ev;
> +
> +	cmd = mgmt_pending_find(MGMT_OP_ADD_DEVICE, hdev);

This is not going to work since you're not creating a pending command
struct for either one of the new mgmt commands (i.e. using
mgmt_pending_add). Not using mgmt_pending_add makes perfect sense here
since this is all synchronous (no HCI commands etc). What I'd suggest is
to pass the struct sock to the function or even do the signal sending
inline in the command handler function (as it's not many lines of code
and you've only got a single caller).

> +static void device_removed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
> +{
> +	struct pending_cmd *cmd;
> +	struct mgmt_ev_device_removed ev;
> +
> +	cmd = mgmt_pending_find(MGMT_OP_REMOVE_DEVICE, hdev);

Same here.

Johan
