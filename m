Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:27:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose current list of long term keys via
 debugfs
Message-ID: <20131019132756.GD11607@x220.p-661hnu-f1>
References: <1382137017-56186-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382137017-56186-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> For debugging purposes expose the current list of long term keys
> via debugfs. This file is read-only and limited to root access.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
