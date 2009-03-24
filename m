Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fallback from eSCO to SCO on error code
 0x1f (unspecified error).
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960903240922y2f956ccnd4f1c81092235fa@mail.gmail.com>
References: <1237911625-20893-1-git-send-email-npelly@google.com>
	 <35c90d960903240922y2f956ccnd4f1c81092235fa@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 11:59:25 +0100
Message-Id: <1237892365.4740.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

like I told everybody else; NO top posting.

> Here is the hcidump that prompted this patch:
> 
> 009-03-23 17:43:50.727376 < HCI Command: Setup Synchronous Connection
> (0x01|0x0028) plen 17
>   handle 1 voice setting 0x0060
> 2009-03-23 17:43:50.746969 > HCI Event: Command Status (0x0f) plen 4
>   Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> 2009-03-23 17:43:50.909963 > HCI Event: Synchronous Connect Complete
> (0x2c) plen 17
>   status 0x1f handle 257 bdaddr 00:14:0A:01:E1:67 type eSCO
>   Error: Unspecified Error
> 
> I have confirmed that with this patch we successfully fall back to SCO
> with the Kyocera ED-8800

can you also send me the output of hcitool info, because this error is
kinda weird to get.

I am also suspicious about the TI chip now since I think that we are
working around the stupidity of that chip and not any kind of remote
headset. I would like to see the air trace (LMP negotiation) for this
specific headset.

Regards

Marcel


