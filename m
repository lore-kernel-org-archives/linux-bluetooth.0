Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 08:32:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose current identity information in debugfs
Message-ID: <20140224063231.GA16823@x220.p-661hnu-f1>
References: <1393188265-55337-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393188265-55337-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 23, 2014, Marcel Holtmann wrote:
> When using LE Privacy it is useful to know the local identity address,
> identity address type and identity resolving key. For debugging purposes
> add these information to debugfs.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
