Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 16:21:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Only one command per L2CAP LE signalling is
 supported
Message-ID: <20131003132138.GA26422@x220.p-661hnu-f1>
References: <1380788797-8001-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380788797-8001-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 03, 2013, Marcel Holtmann wrote:
> The Bluetooth specification makes it clear that only one command
> should be present in the L2CAP LE signalling packet. So tighten
> the checks here and restrict it to exactly one command.
> 
> This is different from L2CAP BR/EDR signalling where multiple
> commands can be part of the same packet.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 44 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

The patch and resulting code looks fine to me. I also did some basic
tests which were fine. The patch is now applied to bluetooth-next.
Thanks.

Johan
