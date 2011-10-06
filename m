Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 18:49:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Add support for cancelling a LE Scan with
 Control-C
Message-ID: <20111006154947.GA10744@fusion.localdomain>
References: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Oct 06, 2011, Vinicius Costa Gomes wrote:
> ---
> +static void sigint_handler(int sig)
> +{
> +	int err;
> +
> +	setsockopt(signal_data.fd, SOL_HCI, HCI_FILTER, &signal_data.of, sizeof(signal_data.of));
> +
> +	err = hci_le_set_scan_enable(signal_data.fd, 0x00, 0x00, 1000);
> +	if (err < 0) {
> +		perror("Disable scan failed");
> +		exit(1);
> +	}
> +
> +	hci_close_dev(signal_data.fd);
> +
> +	exit(0);
> +}

To my understanding the general recommendation is to do as little as
possible within signal handlers. Would it therefore make more sense to
simply set a flag (indicating which signal was received) in the handler,
and then do the necessary cleanup within the original function by
handling EINTR there (presumably returned by the read system call)?

Johan
