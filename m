Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 22:33:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use l2cap_pi(sk) directly where possible
Message-ID: <20131013193328.GC30265@x220.p-661hnu-f1>
References: <1381689367-7104-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381689367-7104-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> There are few places where it makes sense to use l2cap_pi(sk) directly
> instead of assigning it to temporary structure.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_sock.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
