Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 12:27:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use BDADDR_BREDR type for old blacklist ioctl
 interface
Message-ID: <20131018092756.GA24891@x220.p-661hnu-f1>
References: <1382083828-23001-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382083828-23001-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> The old blacklist ioctl interface was only able to operate on BR/EDR
> addresses. So use the BDADDR_BREDR address type definition instead
> of an open coded magic 0 value.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
