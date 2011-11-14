Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 20:54:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix removing storage for device over BR/EDR
Message-ID: <20111114185437.GC12675@fusion.localdomain>
References: <1320675380-23186-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320675380-23186-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Nov 07, 2011, Claudio Takahasi wrote:
> "characteristic", "attributes" and "ccc" files will be shared by both
> transports: LE and BR/EDR. Remove the entry from the "primary" file
> should be the last operation to clean the storage properly if the
> device operation mode is GATT/ATT over BR/EDR.
> ---
>  Dependencies:
>  [PATCH BlueZ 0/7] CCC persistence
>  [PATCH BlueZ 0/2] CCC for bonded devices
> 
>  src/storage.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
