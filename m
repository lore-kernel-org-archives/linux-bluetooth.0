Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jul 2014 10:27:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Set Simultaneous LE and BR/EDR controller
 option to zero
Message-ID: <20140727072711.GA12453@t440s.P-661HNU-F1>
References: <1406225056-16491-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406225056-16491-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 24, 2014, Marcel Holtmann wrote:
> With the Bluetooth 4.1 specification the Simultaneous LE and BR/EDR
> controller option has been deprecated. It shall be set to zero and
> ignored otherwise.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  net/bluetooth/mgmt.c     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
