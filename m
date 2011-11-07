Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 14:55:14 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Fix mgmt response when
 HCI_Write_Scan_Enable fails
Message-ID: <20111107165514.GC2651@joana>
References: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
 <1320358667-21086-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320358667-21086-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-04 00:17:47 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> A proper mgmt_command_status should be returned to user-space if either
> discoverable or connectable enabling fails.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    9 ++++++---
>  net/bluetooth/mgmt.c             |   13 +++++++++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)

Applied, thanks.

	Gustavo
