Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 13:08:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check minimum length of SMP packets
Message-ID: <20131003100824.GB7519@x220.p-661hnu-f1>
References: <1380788588-7897-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380788588-7897-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 03, 2013, Marcel Holtmann wrote:
> When SMP packets are received, make sure they contain at least 1 byte
> header for the opcode. If not, drop the packet and disconnect the link.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
