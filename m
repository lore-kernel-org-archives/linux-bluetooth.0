Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 14/15] Bluetooth: Add debugfs entry for RPA regeneration timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-15-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:15:13 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <3829B576-2DC2-4184-BD81-01CA13DB9DE5@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-15-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a rpa_timeout debugfs entry which can be used to set the
> RPA regeneration timeout to something else than the default 15 minutes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index eeeeda7e6b70..ecd147e51f45 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -492,6 +492,31 @@ static int idle_timeout_get(void *data, u64 *val)
> DEFINE_SIMPLE_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
> 			idle_timeout_set, "%llu\n");
> 
> +static int rpa_timeout_set(void *data, u64 val)
> +{
> +	struct hci_dev *hdev = data;
> +

if we are doing this in seconds, we might want to set some limits here. Don’t know which make sense, but something like at least 30 seconds and not more than 24 hours.

> +	hci_dev_lock(hdev);
> +	hdev->rpa_timeout = val;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}

Regards

Marcel

