Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 21:35:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make mgmt_new_link_key() return void
Message-ID: <20131015183554.GB31747@x220.p-661hnu-f1>
References: <1381857357-45105-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381857357-45105-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> The return value of mgmt_new_link_key() function is not used
> and so just change it to return void.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 4 ++--
>  net/bluetooth/mgmt.c             | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
