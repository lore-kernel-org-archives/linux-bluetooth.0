Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 11 Feb 2011 15:43:05 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Oliver Neukum <oneukum@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@kernel.org, ensonic@sonicpulse.de
Subject: Re: [PATCH] btusb:fix crash with quirky dongles doing sound
Message-ID: <20110211174305.GB2173@joana>
References: <201102111300.06470.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102111300.06470.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

* Oliver Neukum <oneukum@suse.de> [2011-02-11 13:00:06 +0100]:

> From befd2cd1a7875d395f72b38f2cb89a03f16edaba Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 11 Feb 2011 12:35:05 +0100
> Subject: [PATCH] btusb:fix crash with quirky dongles doing sound
> 
> Quirky dongles sometimes do not use the iso interface which
> causes a crash with runtime PM
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/bluetooth/btusb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied. It should be in mainline soon. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
