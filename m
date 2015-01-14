Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 13:47:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 2/2] Bluetooth: Add restarting to service discovery
Message-ID: <20150114114753.GB20393@t440s.lan>
References: <1420811176-31658-1-git-send-email-jpawlowski@google.com>
 <1420811176-31658-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420811176-31658-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Jan 09, 2015, Jakub Pawlowski wrote:
>  	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> -	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
> +	    (rssi == HCI_RSSI_INVALID || (rssi < hdev->discovery.rssi &&
> +	    !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))

This doesn't look like it's following the coding-style of split lines.
You probably need to move the "(rssi < hdev->discovery.rssi &&" to start
from a new line so that you can align the "!test_bit(..." properly.

Johan
