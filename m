Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:01:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH 3/7] Refactoring adapter_update_found_devices() function
Message-ID: <20101111100158.GE4132@jh-x301>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
 <1289411487-6113-3-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289411487-6113-3-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010, Anderson Lizardo wrote:
> +void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> +				int8_t rssi, uint32_t class, const char *name,
> +				const char *alias, gboolean legacy,
> +				name_status_t name_status, uint8_t *eir_data)
> +{
> +	struct remote_dev_info *dev;
> +
> +	if (!update_found_devices(adapter, bdaddr, rssi, &dev)) {
> +		dev->class = class;
> +		if (name)
> +			dev->name = g_strdup(name);
> +		if (alias)
> +			dev->alias = g_strdup(alias);
> +		dev->legacy = legacy;
> +		dev->name_status = name_status;
> +	} else if (dev->rssi == rssi)
> +		return;

I find the name and signature of update_found_devices() a little bit
unintuitive which makes following the code that uses it a bit hard.
Additionally it seems you're not using the rssi anymore within the
update_found_devices function so there's no point in passing the rssi to
it. To make the code more readable, could you change the function so
that its usage would look something like:

	struct remote_dev_info *dev;
	gboolean new_dev;

	dev = get_found_dev(adapter, bdaddr, &new_dev);

	if (new_dev) {
		<set the fields for the new device>
	} else if (dev->rssi == rssi)
		return;

	dev->rssi = rssi;
	...

Since the rest of the patches seem to depend on this one I'll stop the
review here and wait until you fix the issues I've mentioned so far.

Johan
