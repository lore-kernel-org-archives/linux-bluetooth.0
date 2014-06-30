Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2014 07:59:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add Device Added and Device Removed
 management events
Message-ID: <20140630045900.GA25549@t440s.P-661HNU-F1>
References: <1404073714-36369-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404073714-36369-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> When devices are added or removed, then make sure that events are send
> out to all other clients so that the list of devices can be easily
> tracked. This is especially important when external clients are
> adding or removing devices within the auto-connection list.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 11 +++++++++++
>  net/bluetooth/mgmt.c         | 29 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
