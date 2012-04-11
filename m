Return-Path: <cyrus@holtmann.org>
Message-ID: <1334136121.16897.96.camel@aeonflux>
Subject: Re: [PATCH v0 2/6] Bluetooth: Remove unnecessary check
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 11 Apr 2012 11:22:01 +0200
In-Reply-To: <1334126932-27327-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-3-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> The function already fails if the given size is greater than the MTU, so
> there is no need to consider that case afterwards.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  net/bluetooth/sco.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


