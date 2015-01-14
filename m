Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 10:02:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move Delete Stored Link Key to 4th phase of
 initialization
Message-ID: <20150114080242.GB19106@t440s.P-661HNU-F1>
References: <1421131642-7284-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421131642-7284-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 12, 2015, Marcel Holtmann wrote:
> This moves the execution of Delete Stored Link Key command to the
> hci_init4_req phase. No actual code has been changed. The command
> is just executed at a later stage of the initialization.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 

Applied to bluetooth-next. Thanks.

Johan
