Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 17:01:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Remove pointless parameter check in
 bfusb_send_frame()
Message-ID: <20131011150128.GA20347@x220.p-661hnu-f1>
References: <1381500064-24414-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381500064-24414-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> The hdev parameter of bfusb_send_frame() is always valid. If it were
> not valid, then it would have crashed earlier in the call chain.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bfusb.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

All eight patches have been applied to bluetooth-next. Thanks.

Johan
