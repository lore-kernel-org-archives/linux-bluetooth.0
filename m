Return-Path: <cyrus@holtmann.org>
Message-ID: <1359442248.16748.40.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix handling of unexpected SMP PDUs
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 29 Jan 2013 07:50:48 +0100
In-Reply-To: <1359417846-5064-1-git-send-email-johan.hedberg@gmail.com>
References: <1359417846-5064-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hdev->smp_chan pointer can be NULL if SMP PDUs arrive at unexpected
> moments. To avoid NULL pointer dereferences the code should be checking
> for this and simply ignore such PDUs. This patch fixes the issue by
> adding the checks into each individual PDU handler. It's done there
> instead of a global place since for some PDUs it *is* ok for smp_chan to
> be NULL (e.g. pairing request and security request).

I am not sure we want to ignore such PDUs. Don't we have to respond with
an error and actually disconnect at this point. Otherwise this might
open up a denial of service attack.

Regards

Marcel


