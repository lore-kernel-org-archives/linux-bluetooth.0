Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Mar 2015 17:48:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 2/6] Bluetooth: Refactor BR/EDR inquiry and LE scan
 triggering.
Message-ID: <20150317154832.GA11787@t440s.P-661HNU-F1>
References: <1426565973-27545-1-git-send-email-jpawlowski@google.com>
 <1426565973-27545-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426565973-27545-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Mar 16, 2015, Jakub Pawlowski wrote:
> +static bool trigger_le_scan(struct hci_request *req, __le16 interval,
> +			    u8 *status)

Minor thing here: 'interval' should be u16 and the conversion done
inside the function. It's only for raw protocol PDU data that we use the
explicit-endian types.

> +	param_cp.interval = interval;

And here you'd then do param_cp.interval = cpu_to_le16(interval);

Johan
