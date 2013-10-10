Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 00:21:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove pointless check of hci_send_frame
 parameter
Message-ID: <20131010222141.GC4228@x220.p-661hnu-f1>
References: <1381436997-51094-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381436997-51094-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The hdev parameter of hci_send_frame must be always valid. If the hdev
> is not valid, it would not even make it to this stage. The callers
> will have already accessed hdev at that point many times.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
