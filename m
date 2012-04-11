Return-Path: <cyrus@holtmann.org>
Message-ID: <1334136396.16897.99.camel@aeonflux>
Subject: Re: [PATCH v0 5/6] Bluetooth: btusb: Dynamic alternate setting
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 11 Apr 2012 11:26:36 +0200
In-Reply-To: <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> The alternate setting must be dynamically set according to the number of
> active SCO links, and the bit depth of the audio. The possible values
> for the alternate setting are described in the Bluetooth Core
> Specification, Volume 4, Part B, section 2.1.1.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  drivers/bluetooth/btusb.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


