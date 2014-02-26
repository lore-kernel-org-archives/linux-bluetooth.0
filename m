Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <63DA7E43-4B20-4CF9-8539-3BBE1A7EBD21@holtmann.org>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1393404081-1401-2-git-send-email-jakub.tyszkowski@tieto.com> <63DA7E43-4B20-4CF9-8539-3BBE1A7EBD21@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 26 Feb 2014 12:34:29 +0100
Message-ID: <CAF3PWx18FXpEN7wxn6v3hncD_8nYdHs1J0Fevd7pOhQr=YuNVw@mail.gmail.com>
Subject: Re: [PATCHv2 01/23] android/hal-gatt-api: Add missing opcodes in GATT Service
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 26 February 2014 09:51, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> Add missing Listen and Set Advertising Data opcodes and reorder them as
>> they appear in HAL's headers.
>
> I left this out originally since they are only useful for when we are a p=
eripheral. Curious to know if Android APIs actually support this.

It does, but not as public API - internal apps can still use them but
only if platform has config_bluetooth_le_peripheral_mode_supported
flag set, so perhaps this is for some gadgets running Android.

> GATT client and server are valid for central role. And the connect/discon=
nect need to be turned into being one pair of commands. No point in duplica=
ting them. There is really no difference between a GATT client and server c=
onnect. The central will connect to the peripheral. Unless Android got full=
y confused and uses the APIs wrongly.

These commands are separated for client and server since they have
either client or server app id as parameter which is later used to
dispatch callbacks to proper application. So using one pair of
commands (and single notification) we can still figure out which
callback to use in HAL as long as we have 'type' parameter for app id.

BR,
Andrzej
