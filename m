Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 08:55:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose current list of identity resolving
 keys via debugfs
Message-ID: <20140219065501.GA3178@x220.p-661hnu-f1>
References: <1392789289-40436-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392789289-40436-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> For debugging purposes expose the current list of identity resolving
> keys via debugfs. This file is read-only and limited to root access.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
