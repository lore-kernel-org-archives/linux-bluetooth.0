Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:37:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 12/13] Bluetooth: Remove empty event handler
Message-ID: <20130430083717.GN777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-13-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-13-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> This patch removes the hci_cc_le_set_scan_param event handler. This
> handler became empty because failures of this event are now handled
> by start_discovery_complete function in mgmt.c.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 12 ------------
>  1 file changed, 12 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
