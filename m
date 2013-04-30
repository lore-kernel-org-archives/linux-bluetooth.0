Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:21:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 02/13] Bluetooth: Make inquiry_cache_flush non-static
Message-ID: <20130430082113.GD777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> In order to use HCI request framework in start_discovery, we'll need
> to call inquiry_cache_flush in mgmt.c. Therefore, this patch adds the
> hci_ prefix to inquiry_cache_flush and makes it non-static.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
