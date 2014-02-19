Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 06:09:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Report identity address when remote
 device connects
Message-ID: <20140219040937.GA13827@x220.p-661hnu-f1>
References: <1392762140-18655-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392762140-18655-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> When the remote device has been successfully connected, report the
> identity address (public address or static random address).
> 
> Currently the address from the HCI_LE_Connection_Complete event is
> used. This was no problem so far, but since now known resolvable
> random addresses are converted into identities, it is important to
> use the identity of the connection and not the address report by
> HCI event.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
