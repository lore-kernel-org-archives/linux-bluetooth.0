Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2] Bluetooth: Add AES crypto context for each HCI device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392712807-4565-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Feb 2014 00:54:36 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B49F7AB2-0C1B-4C8A-8FB9-84E9874AD845@holtmann.org>
References: <1392711577-31431-4-git-send-email-johan.hedberg@gmail.com> <1392712807-4565-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Previously the crypto context has only been available for LE SMP
> sessions, but now that we'll need to perform operations also during
> discovery it makes sense to have this context part of the hci_dev
> struct. Later, the context can be removed from the SMP context.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Properly initialize "error" if crypto init fails
> 
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 17 ++++++++++++++++-
> 2 files changed, 17 insertions(+), 1 deletion(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

