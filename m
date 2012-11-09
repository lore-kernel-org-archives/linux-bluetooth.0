Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Nov 2012 10:46:41 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix memory leak when removing a UUID
Message-ID: <20121109094641.GC9183@joana>
References: <1352366726-4308-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352366726-4308-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-11-08 10:25:26 +0100]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When removing a UUID from the list in the remove_uuid() function we must
> also kfree the entry in addition to removing it from the list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
