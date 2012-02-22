Return-Path: <cyrus@holtmann.org>
Message-ID: <1329909399.2049.32.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: Remove unneeded hci_cc_read_ssp_mode
 function
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 12:16:39 +0100
In-Reply-To: <1329909172-19958-2-git-send-email-johan.hedberg@gmail.com>
References: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
	 <1329909172-19958-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The kernel has no need to track the hci_read_ssp_mode command since it
> has the hci_sent_cmd_data function to check what value was set when
> hci_write_ssp_mode completes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   19 -------------------
>  1 files changed, 0 insertions(+), 19 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


