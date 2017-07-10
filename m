Return-Path: <ian@mnementh.co.uk>
Subject: Re: [PATCH 4/4] bluetooth: Add HCI_QUIRK_INVALID_BDADDR for
 BCM43430A0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.co.uk>, ohad@bencohen.org
References: <20170708161228.24324-1-ian@mnementh.co.uk>
 <20170708161228.24324-4-ian@mnementh.co.uk>
 <F521381C-C901-483E-B84D-0E297A45222C@holtmann.org>
 <eb27abd9-c15a-5204-c5d0-0eea504b0ff4@mnementh.co.uk>
 <01A7B3BF-C5BC-46E9-88CB-5FB6AB101B20@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <773d2b68-9b3a-e855-d582-379cbaec7d20@mnementh.co.uk>
Date: Mon, 10 Jul 2017 18:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <01A7B3BF-C5BC-46E9-88CB-5FB6AB101B20@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/07/17 19:01, Marcel Holtmann wrote:

>> Is it intended behaviour that you cannot change the address via btmgmt
>> if the device started with a valid bdaddr? obviously this patch is
>> incorrect, but without it, btmgmt public-addr <foo> fails.
>>
>> OTOH, bdaddr does not fail - which seems inconsistent to me. Surely
>> either both should work, or both fail?
> 
> you can change them, but the you need a btmgmt power off first. Changing the address while the controller powered on is not possible. You need to reset the controller to have the changes take affect.

Aha, thats the magic sauce :) Thanks.

>> eg. - there is *no* legitimate reason for userspace to send a firmware
>> load command to the chip via my driver, since its already handled by the
>> kernels firmware mechanism - attempting to do so should fail, IMO
> 
> Yes. These are legacy UART drivers. We try to phase these out.

I could look into the feasibility of filtering the command stream if you
are interested in a patch to that effect?

-Ian
