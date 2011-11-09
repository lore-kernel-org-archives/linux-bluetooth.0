Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Nov 2011 12:34:44 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add missing hci_dev locking when calling
 mgmt functions
Message-ID: <20111109143444.GG25584@joana>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
 <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-08 20:40:16 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> Now that the pending commands are within struct hci_dev we can properly
> control access to them throught the hci_dev locking mechanism.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   12 ++++++++++--
>  net/bluetooth/hci_event.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
>  net/bluetooth/mgmt.c      |   13 +++++++------
>  3 files changed, 57 insertions(+), 13 deletions(-)

The 3 patches where applied, thanks.

	Gustavo
