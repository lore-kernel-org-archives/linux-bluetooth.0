Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jun 2012 12:27:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Fix sending HCI_Disconnect only after
 connection
Message-ID: <20120614152748.GD3846@joana>
References: <1339545763-23251-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339545763-23251-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

* Vishal Agarwal <vishal.agarwal@stericsson.com> [2012-06-13 05:32:43 +0530]:

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

Patch has been applied to the bluetooth.git tree (with the fix proposed by
Johan), thanks.

	Gustavo
