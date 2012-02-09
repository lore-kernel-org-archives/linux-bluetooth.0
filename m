Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328795351.28848.17.camel@aeonflux>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
	<1328795351.28848.17.camel@aeonflux>
Date: Thu, 9 Feb 2012 15:23:29 -0200
Message-ID: <CAA37ikZVxFvCjSbNcpA5_XSK7mLj3M6uZyqYGDOJhhmT9Y8t_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Advertising cache locking code refactoring
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <aguedespe@gmail.com>, linux-bluetooth@vger.kernel.org,
	andre.guedes@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 9, 2012 at 11:49 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch series does some code refactoring in advertising cache lockin=
g
>> related code. This work is a small effort to improve locking usage in
>> Bluetooth subsystem.
>>
>> BR,
>>
>> Andre
>>
>> Andre Guedes (3):
>> =A0 Bluetooth: Add prefix "__" to advertising cache functions
>> =A0 Bluetooth: Create thread-safe advertising cache functions
>> =A0 Bluetooth: Use advertising cache thread-safe functions
>>
>> =A0include/net/bluetooth/hci_core.h | =A0 =A04 +++
>> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 51 +++++++++++++++++++=
++++++++++++------
>> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 =A06 +---
>> =A04 files changed, 48 insertions(+), 15 deletions(-)
>
> so I looked through this patch series and the only useful patch is 1/3
> and even that one is kinda questionable. However if people in general
> find this a bit clearer that we prefix unlocked hdev functions with __,
> then I would be fine is it. Opinions anybody?

Not sure if you saw my replies. I said this series is not needed at
all IMO. And if we want to prefix unlocked hdev functions with __ then
we better change all of them to have everything consistent. And I'm
really against adding locked versions if we're not really using them.

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
