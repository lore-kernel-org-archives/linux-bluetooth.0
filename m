Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 22:01:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add paranoid check for existing LE and
 BR/EDR SMP channels
Message-ID: <20150115200146.GA13149@t440s.P-661HNU-F1>
References: <1421337861-22334-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421337861-22334-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 15, 2015, Marcel Holtmann wrote:
> When the SMP channels have been already registered, then print out a
> clear WARN_ON message that something went wrong. Also unregister the
> existing channels in this case before trying to register new ones.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
