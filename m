Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Update New CSRK event to match latest specification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425024673-19657-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 27 Feb 2015 09:31:50 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0D22B6E9-2991-4DF0-B2AF-5658EB8B8448@holtmann.org>
References: <1425024673-19657-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The 'master' parameter of the New CSRK event was recently renamed to
> 'type', with the old values kept for backwards compatibility as
> unauthenticated local/remote keys. This patch updates the code to take
> into account the two new (authenticated) values and ensures they get
> used based on the security level of the connection that the respective
> keys get distributed over.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> include/net/bluetooth/mgmt.h     |  7 ++++++-
> net/bluetooth/mgmt.c             |  2 +-
> net/bluetooth/smp.c              | 10 ++++++++--
> 4 files changed, 16 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

