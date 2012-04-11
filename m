Return-Path: <cyrus@holtmann.org>
Message-ID: <1334136200.16897.97.camel@aeonflux>
Subject: Re: [PATCH v0 3/6] Bluetooth: Remove unused HCI event handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 11 Apr 2012 11:23:20 +0200
In-Reply-To: <1334126932-27327-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-4-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> Function hci_num_comp_pkts_evt() doesn't need to handle SCO connections
> unless SCO flow control is explicitly enabled, as described in the
> Bluetooth Core Specification, Volume 4, Part B, section 7.7.19.
> 
> Even in the unlikely case that the hardware supports this feature, the
> kernel does not enable it.

I am not sure that we should just remove this. What happens if you run
on a controller that has this enabled? I rather have the support for it
added then.

Regards

Marcel


