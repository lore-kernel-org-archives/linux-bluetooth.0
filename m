Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 03:07:06 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use separate function for BCM92035 vendor
 setup
Message-ID: <20130411060706.GB19253@joana>
References: <1365606695-43841-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365606695-43841-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-04-10 08:11:35 -0700]:

> Trying to squeeze every single vendor setup routine into the same function
> and have it assigned all the time is actually a bad idea. Especially since
> the core can handle the absence of a setup routine perfectly fine.
> 
> To make this a lot simpler for future additions of vendor setup code,
> split the BCM92035 setup into its own function and only assign it when
> this specific device has been detected.
> 
> Doing it like this has the nice side benefit that we do not have to keep
> a copy of the driver_info around.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 52 ++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
