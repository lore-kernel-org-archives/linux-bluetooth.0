Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Apr 2015 12:49:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_core/mgmt: Change adv inst to list.
Message-ID: <20150409094913.GB10676@t440s.lan>
References: <1428162231-17940-1-git-send-email-fgrandel@gmail.com>
 <1428258080-6275-1-git-send-email-fgrandel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428258080-6275-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Sun, Apr 05, 2015, Florian Grandel wrote:
> As a preparatory step towards multi-instance advertising it is
> necessary to introduce a data structure that supports storing
> multiple advertising info data structures for a bluetooth device.
> 
> This is introduced by refactoring the existing adv_instance member
> of the hci_dev struct into a linked list and making the necessary
> changes in the code to support this list.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
> 
> v1 -> v2: add missing braces in read_adv_features()
> 
>  include/net/bluetooth/hci_core.h |  21 ++-
>  net/bluetooth/hci_core.c         | 118 ++++++++++++-
>  net/bluetooth/mgmt.c             | 345 +++++++++++++++++++++------------------
>  3 files changed, 316 insertions(+), 168 deletions(-)

It'd be really good if you could try to split this patch up a bit. It
really is going over the limits of individual patch sizes that we're
comfortable with. See if you can split this up logically into at least
two, preferably more (3-4) patches while still keeping something that
compiles during each step.

> +			if (err == 0)
> +				advertising_removed(sk, hdev,
> +						    adv_instance->instance);
> +		}
> +	} else {
> +		err = hci_remove_adv_instance(hdev, instance);
> +		if (err == 0)
> +			advertising_removed(sk, hdev, instance);

I think if (!err) is the more consistent convension.

> +	err = hci_add_adv_instance(hdev, cp->instance, flags,
> +					 cp->adv_data_len, cp->data,
> +					 cp->scan_rsp_len,
> +					 cp->data + cp->adv_data_len,
> +					 adv_timeout_expired, timeout);

The split lines don't look like they're correctly lined up. They should
start from one column after the opening '(' on the first line.

> +	// TODO: Trigger an advertising added event even when instance
> +	// advertising is already switched on?

Please stick to /* ... */ for comments.

Johan
