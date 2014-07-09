Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jul 2014 15:19:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Don't send ERTM configuration option when
 disabled
Message-ID: <20140709121913.GA23418@t440s>
References: <1404899615-4918-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404899615-4918-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 09, 2014, Marcel Holtmann wrote:
> When ERTM support is disabled, then do not even send ERTM configuration
> option even if the remote side supports it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
