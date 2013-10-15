Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 17:29:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Use hci_request for discoverable timeout
 handling
Message-ID: <20131015142934.GA17486@x220.p-661hnu-f1>
References: <1381844037-24424-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381844037-24424-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> When the discoverable timeout triggers and it is time to turn inquiry
> scan back off, use the HCI request framework to do it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

All seven patches have been applied to bluetooth-next. Thanks.

Johan
