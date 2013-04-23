Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 12:27:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded parameter from L2CAP ATT
 channel handling
Message-ID: <20130423092734.GA15524@x220>
References: <1366703940-27816-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366703940-27816-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 23, 2013, Marcel Holtmann wrote:
> The CID is fixed to L2CAP ATT channel and so there is no need to hand it
> down to the handling function. Just use a constant instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Looks good to me.

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
