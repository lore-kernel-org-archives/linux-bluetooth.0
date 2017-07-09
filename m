Return-Path: <ian@mnementh.co.uk>
Subject: Re: [PATCH 1/3] bluetooth: Introduce hci_uart_unregister_device()
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 sebastian.reichel@collabora.co.uk, ohad@bencohen.org
References: <20170708163743.24394-1-ian@mnementh.co.uk>
 <20170708163743.24394-2-ian@mnementh.co.uk>
 <54BC1277-752D-41E1-9903-1A0207CBBAD9@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <79506af5-0015-e754-ccad-b93e4d8cec4b@mnementh.co.uk>
Date: Sun, 9 Jul 2017 09:46:07 +0100
MIME-Version: 1.0
In-Reply-To: <54BC1277-752D-41E1-9903-1A0207CBBAD9@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 20:59, Marcel Holtmann wrote:
> Hi Ian,
> 
>> Several drivers have the same (and incorrect) code in their
>> _remove() handler.
>>
>> Coalesce this into a shared function.
>>
>> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
>> ---
>> drivers/bluetooth/hci_serdev.c | 12 ++++++++++++
>> drivers/bluetooth/hci_uart.h   |  1 +
>> 2 files changed, 13 insertions(+)
> 
> all 3 patches have been applied to bluetooth-next tree.

Thanks Marcel and Sebastian, for the review / apply.

-Ian
