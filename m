Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 10:05:52 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Bluetooth: mgmt: Allow connectable/discoverable
 changes in off state
Message-ID: <20120222080549.GC24328@aemeltch-MOBL1>
References: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Feb 21, 2012 at 07:43:44PM +0200, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch makes it possible to toggle the connectable & discoverable
> settings when powered off. Two new hdev->dev_flags flags are added to
> track what the scan mode should be when the device is finally powered
> on.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

...

> +
> +	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {

Is this really the best we can do? Also applies to other similar code.

Best regards 
Andrei Emeltchenko 

