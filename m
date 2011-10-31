Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 31 Oct 2011 18:02:19 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Paul Fertser <fercerpav@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: output firmware filename when request_firmware
 failed
Message-ID: <20111031200219.GM10164@joana>
References: <1319910769-28518-1-git-send-email-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319910769-28518-1-git-send-email-fercerpav@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paul,

* Paul Fertser <fercerpav@gmail.com> [2011-10-29 21:52:49 +0400]:

> This makes it much easier for the users to understand why the driver
> refuses to load when the firmware is unavailable.
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)

Applied, thanks.

	Gustavo
