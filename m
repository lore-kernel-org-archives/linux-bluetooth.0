Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jun 2012 08:19:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Fix sending HCI_Disconnect only after
 connection
Message-ID: <20120613051941.GA30286@x220.P-661HNU-F1>
References: <1339545763-23251-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339545763-23251-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 13, 2012, Vishal Agarwal wrote:
> HCI_Disconnect should only be sent after connection is established.
> If connection is not yet established and HCI_Disconnect is called
> then disconnection complete will be received with a handle which
> does not exist and hence this event will be ignored.
> But as mgmt.c will not receive this event, its variable for pending
> command is not cleared.This will result in future Disconnect commands
> for that BD Address to be blocked with error busy.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Btw, the summary line might be a bit more understandable if you change
"only after connection" to "only when connected".

Johan
