Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Nov 2015 15:43:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix issue with HCI_QUIRK_FIXUP_INQUIRY_MODE
 and event mask
Message-ID: <20151101134355.GA30594@t440s.P-661HNU-F1>
References: <1446367522-70459-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446367522-70459-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 01, 2015, Marcel Holtmann wrote:
> When setting the event mask, the HCI_QUIRK_FIXUP_INQUIRY_MODE quirk is
> required to be checked so that the Inquiry Result with RSSI event gets
> actually enabled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
