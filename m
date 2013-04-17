Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:28:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/17] Bluetooth: Add LE scan type macros
Message-ID: <20130417082858.GB6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
 <1365117675-2202-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365117675-2202-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Apr 04, 2013, Andre Guedes wrote:
> This patch adds macros for active and passive LE scan type values.
> The LE_SCAN_PASSIVE was also defined since it will be used in future
> by LE connection routine and GAP Observer Role support.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h | 3 +++
>  net/bluetooth/mgmt.c        | 7 +++----
>  2 files changed, 6 insertions(+), 4 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
