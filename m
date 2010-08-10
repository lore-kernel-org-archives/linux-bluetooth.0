Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 15:16:16 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Scherba <dscherba@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI
 commands
Message-ID: <20100810191616.GA26091@jh-x301>
References: <4C6173CA.8060308@codeaurora.org>
 <1281455145-1777-1-git-send-email-dscherba@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281455145-1777-1-git-send-email-dscherba@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Aug 10, 2010, David Scherba wrote:
> --- a/lib/hci_lib.h
> +++ b/lib/hci_lib.h
> @@ -169,6 +169,11 @@ static inline int hci_test_bit(int nr, void *addr)
>  	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
>  }
>  
> +static inline int ignore_device(struct hci_dev_info *di)
> +{
> +	return hci_test_bit(HCI_RAW, &di->flags) || di->type >> 4 != HCI_BREDR;
> +}

Since this is hci_lib.h (something I didn't realize in the previous
review) the function should follow the same namespace as all other
functions in the header file, i.e. hci_*. However, does the function
really need to be exported in this public library header file, i.e.
isn't there some private header file that could be used instead?

Johan
