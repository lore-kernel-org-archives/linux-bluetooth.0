Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Oct 2015 10:33:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Limit userspace exposure of stack
 internal events
Message-ID: <20151005073337.GB15431@t440s.lan>
References: <1443994443-123453-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443994443-123453-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 04, 2015, Marcel Holtmann wrote:
> The stack internal events that are exposed to userspace should be
> limited to HCI_DEV_REG, HCI_DEV_UNREG, HCI_DEV_UP and HCI_DEV_DOWN.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

All five patches in this set have been applied to bluetooth-next. Thanks.

Johan
