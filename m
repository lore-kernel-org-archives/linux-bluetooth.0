Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:29:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/17] Bluetooth: Add macros for filter duplicates values
Message-ID: <20130417082912.GC6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
 <1365117675-2202-4-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365117675-2202-4-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Apr 04, 2013, Andre Guedes wrote:
> This patch adds macros for filter_duplicates parameter values from
> HCI LE Set Scan Enable command. It also fixes le_scan_enable_req
> function so it uses the LE_SCAN_FILTER_DUP_ENABLE macro instead of
> a magic number.
> 
> The LE_SCAN_FILTER_DUP_DISABLE was also defined since it will be
> required to properly support the GAP Observer Role.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h | 2 ++
>  net/bluetooth/hci_core.c    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
