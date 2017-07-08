Return-Path: <ian@mnementh.co.uk>
Subject: Re: bdaddr
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <c81eae29-b2bd-f1df-9066-d51591ac6d8f@mnementh.co.uk>
 <16D39FFA-DA31-4996-B848-FF7B1A9356DB@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <f50f6f13-6edd-4df5-d988-5f0dd3adb518@mnementh.co.uk>
Date: Sat, 8 Jul 2017 10:07:26 +0100
MIME-Version: 1.0
In-Reply-To: <16D39FFA-DA31-4996-B848-FF7B1A9356DB@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 08:54, Marcel Holtmann wrote:
> there is a btmgmt public-addr command that does this correctly if the hdev->set_bdaddr is supported by the hardware. Using the bdaddr tool is a hack.

Oh, great - missed that, thanks.

I'll implement that in the driver.

-Ian
