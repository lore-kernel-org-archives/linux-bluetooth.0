Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:29:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/17] Bluetooth: Rename LE_SCANNING_* macros
Message-ID: <20130417082927.GD6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
 <1365117675-2202-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365117675-2202-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Apr 04, 2013, Andre Guedes wrote:
> This patch renames LE_SCANNING_ENABLED and LE_SCANNING_DISABLED
> macros to LE_SCAN_ENABLE and LE_SCAN_DISABLE in order to keep
> the same prefix others LE scan macros have.
> 
> It also fixes le_scan_enable_req function so it uses the LE_SCAN_
> ENABLE macro instead of a magic number.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h | 4 ++--
>  net/bluetooth/hci_core.c    | 2 +-
>  net/bluetooth/hci_event.c   | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
