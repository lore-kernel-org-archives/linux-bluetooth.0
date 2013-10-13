Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 20:03:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Access RFCOMM session addresses through
 L2CAP channel
Message-ID: <20131013170317.GC29427@x220.p-661hnu-f1>
References: <1381682997-26437-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381682997-26437-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The L2CAP socket structure does not contain the address information
> anymore. They need to be accessed through the L2CAP channel.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/rfcomm/core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

All four patches have been applied to bluetooth-next. Thanks.

Johan
