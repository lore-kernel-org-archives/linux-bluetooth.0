Return-Path: <cyrus@holtmann.org>
Message-ID: <1334136061.16897.95.camel@aeonflux>
Subject: Re: [PATCH v0 1/6] Bluetooth: Use unsigned int instead of signed int
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 11 Apr 2012 11:21:01 +0200
In-Reply-To: <1334126932-27327-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-2-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> The involved values are all unsigned and thus unsigned int should be
> used instead of signed int. Assigning ~0 to a signed int results in -1,
> which is confusing and error-prone, while the code is trying to set the
> maximum value possible.
> 
> The code still works because the C standard defines that unsigned
> comparison will be performed in these cases, when comparing an unsigned
> int and a signed int.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


