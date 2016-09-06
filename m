Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 6 Sep 2016 12:22:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send control open and close messages for HCI
 user channels
Message-ID: <20160906092241.GB17371@t440s.lan>
References: <1472752108-100322-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472752108-100322-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Sep 01, 2016, Marcel Holtmann wrote:
> When opening and closing HCI user channel, send monitoring messages to
> be able to trace its behavior.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
