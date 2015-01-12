Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 11:27:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Simplify packet copy in
 hci_send_to_monitor function
Message-ID: <20150112092714.GC4548@t440s.lan>
References: <1421033613-31738-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421033613-31738-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 11, 2015, Marcel Holtmann wrote:
> Within the monitor functionality, the global atomic variable called
> monitor_promisc ensures that no memory allocation happend when there
> is actually no client listening. This means it is safe to just create
> a copy of the skb since it is guaranteed that at least one client
> exists. No extra checks needed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
