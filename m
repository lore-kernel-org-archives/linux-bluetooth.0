Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 13:45:03 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 1/6] Bluetooth: LE scan should send Discovering events
Message-ID: <20120203214503.GA32258@x220.globalsuite.net>
References: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 03, 2012, Andre Guedes wrote:
> Send MGMT Discovering events once LE scan starts/stops so the
> userspace can track when local adapters are discovering LE devices.
> 
> This way, we also keep the same behavior of inquiry which sends MGMT
> Discovering events once inquiry starts/stops even if it is triggered
> by an external tool (e.g. hcitool).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    2 ++
>  net/bluetooth/hci_event.c        |    5 +++++
>  3 files changed, 8 insertions(+), 0 deletions(-)

All six patches have been applied to my bluetooth-next tree. Thanks.

Johan
