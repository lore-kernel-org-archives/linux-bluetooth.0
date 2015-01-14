Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 13:44:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 1/2] Bluetooth: Add le_scan_restart
Message-ID: <20150114114407.GA20393@t440s.lan>
References: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Jan 09, 2015, Jakub Pawlowski wrote:
> Currently there is no way to restart le scan, and it's needed in
> service scan method. The way it work: it disable, and then enable le
> scan on controller.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci_core.h |  3 +++
>  net/bluetooth/hci_core.c         | 54 ++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             |  7 +++++-
>  3 files changed, 63 insertions(+), 1 deletion(-)

In general this approach looks definitely simper to me as well - I think
we're getting closer to something that can go upstream :)

The main issues I've got concerns about anymore is the complexity coming
from various if-conditions here and there (which might be simplifiable
by refactoring some common tasks into smaller helper functions) as well
as some minor coding style issues.

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 89f4e3c..add94f6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -79,6 +79,7 @@ struct discovery_state {
>  	s8			rssi;
>  	u16			uuid_count;
>  	u8			(*uuids)[16];
> +	long		scan_end;

I hope this is properly aligned with the other variables? It could be
the initial non-tab characters that mess this up when looking at the
diff or what I just quoted, but there the variables don't line up.

> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
> +{
> +	BT_DBG("%s", hdev->name);
> +
> +	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
> +	    hdev->discovery.scan_end != 0) {
> +		long timeout = hdev->discovery.scan_end - jiffies;
> +
> +		if (timeout < 0)
> +			timeout = 0;
> +		queue_delayed_work(hdev->workqueue,
> +				   &hdev->le_scan_disable, timeout);
> +	}
> +
> +	if (status)
> +		BT_ERR("Failed to restart LE scan: status %d", status);
> +}

This doesn't look right. Shouldn't the status check be at the very
beginning of the function? If restarting scanning failed, what's the
point of queuing the delayed work to disable scanning?

> +	err = hci_req_run(&req, le_scan_restart_work_complete);
> +
> +	if (err)
> +		BT_ERR("Restart LE scan request failed: err %d", err);

You can drop the empty line between assignment to err and the check for
its value.

Johan
