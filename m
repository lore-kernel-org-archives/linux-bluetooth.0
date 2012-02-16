Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 01:39:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: mgmt: Add support for Set Link Security
 command
Message-ID: <20120216233904.GA6607@x220.ger.corp.intel.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
 <1329434578-5928-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329434578-5928-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 17, 2012, johan.hedberg@gmail.com wrote:
> +	hdev = hci_dev_get(index);
> +	if (!hdev)
> +		return cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
> +						MGMT_STATUS_INVALID_PARAMS);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (mgmt_pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
> +		err = cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
> +							MGMT_STATUS_BUSY);
> +		goto failed;
> +	}
> +
> +	val = !!cp->val;
> +
> +	if (test_bit(HCI_AUTH, &hdev->flags) == val) {
> +		err = send_settings_rsp(sk, MGMT_OP_SET_LINK_SECURITY, hdev);
> +		goto failed;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LINK_SECURITY, hdev, data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	err = hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, sizeof(val), &val);
> +	if (err < 0) {
> +		mgmt_pending_remove(cmd);
> +		goto failed;
> +	}

There's a missing check for HCI_UP here as well as in the corresponding
place of patch 3/4. I'll send v2's of 2/4 and 3/4 as a new patch-set
(1/4 and 4/4 are quite trivial so I wont bother resending them).

Johan
