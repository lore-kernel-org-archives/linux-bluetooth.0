Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:27:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove bus attribute in favor of hierarchy
Message-ID: <20131019132711.GB11607@x220.p-661hnu-f1>
References: <1382125167-44247-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382125167-44247-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> The bus information are exposed in the actual hierarchy and should
> not be exposed as attribute.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sysfs.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
