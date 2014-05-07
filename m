Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E4F0A858-85C9-4D2C-B716-4C58469A0465@holtmann.org>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CAHZ1yC=3GQJLcuKV4FwRKcHLY2C5xFsQJh1FVpvabBWTpfWsTg@mail.gmail.com>
	<E4F0A858-85C9-4D2C-B716-4C58469A0465@holtmann.org>
Date: Wed, 7 May 2014 12:55:08 -0700
Message-ID: <CAHZ1yC=FOajpzi3GwrHU=Jqb5KFMCTPp7RPw8G+8KLDGR9DxyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Update RSSI property description.
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 7, 2014 at 12:06 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

>>> RSSI property is inquiry RSSI and this should be stated here especially
>>> that we plan to add connection RSSI property soon.
>>
>> Does connection RSSI really need to be a separate property? Why can't
>> the same property be used for both? It's the same device after all.
>
> the problem is that they are different. They get measured differently. On=
e is essentially tight to the Inquiry TX power and the other to the TX powe=
r of the connection. Results will be different. This has always been the pr=
oblem with Bluetooth=E2=80=99s RSSI. Mapping the RSSI you got Extended Inqu=
iry Result to Read RSSI is not possible.
>

LE Devices aren't ever in a situation where they are Advertising
during a Connection though, right?

So either the RSSI + TX Power are relevant to Inquiry (when Connected
=3D false) or relevant to Connection (when Connected =3D true)


Since the Connection RSSI on a Classic device is always just deviation
from the golden range, the RSSI field isn't even that interesting in
those cases.

Scott
--=20
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
