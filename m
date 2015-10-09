Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Oct 2015 17:29:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Queue diagnostic messages together with
 HCI packets
Message-ID: <20151009142938.GA32635@t440s.P-661HNU-F1>
References: <1444392563-12977-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444392563-12977-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 09, 2015, Marcel Holtmann wrote:
> Sending diagnostic messages directly to the monitor socket might cause
> issues for devices processing their messages in interrupt context. So
> instead of trying to directly forward them, queue them up with the other
> HCI packets and lets them be processed by the sockets at the same time.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
