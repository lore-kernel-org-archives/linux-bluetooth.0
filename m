Return-Path: <johan.hedberg@gmail.com>
Date: Fri, 6 Nov 2015 10:16:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add mising hci_skb_opcode for raw socket
 commands
Message-ID: <20151106081632.GA6693@t440s.lan>
References: <1446792140-20425-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446792140-20425-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 06, 2015, Marcel Holtmann wrote:
> When HCI commands are injected via the raw socket, the core was not
> including the decoded opcode value. So ensure that it is actually set.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
