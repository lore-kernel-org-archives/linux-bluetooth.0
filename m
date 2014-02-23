Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v4] Bluetooth: Ensure hci_conn always contains the local identity address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393186020-6383-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 23 Feb 2014 12:44:04 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <5AF1AA26-EBED-4AF9-AD4C-E5B9BB1AFBAA@holtmann.org>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com> <1393186020-6383-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To be consistent with the remote address info in hci_conn we want it to
> also contain the local identity address information. The struct will
> contain the actual address used for the connection while a connection
> process is in place but as soon as we have a successful connection the
> identity address should be tracked instead.
> 
> This patch updates the code to set the src and src_type values to point
> at the identity address in the hci_le_conn_complete_evt function. The
> identity address can either be a public address or a static random
> address.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v4: Fix commit message not to refer to non-existent functions

I fixed up the commit messages and add some extra comments. Now all 13 patches have been applied bluetooth-next tree.

Regards

Marcel

