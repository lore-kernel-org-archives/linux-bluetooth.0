Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312984225.3373.118.camel@aeonflux>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	<1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
	<1312984225.3373.118.camel@aeonflux>
Date: Wed, 10 Aug 2011 10:42:17 -0400
Message-ID: <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Andre,

On Wed, Aug 10, 2011 at 9:50 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch adds a new parameter to mgmt_device_found() to inform
>> the length of 'eir' pointer.
>>
>> EIR data from LE advertising report event doesn't have a fixed length
>> as EIR data from extended inquiry result event does. We needed to
>> change mgmt_device_found() so it copies 'eir_len' bytes instead of
>> HCI_MAX_EIR_LENGTH.
>
> what is the max EIR length for LE? Is it more than with BR/EDR. Or is it
> just variable length?

>From page 1735:

"The data consists of a significant part and a non-significant part.
[...] The non-significant part extends the Advertising and Scan
Response data to 31 octets and shall contain all-zero octets."

So actually it is not variable length, it has 31 octets, with the
non-significant part zero padded. BR/EDR EIR, on the other hand is 240
bytes (with zero padding for non-significant part as well)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
