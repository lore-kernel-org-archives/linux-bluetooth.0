Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Oct 2013 16:54:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Read location data on AMP controller init
Message-ID: <20131007145449.GA31497@x220.p-661hnu-f1>
References: <1381143353-57149-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381143353-57149-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 07, 2013, Marcel Holtmann wrote:
> When initializing an AMP controller, read its current known location
> data so that it can be analyzed later on.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 2 ++
>  net/bluetooth/hci_core.c    | 3 +++
>  2 files changed, 5 insertions(+)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
