Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Apr 2013 14:32:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 4/8] core: retry bonding attempt until the iterator
 reaches the end.
Message-ID: <20130424113209.GC15231@x220.ger.corp.intel.com>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
 <1366740247-368-5-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366740247-368-5-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Apr 23, 2013, Alex Deymo wrote:
> +static void bonding_attempt_complete(struct btd_adapter *adapter,
> +					const bdaddr_t *bdaddr,
> +					uint8_t addr_type, uint8_t status)
> +{
> +	int err = 0;
> +	struct btd_device *device;
> +	char addr[18];
> +
> +	ba2str(bdaddr, addr);
> +	DBG("hci%u bdaddr %s type %u status 0x%x", adapter->dev_id, addr,
> +							addr_type, status);
> +
> +	if (status == 0)
> +		device = adapter_get_device(adapter, bdaddr, addr_type);
> +	else
> +		device = adapter_find_device(adapter, bdaddr);
> +
> +	if (status == MGMT_STATUS_AUTH_FAILED) {
> +
> +		/* On faliure, issue a bonding_retry if possible. */

Remove the empty line before this comment.

> +		if (device != NULL) {
> +			err = device_bonding_attempt_retry(device);
> +			if (err == 0)
> +				return;
> +		}

This seems to be the only place where err is used inside the function.
Typically you should define variables in the most restrictive scope
possible, but in this case since you're not doing anything special with
it you could just remove it and directly test for the return value of
device_bonding_attempt_retry().

Johan
