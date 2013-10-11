Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 07:54:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove unused h4_check_data_len() function
Message-ID: <20131011055452.GA10523@x220.p-661hnu-f1>
References: <1381449163-19932-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381449163-19932-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The function h4_check_data_len() is actually not used. So just
> remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h4.c | 24 ------------------------
>  1 file changed, 24 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
