Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:28:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/17] Bluetooth: Change LE scanning timeout macros
Message-ID: <20130417082844.GA6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
 <1365117675-2202-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365117675-2202-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Apr 04, 2013, Andre Guedes wrote:
> Define LE scanning timeout macros in jiffies just like we do for
> others timeout macros.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  net/bluetooth/mgmt.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
