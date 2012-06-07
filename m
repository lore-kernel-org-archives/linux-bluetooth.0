Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 17:18:25 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH v1] Bluetooth: Fix LE pairing completion on connection
 failure
Message-ID: <20120607091825.GA16592@x220.ccr.corp.intel.com>
References: <1339025829-9414-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339025829-9414-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Thu, Jun 07, 2012, Vishal Agarwal wrote:
> +static void le_connect_complete_cb(struct hci_conn *conn, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +
> +	BT_DBG("status %u", status);
> +
> +	if (!status && conn->type == LE_LINK)
> +		return;

The patch looks good to me except that this test for LE_LINK seems
unnecessary since this callback is anyway only used for LE. Could you
remove it?

Johan
