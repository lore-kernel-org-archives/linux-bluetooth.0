Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 10:31:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for entering limited discoverable
 mode
Message-ID: <20131015073157.GA24495@x220.p-661hnu-f1>
References: <1381792099-8732-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381792099-8732-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> +	if (cp->val) {
> +		struct hci_cp_write_current_iac_lap cp;
> +
> +		if (timeout > 0) {
> +			/* Limited discoverable mode */

Wouldn't we want to follow the recommendation from the Core spec here,
volume 3, part C, section 4.1.2.1:

"A Bluetooth device should not be in limited discoverable mode for more than
TGAP(104)"

TGAP(104) in turn is defined as 1 minute (vol 3, part C, Appendix A).

Johan
