Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fallback eSCO to SCO on error 0x1a
 (Unsupported Remote Feature).
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jaikumar Ganesh <jaikumar@google.com>
In-Reply-To: <1265226146-49005-1-git-send-email-npelly@google.com>
References: <1265226146-49005-1-git-send-email-npelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 12:06:22 -0800
Message-ID: <1265227582.31341.133.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> General Motors carkits that use LGE BT chipsets return this error code when
> an eSCO is attempted, despite advertising eSCO support.
> 
> 2009-08-13 14:41:39.755518 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>    handle 1 voice setting 0x0060
> 2009-08-13 14:41:39.757563 > HCI Event: Command Status (0x0f) plen 4
>    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2009-08-13 14:41:39.789484 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
>    status 0x1a handle 257 bdaddr 00:1E:B2:23:5E:B3 type eSCO
>    Error: Unsupported Remote Feature / Unsupported LMP Feature
> 
> Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
> Signed-off-by: Nick Pelly <npelly@google.com>

I applied this patch to the bluetooth-2.6 tree. Thanks.

Regards

Marcel


