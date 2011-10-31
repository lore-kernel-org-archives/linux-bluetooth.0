Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:31:28 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set HCI_MGMT flag only in read_controller_info
Message-ID: <20111031193128.GF10164@joana>
References: <1319488586-2779-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319488586-2779-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-10-24 22:36:26 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The HCI_MGMT flag should only be set when user space requests the full
> controller information. This way we avoid potential issues with setting
> change events ariving before the actual read_controller_info command
> finishes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
