Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 14:54:41 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Clean up logic in hci_cc_write_scan_enable
Message-ID: <20111107165441.GB2651@joana>
References: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-04 00:17:45 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds a new label to hci_cc_write_scan_enable to avoid
> unnecessary indentation. This will be convenient especially when new
> code for the discoverable timeout gets added.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   46 +++++++++++++++++++++++---------------------
>  1 files changed, 24 insertions(+), 22 deletions(-)

Applied, thanks.

	Gustavo
