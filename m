Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B6CE0C86-8DC9-45D1-8022-78ED9D83B96F@holtmann.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
	<1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
	<B6CE0C86-8DC9-45D1-8022-78ED9D83B96F@holtmann.org>
Date: Tue, 18 Feb 2014 15:08:06 -0300
Message-ID: <CAKT1EBdeyQDXbgu5iv3CC=XAE0j-dKVTOp8HMNuA7=xyK8ri0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 00/18] GATT API: External Services
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014 at 2:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
>> This patchset implements the minimal support for adding local services
>> declarations.
>>
>> Limitation: Remove services and multiple services exported by the same
>> remote will be implemented the next series.
>
> what is the deal with this unix socket you are using for local access? I think we should remove that functionality and keep it simple in the beginning.
>
> Regards
>
> Marcel

Testing purpose only to avoid breaking the current attribute server.
The fact is, the current attribute server "architecture" is not
flexible enough to support external services properly.
The idea is to get rid of the "old" attribute server when we finish
the new implementation.

Lizardo has some patches allowing compatibility between the two
versions. We will send new patchsets to remove the unix socket, and
introduce this compatibility.

Regards,
Claudio
