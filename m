Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 00:12:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
Message-ID: <20120216221213.GA3889@x220.ger.corp.intel.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
 <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Feb 16, 2012, Andre Guedes wrote:
>  #define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
> +#define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
> +
>  
>  #define SERVICE_CACHE_TIMEOUT (5 * 1000)

One unnecessary empty line added above.

> +int mgmt_interleaved_discovery(struct hci_dev *hdev)
> +{
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
> +	if (err < 0) {
> +		hci_dev_lock(hdev);
> +		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		hci_dev_unlock(hdev);
> +	}
> +
> +	return err;
> +}

The locking doesn't look right to me above. hci_do_inquiry should be
called with the lock held. I think it might be simpler if you make
mgmt_interleaved_discovery() require the caller to hold the lock.

Johan
