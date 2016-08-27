Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 27 Aug 2016 22:35:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Check SOL_HCI for raw socket options
Message-ID: <20160827193546.GA15680@t440s.P-661HNU-F1>
References: <1472322221-86761-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472322221-86761-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Aug 27, 2016, Marcel Holtmann wrote:
> The SOL_HCI level should be enforced when using socket options on the
> HCI raw socket interface.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 6 ++++++
>  1 file changed, 6 insertions(+)

All five patches in this set have been applied to bluetooth-next. They
seem to work quite nicely with the latest btmon in bluez.git.

Johan
