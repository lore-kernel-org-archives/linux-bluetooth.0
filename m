Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Aug 2010 17:59:13 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Scherba <dscherba@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI
 commands
Message-ID: <20100809215913.GB25488@jh-x301>
References: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
 <1281388059-15945-3-git-send-email-dscherba@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281388059-15945-3-git-send-email-dscherba@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Aug 09, 2010, David Scherba wrote:
> +static inline int is_bredr_hci_device_type(uint8_t type)

Could you just call this ignore_device() which combines the AMP and RAW
checks.

> +{
> +  return (type >> 4) == HCI_BREDR;
> +}

Looks like the indentation is wrong inside the function (two spaces
instead of a tab).

> -	if (hci_test_bit(HCI_RAW, &di.flags))
> +	if (!is_bredr_hci_device_type(di.type) ||
> +	    hci_test_bit(HCI_RAW, &di.flags))

No spaces+tabs mixed indentation please. The second line should be
indented by at least two tabs more than the line above it (as many tabs
as you can as long as the line doesn't go beyond 79 characters). OTOH,
the second line goes away completely if you do the ignore_device
simplification as proposed above.

> -	if (!hci_test_bit(HCI_RAW, &di.flags))
> +	if (is_bredr_hci_device_type(di.type) &&
> +	    !hci_test_bit(HCI_RAW, &di.flags))

Same here.

> -	if (hci_test_bit(HCI_RAW, &di.flags)) {
> +	if (!is_bredr_hci_device_type(di.type) ||
> +	    hci_test_bit(HCI_RAW, &di.flags)) {

And here.

> -	if (hci_test_bit(HCI_RAW, &di->flags))
> +	if (!is_bredr_hci_device_type(di->type) ||
> +	    hci_test_bit(HCI_RAW, &di->flags))

And here.

> -	if (hci_test_bit(HCI_RAW, &di->flags))
> +	if (!is_bredr_hci_device_type(di->type) ||
> +	    hci_test_bit(HCI_RAW, &di->flags))

And here.

Johan
