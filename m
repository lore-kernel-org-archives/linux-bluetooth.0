Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 22:14:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix too long line with set_advertising()
 function
Message-ID: <20131010201443.GA9414@x220.p-661hnu-f1>
References: <1381423675-2207-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381423675-2207-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The function declaration goes over 80 characters, so break it down.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

All three patches have been applied to bluetooth-next.

Johan
