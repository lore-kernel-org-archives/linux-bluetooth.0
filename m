Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: Fix resetting remote authentication requirement after pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405599290-22911-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 14:30:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6369DF29-6C17-44F7-8F60-695E0E55E0EE@holtmann.org>
References: <1405599161-22759-1-git-send-email-johan.hedberg@gmail.com> <1405599290-22911-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When a new hci_conn object is created the remote SSP authentication
> requirement is set to the invalid value 0xff to indicate that it is
> unknown. Once pairing completes however the code was leaving it as-is.
> In case a new pairing happens over the same connection it is important
> that we reset the value back to unknown so that the pairing code doesn't
> make false assumptions about the requirements.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix incomplete sentence in commit message
> 
> net/bluetooth/hci_event.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

