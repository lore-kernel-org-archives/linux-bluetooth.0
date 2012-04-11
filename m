Return-Path: <cyrus@holtmann.org>
Message-ID: <1334136286.16897.98.camel@aeonflux>
Subject: Re: [PATCH v0 4/6] Bluetooth: Simplify outgoing SCO scheduling code
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 11 Apr 2012 11:24:46 +0200
In-Reply-To: <1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> This patch refactors the SCO scheduling algorithm to remove code that is
> not making any difference. There is no HCI SCO flow control in the
> kernel so the scheduling can be simplified.
> 
> All data produced by userspace is sent to the controller without any
> flow control. This was also the case before this patch, but now it's
> more obvious and readable.

as in the previous patch. You can only do this if you make sure that the
controller does not have flow control enabled. You need another basic
check here to ensure this first. Otherwise a lot of things might break.

Regards

Marcel


