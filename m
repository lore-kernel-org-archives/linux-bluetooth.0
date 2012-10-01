Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:42:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 0/4] Fix losing Service Changed indication
Message-ID: <20121001084241.GC22036@x220>
References: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Sep 28, 2012, Claudio Takahasi wrote:
> Apply after:
> "gatt: Remove reading Service Changed characteristic after connected"
> sent from Andrzej Kaczmarek
> 
> This patch series adds Service Changed characteristic handle storage
> allowing GATT service to manage Service Changed indication when the
> connection is established.
> 
> The patch to remove the entry from "gatt" file will be sent in the next
> patch series. It is unclear to me if we need to extend the device or
> profile drive to indicate that the device is being removed/purged from
> the system or if the expected implementation is to move to per-device
> storage(TODO file). At the moment, it is not possible to detect in the
> drivers remove callback if the device is being removed from the system
> or if it bluetoothd is exiting.
> 
> 
> Claudio Takahasi (4):
>   gatt: Remove unneeded handle range check
>   gatt: Ignore Service Changed if not bonded
>   gatt: Add storing Service Changed handle
>   gatt: Add reading stored Service Changed handle
> 
>  profiles/gatt/gas.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 83 insertions(+), 7 deletions(-)

All patches in this set have been applied. Thanks.

Johan
