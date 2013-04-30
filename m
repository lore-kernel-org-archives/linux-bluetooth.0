Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:37:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 11/13] Bluetooth: Remove inquiry helpers
Message-ID: <20130430083707.GM777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-12-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-12-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> This patch removes hci_do_inquiry and hci_cancel_inquiry helpers. We
> now use the HCI request framework in device discovery functionality
> and these helpers are no longer needed.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 --
>  net/bluetooth/hci_core.c         | 30 ------------------------------
>  2 files changed, 32 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
